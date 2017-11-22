package com.codebrew.moana.service.purchase.impl;

import java.awt.image.BufferedImage;
import java.io.BufferedReader;
import java.io.File;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.io.Writer;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;

import javax.imageio.ImageIO;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Repository;

import com.codebrew.moana.common.CommonUtil;
import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Bank;
import com.codebrew.moana.service.domain.PartyMember;
import com.codebrew.moana.service.domain.Purchase;
import com.codebrew.moana.service.domain.QRCode;
import com.codebrew.moana.service.domain.Ticket;
import com.codebrew.moana.service.domain.User;
import com.codebrew.moana.service.party.PartyDAO;
import com.codebrew.moana.service.purchase.PurchaseDAO;
import com.codebrew.moana.service.ticket.TicketDAO;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.client.j2se.MatrixToImageConfig;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;

@Repository("purchaseDAOImpl")
public class PurchaseDAOImpl implements PurchaseDAO {

	//Field
	@Autowired
	@Qualifier("sqlSessionTemplate")
	SqlSession sqlSession;
	
	@Autowired
	@Qualifier("ticketDAOImpl")
	private TicketDAO ticketDAO;
	
	@Autowired
	@Qualifier("partyDAOImpl")
	private PartyDAO partyDAO;
	
	@Value("#{imageRepositoryProperties['qrCode']}")
	private String qrCodePath;


	//Constructor
	public PurchaseDAOImpl() {
		System.out.println(this.getClass());
	}

	// Method
	@Override
	public int addPurchase(Purchase purchase, String path) throws Exception {
		String flag = purchase.getTicket().getTicketFlag();
		System.out.println("@@@@@@@@@@"+flag);
		Ticket ticket = ticketDAO.getTicketByTicketNo(purchase.getTicket().getTicketNo());
		// 기본티켓, 무료티켓일때
		if (ticket.getTicketFlag() == null || ticket.getTicketFlag().equals("free")) {

			// 원래 티켓 수량
			//int originTicketCount = purchase.getTicket().getTicketCount();
			//ticket = ticketDAO.getTicketByTicketNo(purchase.getTicket().getTicketNo());
			int originTicketCount =ticket.getTicketCount();
			
			// 구매할 티켓 수량
			int purchaseTicketCount = purchase.getPurchaseCount();
			purchase.getTicket().setTicketCount(originTicketCount - purchaseTicketCount);
			// 원래수량 - 구매수량 으로 티켓수량 업데이트
			ticketDAO.updateTicketCount(purchase.getTicket());
		}
		if(purchase.getPurchaseFlag().equals("2")) {
			System.out.println("@@@@@@@@@파티티켓구매!!!!!@@@@@@@@@");
			PartyMember partyMember = new PartyMember();
			User user = purchase.getUser();
			partyMember.setAge(user.getAge());
			partyMember.setGender(user.getGender());
			partyMember.setRole("guest");
			partyMember.setUser(user);
			if(purchase.getTicket().getParty() != null) {
				partyMember.setParty(purchase.getTicket().getParty());
			} else {
				partyMember.setParty(ticket.getParty());
			}
			partyDAO.joinParty(partyMember);
		}
		sqlSession.insert("PurchaseMapper.addPurchase", purchase);
		purchase.setQrCode(this.createQRCode(path, purchase.getPurchaseNo()));
		return sqlSession.update("PurchaseMapper.updateQrCode", purchase);
	}

	@Override
	public Purchase getPurchase(int purchaseNo) {
		Purchase purchase = sqlSession.selectOne("PurchaseMapper.getPurchase", purchaseNo);
		String purchasePrice = CommonUtil.toAmountStr(purchase.getPurchasePrice()+"");
		purchase.setPrice(purchasePrice);
		return purchase;
	}
	
	@Override
	public int getPurchaseNo(String userId, int partyNo) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", userId);
		map.put("partyNo", partyNo);
		Purchase purchase =  sqlSession.selectOne("PurchaseMapper.getPurchaseNo", map);
		return purchase.getPurchaseNo();
	}

	@Override
	public List<Purchase> getPurchaseList(String userId, String purchaseFlag, Search search) {
		System.out.println(search);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", userId);
		map.put("search", search);
		List<Purchase> list = null;
		if(purchaseFlag == null) {
			purchaseFlag = "";
		}
		switch (purchaseFlag) {
			case "1":
				list = sqlSession.selectList("PurchaseMapper.getFestivalPurchaseList", map);
				break;
			case "2":
				list = sqlSession.selectList("PurchaseMapper.getPartyPurchaseList", map);
				break;
			default : 
				list = sqlSession.selectList("PurchaseMapper.getPurchaseList", map);
				break;
		}
		for(Purchase purchase : list) {
			String purchasePrice = CommonUtil.toAmountStr(purchase.getPurchasePrice()+"");
			purchase.setPrice(purchasePrice);
		}
		return list;
	}

	@Override
	public List<Purchase> getSaleList(Search search) {
		List<Purchase> list = sqlSession.selectList("PurchaseMapper.getSaleList", search);
		for(Purchase purchase : list) {
			String purchasePrice = CommonUtil.toAmountStr(purchase.getPurchasePrice()+"");
			purchase.setPrice(purchasePrice);
		}
		return list;
	}

	@Override
	public int updatePurchaseTranCode(Purchase purchase) throws Exception {
			
		Ticket ticket = ticketDAO.getTicketByTicketNo(purchase.getTicket().getTicketNo());
		int updateTicketResult = 0;
		// 무제한티켓이 아닐때 수량 업뎃
		if (ticket.getTicketFlag() == null || ticket.getTicketFlag().equals("free")) {
			
			System.out.println("@ @ @ 무료티켓 or 기본티켓 @ @ @ @ ");
			int plusCount = ticket.getTicketCount() + purchase.getPurchaseCount();
			ticket.setTicketCount(plusCount);

			updateTicketResult = ticketDAO.updateTicketCount(ticket);
		}
			if (purchase.getPurchaseFlag().equals("2")) {
				System.out.println("@ @ @ 파티티켓이라 캔슬파티! @ @ @");
				partyDAO.cancelParty(ticket.getParty().getPartyNo(), purchase.getUser().getUserId());
			}
		return sqlSession.update("PurchaseMapper.updatePurchaseTranCode", purchase);
	}

	@Override
	public int deletePurchase(int purchaseNo) {
		return sqlSession.update("PurchaseMapper.updatePurchaseDeleteFlag", purchaseNo);
	}

	//create qrcode image
	@Override
	public QRCode createQRCode(String path, int purchaseNo) {
		QRCode qrCode = null;
		try {
			File file = null;
			File serverFile = null;
			// 파일경로
			System.out.println("from properties [path] : "+qrCodePath);
			System.out.println("from session [path] : "+path);
			
			file = new File(qrCodePath);
			serverFile = new File(path);
			if (!file.exists()) {
				file.mkdirs();
			}
			String url = "http://192.168.0.13:8080/purchase/getPurchase?purchaseNo="+purchaseNo;
			//String url = "http://192.168.0.13:8080";
			qrCode = new QRCode();
			qrCode.setQrCodeResult(url);
			//code
			String codeurl = new String(url.getBytes("UTF-8"), "ISO-8859-1");
			// qrcode color
			// int qrcodeColor = 00000000;
			// bgcolor
			// int backgroundColor = 0xFFFFFFFF;

			QRCodeWriter qrCodeWriter = new QRCodeWriter();
			// parameter width, height
			BitMatrix bitMatrix = qrCodeWriter.encode(codeurl, BarcodeFormat.QR_CODE, 200, 200);
			//
			MatrixToImageConfig matrixToImageConfig = new MatrixToImageConfig();
			BufferedImage bufferedImage = MatrixToImageWriter.toBufferedImage(bitMatrix, matrixToImageConfig);
			
			//file name randomly
			long time = System.currentTimeMillis();
			int random = (int)(Math.random()*1000000);
			
			String fileName = ""+time+random+"qrcode.png"; 
			String src = qrCodePath+"\\"+fileName;
			String serverSrc = path+"\\"+fileName;
			qrCode.setQrCodeImage(fileName);
			// ImageIO png write
			ImageIO.write(bufferedImage, "png", new File(src));
			ImageIO.write(bufferedImage, "png", new File(serverSrc));

		} catch (Exception e) {
			e.printStackTrace();
		}
		return qrCode;
	}
	
	@Override
	public int getTotalCount(String userId, Search search) {
		System.out.println(search);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("userId", userId);
		return sqlSession.selectOne("PurchaseMapper.getTotalCount", map);
	}

	
	// Method(KakaoPay)
	@Override
	public Purchase readyPayment(Purchase purchase) {
		return null;
	}

	@Override
	public Purchase approvePayment(String pgToken) {
		return null;
	}

	@Override
	public int cancelPayment(Purchase purchase) {
		return 0;
	}

	@Override
	public Purchase approvePayment(Purchase purchase, String token) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Purchase readyTransfer(Purchase purchase) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Purchase transferMoney(Bank bank, Purchase purchase) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Map<String, Object> getTransferResult(Bank bank, Purchase purchase) {
		// TODO Auto-generated method stub
		return null;
	}


}

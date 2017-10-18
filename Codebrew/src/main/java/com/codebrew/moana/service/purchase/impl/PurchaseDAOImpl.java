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

import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Purchase;
import com.codebrew.moana.service.domain.QRCode;
import com.codebrew.moana.service.purchase.PurchaseDAO;
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
	
	@Value("#{imageRepositoryProperties['qrCode']}")
	private String qrCodePath;
	

	private Purchase purchase;
	public static final String ISO_8601_24H_FULL_FORMAT = "yyyy-MM-dd'T'HH:mm:ss";

	//Constructor
	public PurchaseDAOImpl() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass());
	}

	// Method
	@Override
	public int addPurchase(Purchase purchase) {
		return sqlSession.insert("PurchaseMapper.addPurchase", purchase);
	}

	@Override
	public Purchase getPurchase(int purchaseNo) {
		return sqlSession.selectOne("PurchaseMapper.getPurchase", purchaseNo);
	}

	@Override
	public List<Purchase> getPurchaseList(String userId, String purchaseFlag, Search search) {
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
		return list;
	}

	@Override
	public List<Purchase> getSaleList(Search search) {
		return sqlSession.selectList("PurchaseMapper.getSaleList", search);
	}

	@Override
	public int updatePurchaseTranCode(Purchase purchase) {
		return sqlSession.update("PurchaseMapper.updatePurchaseTranCode", purchase);
	}

	@Override
	public int deletePurchase(int purchaseNo) {
		return sqlSession.update("PurchaseMapper.updatePurchaseDeleteFlag", purchaseNo);
	}

	@Override
	public Purchase readyPayment(Purchase purchase) {

		System.out.println("[KakaoPayDAOImpl] : " + purchase);

		String kakaoPayOpenAPIURL = "https://kapi.kakao.com/v1/payment/ready";

		try {

			URL url = new URL(kakaoPayOpenAPIURL);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("POST");
			con.setRequestProperty("Authorization", "KakaoAK d724824032139f17d0d222f4abd50495");
			con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
			con.setRequestProperty("charset", "utf-8");
			con.setDoOutput(true);

			Map<String, Object> map = new HashMap<String, Object>();
			map.put("cid", "TC0ONETIME");
			map.put("partner_order_id", "partner_order_id");
			map.put("partner_user_id", "partner_user_id");
			map.put("item_name", purchase.getItemName()); //축제명or파티명
			map.put("approval_url", "http://127.0.0.1:8080/purchase/approvePayment");
			map.put("fail_url", "http://127.0.0.1:8080/kakaoPay/failKakaoPay.jsp");
			map.put("cancel_url", "http://127.0.0.1:8080/kakaoPay/cancelKakaoPay.jsp");
			map.put("user_phone_number", "01030343783");
			map.put("quantity", new Integer(purchase.getPurchaseCount()));
			map.put("total_amount", new Integer(purchase.getPurchasePrice()));
			map.put("tax_free_amount", new Integer(0));

			Writer writer = new OutputStreamWriter(con.getOutputStream());
			writer.write(mapToParams(map));
			writer.flush();

			int responseCode = con.getResponseCode();

			BufferedReader br = null;

			if (responseCode == 200) {
				br = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
			} else { 
				br = new BufferedReader(new InputStreamReader(con.getErrorStream(), "UTF-8"));
			}

			JSONObject jsonObject = (JSONObject) JSONValue.parse(br);
			System.out.println("mapping json : " + jsonObject);

			purchase.setTid(jsonObject.get("tid").toString());
			purchase.setPaymentNo(jsonObject.get("tid").toString());
			purchase.setNextRedirectPcUrl(jsonObject.get("next_redirect_pc_url").toString());
			purchase.setNextRedirectMobileUrl(jsonObject.get("next_redirect_mobile_url").toString());
			this.setPurchase(purchase);

			System.out.println("binding purchase : " + purchase);

			// ObjectMapper objectMapper = new ObjectMapper();
			// String json = objectMapper.writeValueAsString(kakaoPay);
			// System.out.println("json���� ���� : " + json);
			br.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return purchase;
	}

	@Override
	public Purchase approvePayment(String pgToken) {

		String kakaoPayOpenAPIURL = "https://kapi.kakao.com/v1/payment/approve";
		// Purchase purchase = null;
		Purchase purchase = this.getPurchaseDomain();
		System.out.println("approve purchase : " + purchase);
		try {
			URL url = new URL(kakaoPayOpenAPIURL);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("POST");
			con.setRequestProperty("Authorization", "KakaoAK d724824032139f17d0d222f4abd50495");
			con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
			con.setRequestProperty("charset", "utf-8");
			con.setDoOutput(true);

			// purchase = new Purchase();
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("cid", "TC0ONETIME");
			map.put("tid", this.purchase.getTid());
			map.put("partner_order_id", "partner_order_id");
			map.put("partner_user_id", "partner_user_id");
			map.put("pg_token", pgToken);

			Writer writer = new OutputStreamWriter(con.getOutputStream());
			writer.write(mapToParams(map));
			writer.flush();

			// Response Code GET
			int responseCode = con.getResponseCode();

			BufferedReader br = null;

			if (responseCode == 200) {
				br = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
			} else { // ���� �߻�
				br = new BufferedReader(new InputStreamReader(con.getErrorStream(), "UTF-8"));
			}

			JSONObject jsonObject = (JSONObject) JSONValue.parse(br);
			System.out.println("mapping�� ���̽�  : " + jsonObject);

			purchase.setAid(jsonObject.get("aid").toString());
			purchase.setPaymentNo(jsonObject.get("tid").toString());
			purchase.setTid(jsonObject.get("tid").toString());
			purchase.setCid(jsonObject.get("cid").toString());
			purchase.setPartnetOrderId(jsonObject.get("partner_order_id").toString());
			purchase.setPartnerUserId(jsonObject.get("partner_user_id").toString());
			purchase.setPaymentMethodType(jsonObject.get("payment_method_type").toString());
			purchase.setItemName(jsonObject.get("item_name").toString());
			purchase.setPurchaseCount(new Integer(jsonObject.get("quantity").toString()));

			Map amount = new HashMap();
			amount = (Map) jsonObject.get("amount");
			purchase.setPurchasePrice(new Integer(amount.get("total").toString()));

			long unixSeconds = 1372339860;
			Date date = new Date(unixSeconds * 1000L);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
			// GMT
			sdf.setTimeZone(TimeZone.getTimeZone("GMT+9"));
			String formattedDate = sdf.format(date);
			date = sdf.parse(jsonObject.get("approved_at").toString());
			System.out.println(formattedDate);
			System.out.println(date.toString());

			SimpleDateFormat origin = new SimpleDateFormat(ISO_8601_24H_FULL_FORMAT);
			// SimpleDateFormat origin = new SimpleDateFormat("yyyy-MM-dd");
			// SimpleDateFormat origin2 = new SimpleDateFormat("HH:mm:ss");
			// Date date = origin.parse(jsonObject.get("approved_at").toString());
			// Date date2 = origin2.parse(jsonObject.get("approved_at").toString());
			purchase.setPurchaseDate(date);
			// purchase.setPurchaseDate(jsonObject.get("approved_at").toString());
			System.out.println(date.toString());
			// System.out.println(date2.getTime());

			//purchase.setQrCode(this.createQRCode());

			switch (purchase.getPurchaseFlag()) {
			case "1": //festival
				// purchase.setFestival(this.getPurchaseDomain().getFestival());
				break;
			case "2": //party
				// purchase.setParty(this.getPurchaseDomain().getParty());
				break;
			}
			// kakaoPay.setApproved_at(new Date(jsonObject.get("approved_at").toString()));
			// this.setPurchase(purchase);

			System.out.println("binding purchase : " + purchase);

			// ObjectMapper objectMapper = new ObjectMapper();
			// String json = objectMapper.writeValueAsString(kakaoPay);
			// System.out.println("json���� ���� : " + json);
			br.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return purchase;
	}

	@Override
	public Purchase cancelPayment(Purchase purchase) {

		System.out.println("[cancelPayment] : ");

		String kakaoPayOpenAPIURL = "https://kapi.kakao.com/v1/payment/cancel";
		System.out.println(purchase);
		try {

			URL url = new URL(kakaoPayOpenAPIURL);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("POST");
			con.setRequestProperty("Authorization", "KakaoAK d724824032139f17d0d222f4abd50495");
			con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
			con.setRequestProperty("charset", "utf-8");
			con.setDoOutput(true);

			Map<String, Object> map = new HashMap<String, Object>();
			map.put("cid", "TC0ONETIME");
			map.put("tid", purchase.getPaymentNo());
			map.put("cancel_amount", new Integer(purchase.getPurchasePrice()));
			map.put("cancel_tax_free_amount", new Integer(0));

			Writer writer = new OutputStreamWriter(con.getOutputStream());
			writer.write(mapToParams(map));
			writer.flush();

			int responseCode = con.getResponseCode();

			BufferedReader br = null;

			if (responseCode == 200) {
				br = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
			} else { // 
				br = new BufferedReader(new InputStreamReader(con.getErrorStream(), "UTF-8"));
			}

			JSONObject jsonObject = (JSONObject) JSONValue.parse(br);
			System.out.println("mapping json  : " + jsonObject);

			if (jsonObject.get("status").equals("CANCEL_PAYMENT")) {
				System.out.println("결제취소");
				purchase.setTranCode("2"); //2 : 결제취소
			}
			purchase.setAid(jsonObject.get("aid").toString());
			purchase.setPaymentNo(jsonObject.get("tid").toString());
			purchase.setCid(jsonObject.get("cid").toString());
			purchase.setPartnetOrderId(jsonObject.get("partner_order_id").toString());
			purchase.setPartnerUserId(jsonObject.get("partner_user_id").toString());
			purchase.setPaymentMethodType(jsonObject.get("payment_method_type").toString());
			purchase.setItemName(jsonObject.get("item_name").toString());
			purchase.setPurchaseCount(new Integer(jsonObject.get("quantity").toString()));

			Map amount = new HashMap();
			amount = (Map) jsonObject.get("amount");
			purchase.setPurchasePrice(new Integer(amount.get("total").toString()));

			SimpleDateFormat origin = new SimpleDateFormat(ISO_8601_24H_FULL_FORMAT);
			Date date = origin.parse(jsonObject.get("canceled_at").toString()); // 결제취소시각
			purchase.setPurchaseDate(date);
			// purchase.setPurchaseDate(jsonObject.get("canceled_at").toString());
			System.out.println(origin);
			System.out.println(date.toString());

			System.out.println("binding purchase: " + purchase);

			// ObjectMapper objectMapper = new ObjectMapper();
			// String json = objectMapper.writeValueAsString(kakaoPay);
			// System.out.println("json���� ���� : " + json);
			br.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return purchase;

	}
	
	@Override
	public int getTotalCount(String userId, Search search) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("userId", userId);
		return sqlSession.selectOne("PurchaseMapper.getTotalCount", map);
	}

	//create qrcode image
	@Override
	public QRCode createQRCode() {
		QRCode qrCode = null;
		try {
			File file = null;
			// 파일경로
			System.out.println("from properties [path] : "+qrCodePath);
			file = new File(qrCodePath);
			if (!file.exists()) {
				file.mkdirs();
			}
			String url = "http://127.0.0.1:8080/view/purchase/getPurchase.jsp";
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
			qrCode.setQrCodeImage(fileName);
			// ImageIO png write
			ImageIO.write(bufferedImage, "png", new File(src));

		} catch (Exception e) {
			e.printStackTrace();
		}
		return qrCode;
	}

	// getter, setter
	public void setPurchase(Purchase purchase) {
		this.purchase = purchase;
	}

	public Purchase getPurchaseDomain() {
		return this.purchase;
	}

	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	//map To Params
	public static String mapToParams(Map<String, Object> map) {
		StringBuilder paramBuilder = new StringBuilder();
		for (String key : map.keySet()) {
			paramBuilder.append(paramBuilder.length() > 0 ? "&" : "");
			try {
				paramBuilder.append(String.format("%s=%s", URLEncoder.encode(key, "UTF-8"),
						URLEncoder.encode(map.get(key).toString(), "UTF-8")));
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return paramBuilder.toString();
	}

}

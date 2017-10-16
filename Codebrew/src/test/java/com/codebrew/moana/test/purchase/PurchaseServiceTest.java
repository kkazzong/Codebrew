package com.codebrew.moana.test.purchase;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.junit.Assert;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.codebrew.moana.service.domain.Festival;
import com.codebrew.moana.service.domain.Party;
import com.codebrew.moana.service.domain.Purchase;
import com.codebrew.moana.service.domain.QRCode;
import com.codebrew.moana.service.domain.Ticket;
import com.codebrew.moana.service.domain.User;
import com.codebrew.moana.service.purchase.PurchaseDAO;

/*
 *	FileName :  PurchaseServiceTest.java
 * JUnit4 (Test Framework) 
 */
@RunWith(SpringJUnit4ClassRunner.class)

@ContextConfiguration(locations = { "classpath:config/context-*.xml" })

// @ContextConfiguration(locations = { "classpath:config/context-common.xml" })
public class PurchaseServiceTest {

	@Autowired
	@Qualifier("purchaseDAOImpl")
	PurchaseDAO purchaseDAO;

	//@Test
	public void testAddPurchase() throws Exception {

		User user = new User();
		//user.setUserId("lgj1522@gmail.com");
		//user.setUserId("abc123@ab.com");
		//user.setUserId("longclock@abc.com");

		Festival festival = new Festival();
		// festival.setFestivalNo(10001); // 2017 �Ҳ� ����
		// festival.setFestivalName("2017 �Ҳ� ����");
		festival.setFestivalNo(10002); // ���� ���� ����

		Party party = new Party();
		// party.setPartyNo(10000); // ������ ��Ƽ
		party.setPartyNo(10001); // �������� ����
		
		Ticket ticket = new Ticket();
		ticket.setTicketNo(10046);
		
		Purchase purchase = new Purchase();
		purchase.setUser(user);
		//purchase.setFestival(festival);
		// purchase.setParty(party);
		purchase.setTicket(ticket);
		purchase.setTid("abcdefg1235");
		purchase.setPaymentMethodType("CARD");
		purchase.setItemName(festival.getFestivalName());
		// purchase.setItemName(party.getPartyName());
		SimpleDateFormat origin = new SimpleDateFormat("yyyy-mm-dd");
		Date date = origin.parse("2017-11-18");
		//purchase.setPurchaseDate(date);
		purchase.setPurchaseCount(3);
		purchase.setPurchasePrice(30000);
		purchase.setTranCode("1");

		QRCode qrCode = new QRCode();
		qrCode.setQrCodeImage("qrcode.png");
		qrCode.setQrCodeResult("http://112");
		purchase.setQrCode(qrCode);

		int result = purchaseDAO.addPurchase(purchase);

		Assert.assertEquals(1, result);
	}

	//@Test
	public void getPurchase() {

		int purchaseNo = 10080;

		Purchase purchase = purchaseDAO.getPurchase(purchaseNo);

		Assert.assertEquals(3, purchase.getPurchaseCount());
		//Assert.assertEquals("longclock@abc.com", purchase.getUser().getUserId());
		Assert.assertEquals(30000, purchase.getPurchasePrice());
		//Assert.assertEquals(10002, purchase.getFestival().getFestivalNo());
		//Assert.assertNull(purchase.getParty());
	}

	//@Test
	public void getPurchaseList() {

		String userId = "lgj1522@gmail.com";
		String purchaseFlag = "1";

		//List<Purchase> list = purchaseDAO.getPurchaseList(userId, purchaseFlag);

		//Assert.assertEquals(1, list.size());
	}

	// @Test
	public void updatePurchaseTranCode() {

		Purchase purchase = new Purchase();
		purchase.setPurchaseNo(10033);
		purchase.setTranCode("2");

		int result = purchaseDAO.updatePurchaseTranCode(purchase);
		Purchase returnPurchase = purchaseDAO.getPurchase(purchase.getPurchaseNo());
		Assert.assertEquals(1, result);
		Assert.assertEquals(purchase.getPurchaseNo(), returnPurchase.getPurchaseNo());
		Assert.assertEquals(purchase.getTranCode(), returnPurchase.getTranCode());
	}

	// @Test
	public void updatePurchaseDeleteFlag() {

		int purchaseNo = 10033;

		int result = purchaseDAO.deletePurchase(purchaseNo);
		Purchase returnPurchase = purchaseDAO.getPurchase(purchaseNo);
		Assert.assertEquals(1, result);
		Assert.assertNull(returnPurchase);
	}
}
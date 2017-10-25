package com.codebrew.moana.service.purchase.impl;

import java.io.BufferedReader;
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

import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Purchase;
import com.codebrew.moana.service.domain.QRCode;
import com.codebrew.moana.service.purchase.PurchaseDAO;

@Repository("kakaoAPIDAOImpl")
public class KakaoAPIDAOImpl implements PurchaseDAO {

	//Field
	@Autowired
	@Qualifier("purchaseDAOImpl")
	PurchaseDAO purchaseDAO;
	
	private Purchase purchase;
	public static final String ISO_8601_24H_FULL_FORMAT = "yyyy-MM-dd'T'HH:mm:ss";
	
	//Constructor
	public KakaoAPIDAOImpl() {
		System.out.println(this.getClass());
	}

	//Method (KakaoPay)
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
			map.put("cancel_url", "http://127.0.0.1:8080/purchase/cancelPayment");
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
			br.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return purchase;
	}

	@Override
	public Purchase approvePayment(String pgToken) {
		
		String kakaoPayOpenAPIURL = "https://kapi.kakao.com/v1/payment/approve";
		Purchase purchase = this.getPurchase();
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
			} else { // 오류
				br = new BufferedReader(new InputStreamReader(con.getErrorStream(), "UTF-8"));
			}

			JSONObject jsonObject = (JSONObject) JSONValue.parse(br);
			System.out.println("mapping  : " + jsonObject);

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
			date = sdf.parse(jsonObject.get("approved_at").toString());
			String formattedDate = sdf.format(date);
			formattedDate = formattedDate.replaceAll("T", " ");
			System.out.println(formattedDate);
			System.out.println(date.toString());
			purchase.setPurchaseDate(formattedDate);
			System.out.println(date.toString());

			System.out.println("binding purchase : " + purchase);
			br.close();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return purchase;
	}

	@Override
	public int cancelPayment(Purchase purchase) {
		System.out.println("[cancelPayment] : ");
		
		String kakaoPayOpenAPIURL = "https://kapi.kakao.com/v1/payment/cancel";
		System.out.println(purchase);
		int updatePurchaseResult = 0;
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
			purchase.setPurchaseDate(date.toString());
			System.out.println(origin);
			System.out.println(date.toString());
			
			System.out.println("binding purchase: " + purchase);

			br.close();
			
			purchase.setTranCode("2");
			
			updatePurchaseResult = purchaseDAO.updatePurchaseTranCode(purchase);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return updatePurchaseResult;
	}
	
	//Method (DB)
	@Override
	public int addPurchase(Purchase purchase, String path) throws Exception {
		return 0;
	}

	@Override
	public Purchase getPurchase(int purchaseNo) {
		return null;
	}

	@Override
	public List<Purchase> getPurchaseList(String userId, String purchaseFlag, Search search) {
		return null;
	}

	@Override
	public List<Purchase> getSaleList(Search search) {
		return null;
	}

	@Override
	public int updatePurchaseTranCode(Purchase purchase) throws Exception {
		return 0;
	}

	@Override
	public int deletePurchase(int purchaseNo) {
		return 0;
	}

	@Override
	public int getTotalCount(String userId, Search search) {
		return 0;
	}

	@Override
	public QRCode createQRCode(String path, int purchaseNo) {
		return null;
	}
	
	// map To Params
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

	//getter, setter
	public Purchase getPurchase() {
		return purchase;
	}

	public void setPurchase(Purchase purchase) {
		this.purchase = purchase;
	}
	
	

}

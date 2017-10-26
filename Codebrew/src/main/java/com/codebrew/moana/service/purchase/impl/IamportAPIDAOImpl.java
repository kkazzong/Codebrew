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
import org.springframework.stereotype.Repository;

import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Bank;
import com.codebrew.moana.service.domain.Purchase;
import com.codebrew.moana.service.domain.QRCode;
import com.codebrew.moana.service.purchase.PurchaseDAO;

@Repository("iamportAPIDAOImpl")
public class IamportAPIDAOImpl implements PurchaseDAO {

	//Field
	
	//Constructor
	public IamportAPIDAOImpl() {
		System.out.println(this.getClass());
	}
	
	//method
	public String getIamportToken() {
		
		String iamportOpenAPIURL = "https://api.iamport.kr/users/getToken";
		Purchase purchase = null;
		
		try {

			Map<String, Object> map = new HashMap<String, Object>();
			map.put("imp_key", "3969119433085281");
			map.put("imp_secret", "sMRRZJCiIffQmefKzjz9zrfiQ6wRun1XaSP9CrrkHHb3WrNvKnFjOUCF19wvwytGriP3JhorYzuU0iqL");
			

			URL url = new URL(iamportOpenAPIURL);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("POST");
			con.setRequestProperty("Authorization", "");
			con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
			con.setRequestProperty("charset", "utf-8");
			con.setDoOutput(true);


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
			
			purchase = new Purchase();
			purchase.setToken(((Map)jsonObject.get("response")).get("access_token").toString());
			

			System.out.println("binding purchase : ");
			br.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return purchase.getToken();
	}
	
	@Override
	public Purchase approvePayment(Purchase purchase, String token) {
		
		System.out.println("@@Iamport @@ purchase"+purchase);
		
		String iamportOpenAPIURL = "https://api.iamport.kr/payments/find/"+purchase.getCid()+"/";
		token = this.getIamportToken();
		
		try {

			Map<String, Object> map = new HashMap<String, Object>();
			map.put("imp_key", "3969119433085281");
			map.put("imp_secret", "sMRRZJCiIffQmefKzjz9zrfiQ6wRun1XaSP9CrrkHHb3WrNvKnFjOUCF19wvwytGriP3JhorYzuU0iqL");
			

			URL url = new URL(iamportOpenAPIURL);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("POST");
			con.setRequestProperty("Authorization", token);
			con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
			con.setRequestProperty("charset", "utf-8");
			con.setDoOutput(true);


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
			
			//purchase.setToken(((Map)jsonObject.get("response")).get("access_token").toString());
			Map resultMap = (Map)jsonObject.get("response");
			purchase.setItemName(resultMap.get("name").toString());
			purchase.setTid(resultMap.get("pg_tid").toString());
			purchase.setPaymentNo(resultMap.get("pg_tid").toString());
			purchase.setPaymentMethodType(resultMap.get("pay_method").toString());
			
			//long unixSeconds = 1372339860;
			Date date = new Date((long)resultMap.get("paid_at") * 1000L);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			// GMT
			sdf.setTimeZone(TimeZone.getTimeZone("GMT+9"));
			//date = sdf.parse(resultMap.get("paid_at").toString());
			//String formattedDate = sdf.format(date);
			//formattedDate = formattedDate.replaceAll("T", " ");
			///System.out.println(formattedDate);
			System.out.println(date.toString());
			purchase.setPurchaseDate(sdf.format(date));
			System.out.println(date.toString());
			
			System.out.println("binding purchase : "+purchase);
			br.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return purchase;
		
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
	
	////////////////////////////////////////////KakaoPay//////////////////////////////////////////////////////
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

	/////////////////////////////////////////////DB/////////////////////////////////////////////////////////////////
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
	public QRCode createQRCode(String path, int purchaseNo) {
		return null;
	}

	@Override
	public int getTotalCount(String userId, Search search) {
		return 0;
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

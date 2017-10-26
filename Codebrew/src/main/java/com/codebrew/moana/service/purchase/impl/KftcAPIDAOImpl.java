package com.codebrew.moana.service.purchase.impl;

import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.io.Writer;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.stereotype.Repository;

import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Bank;
import com.codebrew.moana.service.domain.Purchase;
import com.codebrew.moana.service.domain.QRCode;
import com.codebrew.moana.service.purchase.PurchaseDAO;

import sun.security.krb5.internal.tools.Ktab;

@Repository("kftcAPIDAOImpl")
public class KftcAPIDAOImpl implements PurchaseDAO {

	//Field
	
	//Constructor
	public KftcAPIDAOImpl() {
		System.out.println(this.getClass());
	}
	
	
	//method
	
	//// 계좌이체 준비
	@Override
	public Bank readyTransfer(Purchase purchase) {
		
		String kftxOpenAPIURL = "https://testapi.open-platform.or.kr/oauth/2.0/token";
		String token = null;
		Bank bank = null;
		
		try {
			
			URL url = new URL(kftxOpenAPIURL);
			HttpURLConnection con = (HttpURLConnection)url.openConnection();
			con.setRequestMethod("POST");
			con.addRequestProperty("Content-Type", "application/x-www-form-urlencoded");
			con.setRequestProperty("charset", "utf-8");
			con.setDoOutput(true);
			con.setDoInput(true);
	
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("client_id", "l7xx0415fb96d6904cd39737d42b94dd847a");
			map.put("client_secret", "5bb9353e2732464f916ab308bd338935");
			map.put("grant_type", "client_credentials");
			map.put("scope", "oob");
	
			Writer writer = new OutputStreamWriter(con.getOutputStream());
			writer.write(mapToParams(map));
			writer.flush();
			
			int responseCode = con.getResponseCode();
	        
	        BufferedReader br = null;
	        
	        if(responseCode==200) { 
	            br = new BufferedReader(new InputStreamReader(con.getInputStream(),"UTF-8"));
	        } else {  // ���� �߻�
	            br = new BufferedReader(new InputStreamReader(con.getErrorStream(),"UTF-8"));
	        }
			
			JSONObject jsonObject = (JSONObject)JSONValue.parse(br);
			
			System.out.println("토큰요청결과-->"+jsonObject);
			token = jsonObject.get("access_token").toString();
			bank = new Bank();
			bank.setToken(token);
			
		} catch(Exception e) {
			
			e.printStackTrace();
		
		}
		return bank;
		
	}
	
	//// 계좌이체 실행
	@Override
	public Bank transferMoney(Bank bank, Purchase purchase) {
		
		String kftxOpenAPIURL = "https://testapi.open-platform.or.kr/v1.0/transfer/deposit2";
		//Bank bank = null;
		
		try {
			
			URL url = new URL(kftxOpenAPIURL);
			HttpURLConnection con =  (HttpURLConnection)url.openConnection();
			con.setRequestMethod("POST");
			con.setRequestProperty("Authorization", "Bearer "+bank.getToken());
			con.addRequestProperty("Content-Type", "application/json");
			con.setRequestProperty("charset", "utf-8");
			con.setDoOutput(true);
			con.setDoInput(true);
			
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("wd_pass_phrase", "NONE");
			jsonObject.put("wd_print_content", "출금계좌인자내역");
			jsonObject.put("req_cnt", "1");
			
			JSONObject jsonObject2 = new JSONObject();
			jsonObject2.put("tran_no", "1");
			jsonObject2.put("bank_code_std", "002");
			jsonObject2.put("account_num", "9876543210987654");
			jsonObject2.put("account_holder_name", "홍길동");
			jsonObject2.put("print_content", "오픈서비스캐시백");
			jsonObject2.put("tran_amt", "500");
			JSONArray jsonArray = new JSONArray();
			jsonArray.add(jsonObject2);
			
			jsonObject.put("req_list", jsonArray);
			jsonObject.put("tran_dtime", "20160310101921");
			
			//System.out.println("요청 : "+jsonObject.toString());
			
			BufferedOutputStream bos = new BufferedOutputStream(con.getOutputStream());
			bos.write(jsonObject.toJSONString().getBytes());
			bos.flush();
			bos.close();
			
			// Response Code GET
	        int responseCode = con.getResponseCode();
	        
	        BufferedReader br = null;
	        
	        if(responseCode==200) { 
	            br = new BufferedReader(new InputStreamReader(con.getInputStream(),"UTF-8"));
	        } else {  // ���� �߻�
	            br = new BufferedReader(new InputStreamReader(con.getErrorStream(),"UTF-8"));
	        }

	        JSONObject resultJson = (JSONObject)JSONValue.parse(br);
			System.out.println("이체 요청 결과 =======================\n");
			System.out.println(resultJson);
			
			List<HashMap<String, Object>> list = (List<HashMap<String, Object>>)resultJson.get("res_list");
			Map resultMap = new HashMap();
			resultMap.put("bank_tran_id", (list.get(0)).get("bank_tran_id"));
			resultMap.put("tran_date", (list.get(0)).get("bank_tran_date"));
			bank.setTranNo(resultMap.get("bank_tran_id").toString());
			bank.setTranDate(resultMap.get("tran_date").toString());
	    	br.close();
			
		} catch(Exception e) {
			
			e.printStackTrace();
		
		}
		return bank;
		
	}
	
	//// 계좌이체 결과 조회
	@Override
	public Map<String, Object> getTransferResult(Bank bank, Purchase purchase) {
		
		String kftxOpenAPIURL = "https://testapi.open-platform.or.kr/v1.0/transfer/result";
		StringBuilder responseBody = new StringBuilder();
		Map<String, Object> resultMap = null;
		//Bank bank = null;
		
		try {
			
			URL url = new URL(kftxOpenAPIURL);
			HttpURLConnection con =  (HttpURLConnection)url.openConnection();
			con.setRequestMethod("POST");
			con.setRequestProperty("Authorization", "Bearer "+bank.getToken());
			con.addRequestProperty("Content-Type", "application/json");
			con.setRequestProperty("charset", "utf-8");
			con.setDoOutput(true);
			con.setDoInput(true);
			
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("check_type", "2");
			jsonObject.put("req_cnt", "1");
			
			JSONObject jsonObject2 = new JSONObject();
			jsonObject2.put("tran_no", "1");
			jsonObject2.put("org_bank_tran_id", bank.getTranNo());
			jsonObject2.put("org_bank_tran_date", bank.getTranDate());
			jsonObject2.put("org_tran_amt", "500");
			JSONArray array = new JSONArray();
			array.add(jsonObject2);
			
			jsonObject.put("req_list", array);
			jsonObject.put("tran_dtime", "20160310101921");
			
			//System.out.println("요청 : "+jsonObject.toString());
			
			BufferedOutputStream bos = new BufferedOutputStream(con.getOutputStream());
			bos.write(jsonObject.toJSONString().getBytes());
			bos.flush();
			bos.close();

			BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			String line = null;
			while ((line = br.readLine()) != null) {
				responseBody.append(line);
			}
			System.out.println(responseBody.toString());
			br.close();
			
			resultMap = new HashMap<String, Object>();
			resultMap.put("bank", bank);
			resultMap.put("purchase", purchase);
			
		} catch (Exception e) {
			
			responseBody.append(e);
			
		}
		
		return resultMap;
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
	
	/////////////////////////////////////////////////KakaoPay///////////////////////////////////////////////////
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

	/////////////////////////////////////////////////iamport///////////////////////////////////////////////////
	@Override
	public Purchase approvePayment(Purchase purchase, String token) {
		return null;
	}
	
	/////////////////////////////////////////////////DB///////////////////////////////////////////////////
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

}

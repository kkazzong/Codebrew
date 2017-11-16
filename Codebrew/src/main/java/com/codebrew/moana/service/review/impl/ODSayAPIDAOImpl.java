package com.codebrew.moana.service.review.impl;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Good;
import com.codebrew.moana.service.domain.Image;
import com.codebrew.moana.service.domain.Review;
import com.codebrew.moana.service.domain.Video;
import com.codebrew.moana.service.review.ReviewDAO;


//TourAPIDAOImpl 참고
@Repository("ODSayAPIDAOImpl")
public class ODSayAPIDAOImpl implements ReviewDAO {
	
	///Field
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession){
		this.sqlSession = sqlSession;
	}
	
	///Constructor
	public ODSayAPIDAOImpl(){
		System.out.println(this.getClass());
	}
	
	//public Map<String, Object> getTransportListAtStation() throws Exception {
	
	@Override
	public Map<String, Object> getTransportListAtStation(double x, double y, int radius) throws Exception { //수정후에 method signature 이 문장으로 변경
		
		//예시
		/*x = 127.14120419999995; // x좌표 : longitude
		y = 37.5457299; //y 좌표 : latitude
		radius = 250; //반경
*/		
		StringBuilder urlBuilder = new StringBuilder("https://api.odsay.com/api"+"/pointSearch?x="+x+"&y="+y+"&radius="+radius+"&apiKey=9Y8umSFLTjBabpZyQD9MSJZ/GpAV/XJrRHAGwBVmguw"); //비트
		
		URL url = new URL(urlBuilder.toString());
		HttpURLConnection conn = (HttpURLConnection)url.openConnection();
		
		conn.setRequestMethod("GET");
		conn.setRequestProperty("Content-type", "application/json");
		
		System.out.println("Response Code :: "+conn.getResponseCode());
		
		BufferedReader rd;
		
		if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
			rd = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
		}else{
			rd = new BufferedReader(new InputStreamReader(conn.getErrorStream(), "UTF-8"));
		}
		StringBuilder sb = new StringBuilder();
		String line;
		while((line = rd.readLine()) != null){
			sb.append(line);
		}
		rd.close();
		conn.disconnect();
		
//		System.out.println(line);
//		System.out.println(rd);
//		System.out.println("\n\nsb :: \n"+sb);
		
		
		//return sb; //지금 테스트니까...리턴은 나중에
		
		JSONObject stationJsonObj = (JSONObject)JSONValue.parse(sb.toString()); //sb로 받은 것을 JSON형태의 Object로 변환하여 대입
//		System.out.println("\n\nstationInfoJsonObj :: \n"+stationJsonObj); // 확인출력
		
		JSONObject stationResultJsonObj = (JSONObject)stationJsonObj.get("result");
//		System.out.println("\n\nstationResultJsonObj :: \n"+stationResultJsonObj);
		
		JSONArray stationResultJsonArray = (JSONArray)stationResultJsonObj.get("station");
//		System.out.println("\n\nstationResultJsonArray :: "+stationResultJsonArray);
//		System.out.println("\n\nstationResultJsonArray.size() :: "+stationResultJsonArray.size());
		
//		int stationResultCountJson = Integer.parseInt(stationResultJsonObj.get("count").toString()); //위의 Array의 size() 와 동일하다 : 근데 이거 원래 dataType이 int인데? ㅅㅂ
//		System.out.println("\n\nstationResultCountJson :: \n"+stationResultCountJson);
		
		/*
		하나의 Array가 가지고 있는 정보 예시
		버스정류장 : {"x":127.1427,"y":37.54555,"stationName":"굽은다리역","nonstopStation":0,"stationClass":1,"stationID":196050}
		지하철역 : {"businfo":"","laneName":"수도권 5호선","x":127.14292,"laneCity":"수도권","y":37.545547,"stationName":"굽은다리","nonstopStation":0,"stationClass":2,"stationID":550}
		*/
		
		List<Integer> stationIDList = new ArrayList<Integer>();
		List<String> stationNameList = new ArrayList<String>();
		List<Integer> stationClassList = new ArrayList<Integer>(); //지하철역인지 버스정류장인지
		
		for (int i = 0; i < stationResultJsonArray.size(); i++){
			JSONObject returnStationJsonObj = (JSONObject)stationResultJsonArray.get(i);
//			System.out.println((i+1)+"번째 역은"+returnStationJsonObj.get("stationName")+returnStationJsonObj.get("stationID"));
			stationNameList.add(returnStationJsonObj.get("stationName").toString());
			stationIDList.add(Integer.parseInt(returnStationJsonObj.get("stationID").toString())); //없으면 추가
			stationClassList.add(Integer.parseInt(returnStationJsonObj.get("stationClass").toString())); //역의 클래스도 추가
			/*
			if(!stationIDList.contains(Integer.parseInt(returnJsonObj.get("stationID").toString()))){ //중복체크해서..
			}
			*/
		}
		
//		System.out.println("\n\nstationNameList.toString() :: \n"+stationNameList.toString());
//		System.out.println("\n\nstationIDList.toString() :: \n"+stationIDList.toString());
//		System.out.println("\n\nstationClassList.toString() :: \n"+stationClassList.toString());
		
		//////////////////**************************
		
		//정류장의 정보 : 정확히는 정류장을 지나가는? 버스No를 받기 위하여 다시한번 request
		List<String> busNoList = new ArrayList<String>();
		List<String> subwayList = new ArrayList<String>();
		
		/*
		버스노선 타입 현재 2017-11-16 기준 TTL : 16Type
		type	노선명	type	노선명
		1		일반		12		지선
		2		좌석		13		순환
		3		마을버스	14		광역
		4		직행좌석	15		급행
		5		공항버스	20		농어촌버스
		6		간선급행	21		제주도 시외형버스
		10		외곽		22		경기도 시외형버스
		11		간선		26		급행간선
		*/
		List<String> busNoList1 = new ArrayList<String>();
		List<String> busNoList2 = new ArrayList<String>();
		List<String> busNoList3 = new ArrayList<String>();
		List<String> busNoList4 = new ArrayList<String>();
		List<String> busNoList5 = new ArrayList<String>();
		List<String> busNoList6 = new ArrayList<String>();
		List<String> busNoList10 = new ArrayList<String>();
		List<String> busNoList11 = new ArrayList<String>();
		List<String> busNoList12 = new ArrayList<String>();
		List<String> busNoList13 = new ArrayList<String>();
		List<String> busNoList14 = new ArrayList<String>();
		List<String> busNoList15 = new ArrayList<String>();
		List<String> busNoList20 = new ArrayList<String>();
		List<String> busNoList21 = new ArrayList<String>();
		List<String> busNoList22 = new ArrayList<String>();
		List<String> busNoList26 = new ArrayList<String>();
		
//		System.out.println("stationClassList에서 값 빼오기 테스트 :: "+stationClassList.get(2));
		
		for(int i = 0; i < stationIDList.size(); i++){
			
			if(stationClassList.get(i) == 1){
				
				urlBuilder = new StringBuilder("https://api.odsay.com/api/"+"busStationInfo?stationID="+stationIDList.get(i)+"&apiKey=9Y8umSFLTjBabpZyQD9MSJZ/GpAV/XJrRHAGwBVmguw");
				url = new URL(urlBuilder.toString());
				conn = (HttpURLConnection)url.openConnection();
				
				conn.setRequestMethod("GET");
				conn.setRequestProperty("Content-type", "application/json");
				
//				System.out.println("Response Code :: "+conn.getResponseCode());
				
				if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
					rd = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
				}else{
					rd = new BufferedReader(new InputStreamReader(conn.getErrorStream(), "UTF-8"));
				}
				
				sb = new StringBuilder();
				while((line = rd.readLine()) != null){
					sb.append(line);
				}
				rd.close();
				conn.disconnect();
				
//				System.out.println(line);
//				System.out.println(rd);
//				System.out.println("\n\nsb :: \n"+sb);
		
				JSONObject busJsonObj = (JSONObject)JSONValue.parse(sb.toString()); //sb로 받은 것을 JSON형태의 Object로 변환하여 대입
//				System.out.println("\n\nbusJsonObj :: \n"+busJsonObj); // 확인출력
				
				JSONObject busResultJsonObj = (JSONObject)busJsonObj.get("result");
//				System.out.println("\n\nbusResultJsonObj :: \n"+busResultJsonObj);
				
				/*
				if(busResultJsonObj == null){
					continue;
				}
				 */
				
				JSONArray busResultJsonArray = (JSONArray)busResultJsonObj.get("lane");
//				System.out.println("\n\nbusResultJsonArray :: \n"+busResultJsonArray);
				
//				System.out.println("\n\nbusResultJsonArray.size() :: \n"+busResultJsonArray.size()+"\n");
				
				for(int j = 0; j < busResultJsonArray.size(); j++){ 
					JSONObject returnBusInfoJsonObj = (JSONObject)busResultJsonArray.get(j);
//					System.out.println("\n\n이 버스정류장을 지나는 버스 :: "+(i+1)+"번 째 버스번호 :: "+returnBusNoJsonObj.get("busNo"));
					
//					System.out.println("\nfor문안에 있는 버스하나의 타입 :: \n"+returnBusInfoJsonObj.get("type").toString()+"\n");
//					System.out.println("\nfor문안에 있는 버스하나의 넘버 :: \n"+returnBusInfoJsonObj.get("busNo").toString()+"\n");
					
					//busNoAndBusTypeMap.put(returnBusInfoJsonObj.get("type").toString(), returnBusInfoJsonObj.get("busNo").toString()); // map에 type와 busNo를 매핑하여 넣음
					
					if(!busNoList.contains(returnBusInfoJsonObj.get("busNo").toString())){ // 중복체크하여 없으면
						busNoList.add(returnBusInfoJsonObj.get("busNo").toString()); // add

						if(returnBusInfoJsonObj.get("type").toString().equals("1")){
							busNoList1.add(returnBusInfoJsonObj.get("busNo").toString());
						}else if(returnBusInfoJsonObj.get("type").toString().equals("2")){
							busNoList2.add(returnBusInfoJsonObj.get("busNo").toString());
						}else if(returnBusInfoJsonObj.get("type").toString().equals("3")){
							busNoList3.add(returnBusInfoJsonObj.get("busNo").toString());
						}else if(returnBusInfoJsonObj.get("type").toString().equals("4")){
							busNoList4.add(returnBusInfoJsonObj.get("busNo").toString());
						}else if(returnBusInfoJsonObj.get("type").toString().equals("5")){
							busNoList5.add(returnBusInfoJsonObj.get("busNo").toString());
						}else if(returnBusInfoJsonObj.get("type").toString().equals("6")){
							busNoList6.add(returnBusInfoJsonObj.get("busNo").toString());
						}else if(returnBusInfoJsonObj.get("type").toString().equals("10")){
							busNoList10.add(returnBusInfoJsonObj.get("busNo").toString());
						}else if(returnBusInfoJsonObj.get("type").toString().equals("11")){
							busNoList11.add(returnBusInfoJsonObj.get("busNo").toString());
						}else if(returnBusInfoJsonObj.get("type").toString().equals("12")){
							busNoList12.add(returnBusInfoJsonObj.get("busNo").toString());
						}else if(returnBusInfoJsonObj.get("type").toString().equals("13")){
							busNoList13.add(returnBusInfoJsonObj.get("busNo").toString());
						}else if(returnBusInfoJsonObj.get("type").toString().equals("14")){
							busNoList14.add(returnBusInfoJsonObj.get("busNo").toString());
						}else if(returnBusInfoJsonObj.get("type").toString().equals("15")){
							busNoList15.add(returnBusInfoJsonObj.get("busNo").toString());
						}else if(returnBusInfoJsonObj.get("type").toString().equals("20")){
							busNoList20.add(returnBusInfoJsonObj.get("busNo").toString());
						}else if(returnBusInfoJsonObj.get("type").toString().equals("21")){
							busNoList21.add(returnBusInfoJsonObj.get("busNo").toString());
						}else if(returnBusInfoJsonObj.get("type").toString().equals("22")){
							busNoList22.add(returnBusInfoJsonObj.get("busNo").toString());
						}else if(returnBusInfoJsonObj.get("type").toString() .equals("26")){
							busNoList26.add(returnBusInfoJsonObj.get("busNo").toString());
						}
						
					}
				}
				
				
			}else if(stationClassList.get(i) == 2){
				
				// https://api.odsay.com/api/subwayStationInfo?stationID=550
				
				urlBuilder = new StringBuilder("https://api.odsay.com/api/"+"subwayStationInfo?stationID="+stationIDList.get(i)+"&apiKey=9Y8umSFLTjBabpZyQD9MSJZ/GpAV/XJrRHAGwBVmguw");
				url = new URL(urlBuilder.toString());
				conn = (HttpURLConnection)url.openConnection();
				
				conn.setRequestMethod("GET");
				conn.setRequestProperty("Content-type", "application/json");
				
//				System.out.println("Response Code :: "+conn.getResponseCode());
				
				if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
					rd = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
				}else{
					rd = new BufferedReader(new InputStreamReader(conn.getErrorStream(), "UTF-8"));
				}
				
				sb = new StringBuilder();
				while((line = rd.readLine()) != null){
					sb.append(line);
				}
				rd.close();
				conn.disconnect();
				
//				System.out.println(line);
//				System.out.println(rd);
//				System.out.println("\n\nsb :: \n"+sb);
				
				JSONObject subwayJsonObj = (JSONObject)JSONValue.parse(sb.toString()); //sb로 받은 것을 JSON형태의 Object로 변환하여 대입 :: 사실 이게 bus 정보가 아니다...
//				System.out.println("\n\nsubwayJsonObj :: \n"+subwayJsonObj); // 확인출력
				
				JSONObject subwayResultJsonObj = (JSONObject)subwayJsonObj.get("result");
//				System.out.println("\n\nsubwayResultJsonObj :: \n"+subwayResultJsonObj);
				
				
				String laneNameSubwayResultJSonObj = (String)subwayResultJsonObj.get("laneName");
//				System.out.println("\n\nlaneNameSubwayResultJSonObj :: \n"+laneNameSubwayResultJSonObj);
				subwayList.add(laneNameSubwayResultJSonObj);
				
				/*
				JSONArray subwayResultJsonArray = (JSONArray)subwayResultJsonObj.get("laneName");
				System.out.println("\n\nsubwayResultJsonArray :: \n"+subwayResultJsonArray);

				for(int j = 0; j < subwayResultJsonArray.size(); j++){
					JSONObject returnSubwayJsonObj = (JSONObject)subwayResultJsonArray.get(j);
					System.out.println("\n\n이 버스정류장을 지나는 버스 :: "+(i+1)+"번 째 버스번호 :: "+returnSubwayJsonObj.get("busNo"));
					if(!subwayList.contains(returnSubwayJsonObj.get("busNo").toString())){ // 중복체크
						subwayList.add(returnSubwayJsonObj.get("busNo").toString()); // add
					}
				}
				*/
				
			}
		}
		
//		System.out.println("\n\nbusNoList :: \n"+busNoList.toString());
//		System.out.println("\n\nsubwayList :: \n"+subwayList.toString());
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("stationNameList", stationNameList);
		map.put("stationIDList", stationIDList);
		map.put("subwayList", subwayList);
		//map.put("busNoList", busNoList);
		map.put("busNoList1", busNoList1);
		map.put("busNoList2", busNoList2);
		map.put("busNoList3", busNoList3);
		map.put("busNoList4", busNoList4);
		map.put("busNoList5", busNoList5);
		map.put("busNoList6", busNoList6);
		map.put("busNoList10", busNoList10);
		map.put("busNoList11", busNoList11);
		map.put("busNoList12", busNoList12);
		map.put("busNoList13", busNoList13);
		map.put("busNoList14", busNoList14);
		map.put("busNoList15", busNoList15);
		map.put("busNoList20", busNoList20);
		map.put("busNoList21", busNoList21);
		map.put("busNoList22", busNoList22);
		map.put("busNoList26", busNoList26);
		
		return map;
	
	}

	@Override
	public void addReview(Review review) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public Review getReview(int reviewNo) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateReview(Review review) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteReview(int reviewNo) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<Review> getReviewList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Review> getMyReviewList(Search search, String userId) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Review> getCheckReviewList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void deleteReviewImage(int reviewNo) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteReviewVideo(int reviewNo) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void passCheckCode(Review review) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void failCheckCode(Review review) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void addGood(Good good) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteGood(Good good) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public Good checkGood(Good good) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Good getGood(String userId, int reviewNo) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int getTotalCount(Search search) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int getMyReviewTotalCount(Search search, String userId) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int getCheckReviewTotalCount(Search search) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public void uploadReviewImage(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void uploadReviewHashtag(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void uploadReviewVideo(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<Image> getReviewImage(int reviewNo) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Video> getReviewVideo(int reviewNo) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateReviewGoodCount(Good good) throws Exception {
		// TODO Auto-generated method stub
		
	}

	

}
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
				
				for(int j = 0; j < busResultJsonArray.size(); j++){
					JSONObject returnBusNoJsonObj = (JSONObject)busResultJsonArray.get(j);
//					System.out.println("\n\n이 버스정류장을 지나는 버스 :: "+(i+1)+"번 째 버스번호 :: "+returnBusNoJsonObj.get("busNo"));
					if(!busNoList.contains(returnBusNoJsonObj.get("busNo").toString())){ // 중복체크
						busNoList.add(returnBusNoJsonObj.get("busNo").toString()); // add
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
		map.put("busNoList", busNoList);
		map.put("subwayList", subwayList);
		
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
package com.codebrew.moana.service.user.impl;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Date;
import java.util.List;

import org.codehaus.jackson.JsonNode;
import org.codehaus.jackson.map.ObjectMapper;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.stereotype.Repository;

import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.User;
import com.codebrew.moana.service.user.UserDAO;

@Repository("kakaoLoginDAOImpl")//이거해줘야 seviceImpl에서 @Qulifier가 먹힘
public class KakaoLoginDAOImpl implements UserDAO {

	
	
	public KakaoLoginDAOImpl() {
		System.out.println(this.getClass());
	}
	
	@Override
	public User getCode(String authorize_code) throws Exception{
		//GET /oauth/authorize?client_id={app_key}&redirect_uri={redirect_uri}&response_type=code HTTP/1.1
		//Host: kauth.kakao.com
		
			final String RestApiKey="955d3e922ae1873da417ed0cd3e4c008";
			
		
			final String Redirect_URL="127.0.0.1:8080/kakaoLogin";
			
			final String keyHost="https://kapi.kakao.com/v1/user/me";
			
	//javaAPI를 이용해서 HttpRequest
		URL url=new URL(keyHost);
		HttpURLConnection con=(HttpURLConnection)url.openConnection();
		con.setDoInput(true);
		con.setDoOutput(true);
		con.setRequestMethod("POST");
		
		con.setRequestProperty("Content_Type","multipart/form-data"); 
		con.setRequestProperty("charset", "UTF-8");
		con.setRequestProperty("Authorization", "Bearer "+ authorize_code);//토큰값으로 받음
		//con.setRequestProperty("Authorization","KakaoAK"+authorize_code);//헤더에 담을 정보
	

		
		//Response Code 받아오기
		 int responseCode=con.getResponseCode();
		
		BufferedReader br=null;//연결이 끊긴 상태
		
		if(responseCode==200) {
			br=new BufferedReader(new InputStreamReader(con.getInputStream()));
		}else {//에러가 발생한다면?
			br=new BufferedReader(new InputStreamReader(con.getErrorStream()));
		}
		
        //JsonNode userInfo= (JsonNode)JSONValue.parse(br);
		
		ObjectMapper mapper = new ObjectMapper();
	    JsonNode userInfo = mapper.readTree(br.readLine());
		
		System.out.println("제이슨 오브젝트"+userInfo);
		
		User user=new User();//순서순서
		
		user.setUserId(userInfo.get("kaccount_email").asText());
		
		JsonNode properties = userInfo.path("properties");
		
		user.setUserName(properties.path("nickname").asText());
		
		user.setProfileImage(properties.path("profile_image").asText());
		//user.setAge(properties.path("age").asInt());
		//user.setAge(Integer.parseInt((properties.path("age").asText())));//java.lang.NumberFormatException: For input string: "" 에러남
		user.setGender(properties.path("gender").asText());
		//user.setPhone(properties.path("phone").asText());
		
		/*JSONObject jsonObject = (JSONObject)JSONValue.parse(br);
		
		System.out.println("제이슨 오브젝트"+jsonObject);
		
		
	
		System.out.println("요건?"+jsonObject.get("kaccount_email").toString());
		
		User user=new User();//순서순서!!!!!!!!!!!!!!!!!
		user.setUserId(jsonObject.get("kaccount_email").toString());
		user.setUserName(jsonObject.get("properties").get("nickname").toString());
		user.setAge(Integer.parseInt(jsonObject.get("age").toString()));
		user.setBirth(Date.valueOf(jsonObject.get("birth").toString()));
		user.setPhone(jsonObject.get("phone").toString());
		user.setGender(jsonObject.get("gender").toString());
		user.setProfileImage(jsonObject.get("profileImage").toString());
		System.out.println(user);
		*/
		

        br.close();
       
       
		return user;

		
		

		
		}

	
	@Override
	public void addUser(User user) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public User getUser(String userId) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<User> getUserList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateUser(User user) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteUser(User user) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public User checkNickname(String nickname) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public User findUserId(User user) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int getTotalCount(Search search) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public String randomNumber(int number) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	
	@Override
	public void updateCoconut(User user)throws Exception{
		// TODO Auto-generated method stub
		
	}

}

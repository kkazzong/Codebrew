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
//클래스 하나 만들어 줬고
	
	
	public KakaoLoginDAOImpl() {
		System.out.println(this.getClass());
	}
	
	@Override
	public User getCode(String authorize_code) throws Exception{
		//GET /oauth/authorize?client_id={app_key}&redirect_uri={redirect_uri}&response_type=code HTTP/1.1
		//Host: kauth.kakao.com
		
			final String RestApiKey="955d3e922ae1873da417ed0cd3e4c008";
			
			//private동일한 패키지, 다른 패키지여도 전부 접근불가능한 제일 쎈 접근제한자,외부에 드러나면 안되니깐
			//static 공용의 변수를 만들때  사용되는 예약어,카카오 이클래스 안에서만큼은 공용으로 사용하려구
			//final 상속불가 하거나 변할수 없는 상수에 선언
			final String Redirect_URL="127.0.0.1:8080/kakaoLogin";
			//controller에서 코드를 요청할때 코드를 받는 주소 설정
			final String keyHost="https://kapi.kakao.com/v1/user/me";
				
			//URI uri=new URIBuilder().setScheme("http").setHost("url").setPath("/path").setParameter("param","value").build();
			//HttpGet httpget=new HttpCet(uri)
			
			
		 /*String //우리가 요청할 사람
		          getCode +="/oauth/authorize?client_id="+RestApiKey;
		          getCode +="&redirect_uri="+Redirect_URL;
		          getCode +="&response_type=code";*/
			
	   /*final String params = String.format("grant_type=authorization_code&client_id=%s&redirect_uri=%s&",
			   RestApiKey, Redirect_URL) + "&code=code";*/
		
	//javaAPI를 이용해서 HttpRequest
		URL url=new URL(keyHost);
		HttpURLConnection con=(HttpURLConnection)url.openConnection();
		con.setDoInput(true);
		con.setDoOutput(true);
		con.setRequestMethod("POST");
		//con.setRequestProperty("Content_Type","application/json"); 
		//con.setRequestProperty("Content_Type","application/x-www-form-urlencoded"); 
		con.setRequestProperty("Content_Type","multipart/form-data"); 
		con.setRequestProperty("charset", "UTF-8");
		con.setRequestProperty("Authorization", "Bearer "+ authorize_code);//토큰값으로 받음
		//con.setRequestProperty("Authorization","KakaoAK"+authorize_code);//헤더에 담을 정보
	
	/*	Map<String,Object>map=new HashMap<String,Object>();
		map.put("target_id_type", "gender");
		map.put("profile_Image", "profileImage");
		map.put("age", "age");
	
		
		OutputStreamWriter writer=new OutputStreamWriter(con.getOutputStream());
		writer.write(mapToParams(map));//헤더 전송
		writer.flush();*/
		
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
		
//		user.setUserId(jsonObject.get("kaccount_email").toString());
//		user.setUserName(jsonObject.get("nickname").toString());
//		
//		System.out.println("유저아이디가 들어왔는지"+user.getUserId());
		
		//JsonNode userInfo=(JsonNode)JSONValue.parse(br);
		//System.out.println(userInfo);
		
		//JSONData 읽기===================이렇게 해두 제이슨형태로 옴
		//String info="";//빈바구니 상태로 세팅
		
		//int i ;System.out.println(i);//primitive 타입이라0 default
		
		/*StringBuffer buffer=new StringBuffer();
		String info="";
		while((info=br.readLine()) !=null) {
			
		 buffer.append(info);
		}
		*/
		//br.close();//정보 다 받으면 io 연결 끊음
		
		//con.disconnect();//HttpURLConnection연결두 끊음
		
		//System.out.println("이건 뭐야:"+response.toString());
		
		
		//JsonNode userInfo=(JsonNode)JSONValue.parse(buffer.toString());
		
        //System.out.println("유저인포가 이쁘게 들어왔을까?"+buffer.toString());//null이 들어오는데???
		
		//String userId=userInfo.get("kaccount_email").toString();
		
        //String userId=userInfo.get("kaccount_email").toString();
        
    
   
        //JSONObject jsonobj = (JSONObject) JSONValue.parse(buffer.toString());
		//JSONObject jsonobj2 = (JSONObject) jsonobj.get("properties");
		//String jsonobj3 = (jsonobj.get("properties").toString());
		//JSONObject jsonobj4 = (JSONObject) jsonobj3.get("profi");
		//JSONObject jsonobj5 = (JSONObject) jsonobj4.get("item");
        
        
        /*System.out.println("제이슨 정보는?"+buffer);
        
        
        User user=new User();
        user.setUserId(buffer.toString().get)
         */
        //JSONObject jsonobject=
        
        //System.out.println(userId);
        
        
        //String userId=id.toString();
        
		/*JsonNode properties=userInfo.path("properties");
		
		String nickname=properties.path("nickname").asText();
		String gender=properties.path("gender").asText();
		String age=properties.path("age").asText();
		String profileImage=properties.path("profileImage").asText();
		
		System.out.println(nickname+gender+age+profileImage);*/
		
		//ObjectMapper objectMapper=new ObjectMapper();
		//User user=objectMapper.readValue(userId, User.class);
		
		/*User user=new User();
		user.setUserId(kakaoId);
		user.setUserName(nickname);
		user.setAge(Integer.parseInt(age));
		user.setGender(gender);
		user.setProfileImage(profileImage);
		*/
        br.close();
       
       
		return user;

		
		

		
		}
	

	
	/*public static String mapToParams(Map<String, Object> map) {
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
	}*/
		

	
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


}

package com.codebrew.moana.service.user.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.internet.MimeMessage;

import org.codehaus.jackson.JsonNode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Auth;
import com.codebrew.moana.service.domain.User;

import com.codebrew.moana.service.user.UserDAO;
import com.codebrew.moana.service.user.UserService;

@Service("userServiceImpl")//Qualifiler로 di될 이름 지정
public class UserServiceImpl implements UserService{

	@Autowired
	@Qualifier("userDAOImpl")//UserDAO userDAO=new UserDAOImpl();
	private UserDAO userDAO;
	public void setUserDAO(UserDAO userDAO) {
		this.userDAO=userDAO;
	}
	
	@Autowired
	@Qualifier("kakaoLoginDAOImpl") 
	private UserDAO kakaoLoginDAO;//UserDAO kakaoLoginDAO=new KakaoDAOImpl();
	public void setKaKaoLoginDAO(UserDAO kakaoLoginDAO) {
		this.kakaoLoginDAO=kakaoLoginDAO;
	}
	
	
	
	
	@Autowired
	private JavaMailSender mailSender;
	
	
		
	public UserServiceImpl() {
		System.out.println(this.getClass());
		
	}
	


	@Value("#{sendMailProperties['setFrom']}")
	String setFrom;
	
	@Value("#{sendMailProperties['subject']}")
	String subject;
	
	@Value("#{sendMailProperties['contentPwd']}")
	String contentPwd;
	
	@Value("#{sendMailProperties['contentAuth']}")
	String contentAuth;
	
	@Value("#{sendMailProperties['contentAdd']}")
	String contentAdd;
	
	@Value("#{sendMailProperties['content2']}")
	String content2;
	
	/*@Value("#{sendMailProperties['props']}")
	Properties props;
	*/
	
	

	@Override
	public void addUser(User user) throws Exception {
		// TODO Auto-generated method stub
		userDAO.addUser(user);
		
		
		try {
			MimeMessage message=mailSender.createMimeMessage();
		    MimeMessageHelper messageHelper=new MimeMessageHelper(message,true,"UTF-8");
		    
		    messageHelper.setFrom(setFrom);
		    messageHelper.setTo(user.getUserId());
		    messageHelper.setSubject(subject);
		    messageHelper.setText(user.getUserName()+contentAdd);
		    
		    mailSender.send(message);
		}catch(Exception e) {
			
			System.out.println(e);
		    
		    
		}
		
		
		
		
	}

	@Override
	public User getUser(String userId) throws Exception {
		// TODO Auto-generated method stub
		return userDAO.getUser(userId);
	}

	@Override
	public Map<String,Object> getUserList(Search search) throws Exception {
		// TODO Auto-generated method stub
		List<User> list=userDAO.getUserList(search);
		int totalCount=userDAO.getTotalCount(search);
		
		Map<String, Object> map=new HashMap<String,Object>();
		map.put("list", list);
		map.put("totalCount", totalCount);
		
		return map;
	}

	@Override
	public void updateUser(User user) throws Exception {
		// TODO Auto-generated method stub
		userDAO.updateUser(user);
		
	}

	@Override
	public void deleteUser(User user) throws Exception {
		// TODO Auto-generated method stub
		userDAO.deleteUser(user);
		
	}

	@Override
	public boolean checkNickname(String nickname) throws Exception {
		// TODO Auto-generated method stub
		
		boolean result=true;
		
		User user=userDAO.checkNickname(nickname);
		
		if(user !=null) {//존재하는 닉네임이 있으니깐 쓰면 안되서 false
		return false;
	}
		
		return result;
	}
		

	@Override
	public boolean checkUserId(String userId) throws Exception {
		// TODO Auto-generated method stub
		
		boolean result=true;
		
		User user=userDAO.getUser(userId);
		
		if(user != null) { //존재하는 아이디가 있는거니깐 false
		return false;
	}

		return result;
	}
		
	
	@Override
	public void findPwd(User user)throws Exception{
	
		 
	 
	   
	    //임시비밀번호생성	    
	    String password = userDAO.randomNumber(5);
	    
	    user=userDAO.getUser(user.getUserId());
	    
	    user.setPassword(password);
	    userDAO.updateUser(user);
	    
	    System.out.println("비번바뀐 유저정보는??" + user);
	  
	    //String content = "\n\n test :: 임시비밀번호보내기\n\n임시비밀번호는 \"" + password + "\" 입니다.\n반드시 로그인 후 비밀번호를 수정해주세요!";
	    
	    try {
	      MimeMessage message = mailSender.createMimeMessage();
	      
	     //메일폼 방식은 2가지임
	      //simpleMailMessage: 오로지 String 으로 메일 보낼때만
	      //MimeMessage:html,첨부파일등 다양한 폼의 메일 보내구 싶을때
	      
	      //javaMailSenderImpe 안에 있는.createMimeMessage()를 통해 새로운 mimemessage인스턴스생성
	      //javaMailSenerderImpl안에 Public MimeMessage CerateMimeMassage() throws Exception{} 있는거
	      //=userService.addUser(); 랑 같다고 보믄 됨
	      
	      //JavaMailSender mailSender = new JavaMailSenderImpl();
          //set.sender.setHost("smtp.naver.com"); SMTP 서버에서 인증이 필요할때 설정하는 값들
	      // Properties prop = new Properties();SMTP와 관련된 세션을 생성하기 위해서 SMTP서버와 관련된 정보 지정
	      // prop.setProperty("mail.smtp.auth", "true"); 
	     // sender.setJavaMailProperties(prop);//여기까지의 과정을 프로퍼티에 저장해놈
	      
	      //properties클래스 사용해서 세션을 생성할때 필요한 값을 설정하고 javax.mail.Session을 사용하여 세션을 생성한다
          //javaMail 메일과 관련된 모든 작업을 처리하기 위해서는 세션을 먼저 생성해야 한다.
	      //Session session=Session.getDefaultInstance(props, authenticator);
	      
	      //javax.mail.AuthenticationFailedException: 535 5.7.1 Username and Password not accepted 9+0ovge2TIq7k8N74XWkCw - nsmtp
	      //new javax.mail.Authenticator() 는 Authenticator auth = new SMTPAuthenticator(id,pwd);

	    /*  Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
	    		protected PasswordAuthentication getPasswordAuthentication() {
	    		return new PasswordAuthentication(setFrom, setPwd);
	    		}
	    		});
	      */
	   

	  
	      
	      //스프링프레임워트에서 제공하는 Helper를 이용해서 좀 더 직관적인 메서드 이름과 편리한 인터페이스로 MimeMessage를 작성할 수 있게해주는거
	      //원래는 message.setFrom(new InternetAddress("codebrew@naver.com"));이런식으로 귀찮게 써줘야됨
            MimeMessageHelper messageHelper 
	                        = new MimeMessageHelper(message, true, "UTF-8");//true는 멀티파트메세지가 필요할때
	 
	      messageHelper.setFrom(setFrom); //보내는 사람
	      messageHelper.setTo(user.getUserId());     
	      messageHelper.setSubject(subject); //메일제목
	      messageHelper.setText(contentPwd +password+content2);  //메일 내용
	     
	      mailSender.send(message);
	    } catch(Exception e){
	     
	    	System.out.println(e);
	    }
	   
	   
	  }
	
	
	
	//본인인증
     public Auth confirmUser(Auth auth)throws Exception{
 

 	    //인증번호 넣기	    
 	    String authCode = userDAO.randomNumber(5);
 	    
 	    auth.setAuthCode(authCode);
 	    
 	     System.out.println("바뀐 Auth정보"+auth);
 	  
 	    
 	    
 	    try {
 	      MimeMessage message = mailSender.createMimeMessage();
 	      MimeMessageHelper messageHelper 
 	                        = new MimeMessageHelper(message, true, "UTF-8");
 	 
 	      messageHelper.setFrom(setFrom); //보내는 사람
 	      messageHelper.setTo(auth.getAuthId());     
 	      messageHelper.setSubject(subject); //메일제목
 	      messageHelper.setText(contentAuth+authCode+content2);//메일 내용
 	     
 	      mailSender.send(message);
 	    } catch(Exception e){
 	     
 	    	System.out.println(e);
 	    }
		
 	    
 	    
 	    return auth;
 	   
 	   
 	  }
	  
  
	@Override
	public User findUserId(User user) throws Exception {
		// TODO Auto-generated method stub
		return userDAO.findUserId(user);
	}

	//카카오로그인
	@Override
	public User getCode(String authorize_code) throws Exception {
		// TODO Auto-generated method stub
		//return userDAO.getCode(authorize_code);//userDAO는 변수명이었음
		return kakaoLoginDAO.getCode(authorize_code);
	}

	
	
	
	
	/*public User getCode(String authorize_code) throws Exception{
		
		
		JsonNode userInfo=userDAO.getCode(authorize_code);
		
		System.out.println(userInfo);
		
		
		
		//get 정보 빼내기
		//String id=userInfo.path("id").asText();
		String kakaoId=userInfo.path("kaccount_email").asText();
		
		JsonNode properties=userInfo.path("properties");
		
		String nickname=properties.path("nickname").asText();
		String gender=properties.path("gender").asText();
		String age=properties.path("age").asText();
		String profileImage=properties.path("profileImage").asText();
		
		User user=new User();
		user.setUserId(kakaoId);
		user.setUserName(nickname);
		user.setAge(Integer.parseInt(age));
		user.setGender(gender);
		user.setProfileImage(profileImage);
		
		
		return user;
		
	}

	*/

	
}

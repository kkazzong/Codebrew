package com.codebrew.moana.web.user;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.codebrew.moana.service.domain.User;
import com.codebrew.moana.service.user.UserService;

@RestController
@RequestMapping("/userRest/*")
public class UserRestController {
	
	
	//field
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;

	public UserRestController() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass());
	}
	
	//api로 로그인할때 필요한 getUser()
	@RequestMapping(value="json/getUser/{userId}", method=RequestMethod.GET)
	public User getUser(@PathVariable String userId)throws Exception{
		
		System.out.println("/user/json/getUser : GET");
		
		return userService.getUser(userId);
		
	}
	
	//api로그인할때 필요한 login() 폼으로 받을거니깐 post
	@RequestMapping(value="json/login", method=RequestMethod.POST)
	public User login(@RequestBody User user, HttpSession session)throws Exception{
	
		System.out.println("/user/json/login : POST");
		
		User dbUser=userService.getUser(user.getUserId());
		//user:내가 입력한 정보  /dbUser:디비에서 가져온 정보  / session 세션에 담고 있는 정보
		if(user.getPassword().equals(dbUser.getPassword())) {
	     session.setAttribute("user", user);
	     //"user"는 jsp에서 name으로 쓸 예정 ㅋㅋ
		}
		
		return dbUser;
	
	}
	

	@RequestMapping(value="json/checkNickname", method=RequestMethod.POST)
	public boolean checkNickname(@RequestParam("nickname")String nickname)throws Exception{
		
		System.out.println("/userRest/json/checkNickname : POST");
		//required=false은 모지?
		//new boolean(result)가 모였지?
		//비즈니스로직 Boolean은 왜 안되지??
		boolean result=userService.checkNickname(nickname);
		
		return result;
	}
	
	@RequestMapping(value="json/checkUserId", method=RequestMethod.POST)
	public boolean checkUserId(@RequestParam("userId")String userId)throws Exception{
		
		System.out.println("/userRest/json/checkUserId : POST ");
		
		boolean result=userService.checkUserId(userId);
		
		return result;
		
	}
	
	@RequestMapping(value="json/locateUser", method=RequestMethod.POST)
	public User locateUser(@RequestBody User user, HttpSession session)throws Exception{
		
		System.out.println("/userRest/json/locateUser : POST");
		
		String sessionId=((User)session.getAttribute("user")).getUserId();
		
		if(sessionId.equals(user.getUserId())) {
	
		session.setAttribute("user", user);
		}
		
		return user;
  }
}
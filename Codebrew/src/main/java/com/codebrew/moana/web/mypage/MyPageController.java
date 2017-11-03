package com.codebrew.moana.web.mypage;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Follow;
import com.codebrew.moana.service.domain.User;
import com.codebrew.moana.service.follow.FollowService;
import com.codebrew.moana.service.user.UserService;

@Controller
@RequestMapping("/myPage/*")
public class MyPageController {

	//field
	@Autowired
	@Qualifier("followServiceImpl")
	private FollowService followService;
	
	
	@Autowired
	@Qualifier("userServiceImpl")
    private UserService userService;	
	
	
	
	public MyPageController() {
		System.out.println(this.getClass());
	}

	@RequestMapping(value="getFollowingList", method=RequestMethod.GET)
	public ModelAndView getFollowingList(@ModelAttribute("search")Search search, HttpSession session,
			      @RequestParam(value="requestId", required=false)String requestId )throws Exception{
		
		System.out.println("/myPage/getFollowingList : GET");
		
		
		String sessionId="";
		if(session.getAttribute("user") !=null) {
		
			sessionId=((User)session.getAttribute("user")).getUserId();
		}
		
		System.out.println("세션아디는???"+sessionId);
		System.out.println("리퀘스트아이디는???"+requestId);
		
		  if(requestId !=null) {
			
			if(sessionId.indexOf("requestId")== -1) {
				sessionId=requestId;
			}
			
		}
		
		  System.out.println("세션아디가 뭘로 변했나??"+sessionId);//리퀘스트 아이디로 변함 
		  
		User user=userService.getUser(sessionId);//내가 팔로우 하려는 유저정보
		
		//Follow follow=followService.getFollow(responseId, requestId)
		
		
		System.out.println("누구로 검색하고 있는지...user 도메인에 있는 사람은 누구????"+user);
		
		Map<String, Object>map=followService.getFollowingList(search, sessionId);
		
		ModelAndView modelAndView=new ModelAndView();
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("user", user);
		modelAndView.setViewName("forward:/view/mypage/getFollowingList.jsp");
		
		return modelAndView;
	}
	
	
	
	

	@RequestMapping(value="getFollowerList", method=RequestMethod.GET)
	public ModelAndView getFollowerList(@ModelAttribute("search")Search search, HttpSession session,
			      @RequestParam(value="requestId", required=false)String requestId )throws Exception{
		
		
		System.out.println("/myPage/getFollowerList : GET");
		
		String sessionId="";
		if(session.getAttribute("user") !=null) {
		
			sessionId=((User)session.getAttribute("user")).getUserId();
		}
		
		System.out.println("세션아디는???"+sessionId);
		System.out.println("리퀘스트아이디는???"+requestId);
		
		  if(requestId !=null) {
			
			if(sessionId.indexOf("requestId")== -1) {
				sessionId=requestId;
			}
			
		}
		
		  
		  System.out.println("세션아디가 뭘로 변했나??"+sessionId);//리퀘스트 아이디로 변함 
		User user=userService.getUser(sessionId);
		
		
		
		System.out.println("누구로 검색하고 있는지...user 도메인에 있는 사람은 누구????"+user);
		Map<String, Object>map=followService.getFollowingList(search, sessionId);
		
		ModelAndView modelAndView=new ModelAndView();
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("user", user);
		modelAndView.setViewName("forward:/view/mypage/getFollowerList.jsp");
		
		return modelAndView;
	}
	
	@RequestMapping(value="getMyPage", method=RequestMethod.GET)
	public ModelAndView getMyPage(@RequestParam("requestId")String requestId,HttpSession session
			,@ModelAttribute("user")User user)throws Exception{
	
		System.out.println("/myPage/getMyPage : GET");
		
		//Follow follow=followService.getFollow(responseId, requestId);
		
	    Map<String, Object>map=new HashMap<String, Object>();
	    map.put("requestId", requestId);
	    map.put("sessionId", ((User)session.getAttribute("user")).getUserId());
		
	   
	   
		String sessionId="";
		if(session.getAttribute("user") !=null) {
		
			sessionId=((User)session.getAttribute("user")).getUserId();
		}
		
		System.out.println("세션아디는???"+sessionId);
		System.out.println("리퀘스트아이디는???"+requestId);
		  if(requestId !=null) {//팔로잉 하는 사람이 있으면
			
			if(sessionId.indexOf("requestId")== -1) {
				sessionId=requestId;
			}
			
		}
		
		System.out.println("세션아디가 뭘로 변했나??"+sessionId);
		  
		user=userService.getUser(sessionId);
		
	
		ModelAndView modelAndView=new ModelAndView();
		modelAndView.addObject("user", user);
		modelAndView.setViewName("forward:/view/mypage/getMyPage.jsp");
		
		return modelAndView;
		
	
}
}
package com.codebrew.moana.web.mypage;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.codebrew.moana.service.domain.Follow;
import com.codebrew.moana.service.domain.User;
import com.codebrew.moana.service.follow.FollowService;

@RestController
@RequestMapping("/myPageRest/*")
public class MyPageRestController {

	@Autowired
	@Qualifier("followServiceImpl")
	private FollowService followService;
	
	
	
	
	
	public MyPageRestController() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass());
		
	}

	@RequestMapping(value="json/addFollow/{requestId:.+}", method=RequestMethod.GET)
	public void addFollow(@PathVariable String requestId, HttpSession session, Model model)throws Exception{
		
		System.out.println("myPageRest/json/addFollow : GET");
		
		String sessionId=((User)session.getAttribute("user")).getUserId();
		
		if(sessionId != requestId) {
		followService.addFollow(sessionId, requestId);
		Follow follow= followService.getFollow(sessionId, requestId);
		
		model.addAttribute("follow", follow);//?? Follow로 보내면 왜 안될까??
		
		}	
}
	
	@RequestMapping(value="json/deleteFollow/{requestId}", method=RequestMethod.GET)
	public void deleteFollow(@PathVariable String requestId, HttpSession session)throws Exception{
		
		System.out.println("myPageRest/json/deleteFollow: GET");
		
		String sessionId=((User)session.getAttribute("user")).getUserId();
		
		followService.deleteFollow(sessionId, requestId);
	}
		
		
		
	


}
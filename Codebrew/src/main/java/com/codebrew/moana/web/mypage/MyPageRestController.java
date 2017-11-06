package com.codebrew.moana.web.mypage;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Follow;
import com.codebrew.moana.service.domain.User;
import com.codebrew.moana.service.follow.FollowService;
import com.codebrew.moana.service.user.UserService;

@RestController
@RequestMapping("/myPageRest/*")
public class MyPageRestController {

	@Autowired
	@Qualifier("followServiceImpl")
	private FollowService followService;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	@Value("#{commonProperties['pageSize']}")
	private int pageSize;
	
	@Value("#{commonProperties['pageUnit']}")
	private int pageUnit;
	
	
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
		
	
	
	@RequestMapping(value="json/getFollowingList/{requestId}", method=RequestMethod.GET)
	public Map<String,Object> getFollowingList(@ModelAttribute("search")Search search, HttpSession session,
			@PathVariable String requestId)throws Exception{
		
		System.out.println("/myPageRest/json/getFollowingList : GET");
		
		
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
		
		System.out.println("다른 사람꺼 볼때 리스트에 잘 도착했나???"+map.get("list"));
		
		
        map.put("user", user);
        map.put("list", map.get("list"));
		
	
	
		return map;
	}
	
	
	
	

	@RequestMapping(value="json/getFollowerList/{requestId}", method=RequestMethod.GET)
	public Map<String,Object> getFollowerList(@ModelAttribute("search")Search search, HttpSession session,
			          @PathVariable String requestId)throws Exception{
		
		
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
		
		map.put("user", user);
	    map.put("list", map.get("list"));
		
		return map;
	}
		
		
	


}
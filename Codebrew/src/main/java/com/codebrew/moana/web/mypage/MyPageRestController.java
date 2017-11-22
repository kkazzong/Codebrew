package com.codebrew.moana.web.mypage;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
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

	


	@RequestMapping(value="json/addFollow", method=RequestMethod.POST)
	public Map<String,Object> addFollow(@RequestParam("requestId") String requestId, 
			HttpSession session)throws Exception{
		//PathVariable도 ("requestId")
		System.out.println("/myPageRest/json/addFollow : POST업그레이드");
		
		String sessionId=((User)session.getAttribute("user")).getUserId();
		
        followService.addFollow(sessionId, requestId);
		
		Follow follow= followService.getFollow(sessionId, requestId);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("requestId", requestId);
		map.put("sessionId", sessionId);
		map.put("follow", follow);
		
	/*	
		String sessionId="";
		if(session.getAttribute("user")!=null) {
			sessionId=((User)session.getAttribute("user")).getUserId();
		}*/
		
		System.out.println("세션아디는???"+sessionId);
		System.out.println("리퀘스트아이디는???"+requestId);
		
		if(requestId !=null) {
		  if(sessionId.indexOf("requestId")==-1) {
			  sessionId=requestId;
		}
		}
		
		Search search=new Search();
         	
		  //팔로잉11
	    Map<String, Object>map1=followService.getFollowerList(search, sessionId);	
		  		
		  //팔로워22
	   Map<String, Object>map2=followService.getFollowingList(search, sessionId);
		
		
		map.put("list1", map1.get("list"));
		map.put("totalCount1", map1.get("totalCount"));
		
		System.out.println("팔로잉리스트는????"+map1.get("list"));
		System.out.println("팔로잉토탈카운트는??"+map1.get("totalCount"));
		
		
		map.put("list2", map2.get("list"));
		map.put("totalCount2", map2.get("totalCount"));
		
		System.out.println("팔로워리스트는????"+map2.get("list"));
		System.out.println("팔로워토탈카운트는??"+map2.get("totalCount"));
	
		
		return map;
}
	
	
	
	
	
	@RequestMapping(value="json/deleteFollow", method=RequestMethod.POST)
	public Map<String,Object> deleteFollow(@RequestParam("requestId") String requestId, 
			HttpSession session)throws Exception{
		//PathVariable도 ("requestId")
		System.out.println("/myPageRest/json/deleteFollow : POST업그레이드");
		
		String sessionId=((User)session.getAttribute("user")).getUserId();
		
        followService.deleteFollow(sessionId, requestId);
		
		Follow follow= followService.getFollow(sessionId, requestId);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("requestId", requestId);
		map.put("sessionId", sessionId);
		map.put("follow", follow);

		
		System.out.println("세션아디는???"+sessionId);
		System.out.println("리퀘스트아이디는???"+requestId);
		
		if(requestId !=null) {
		  if(sessionId.indexOf("requestId")==-1) {
			  sessionId=requestId;
		  }
		}
		
		Search search=new Search();	
		  //팔로잉11
	    Map<String, Object>map1=followService.getFollowerList(search, sessionId);	
		  		
		  //팔로워22
	   Map<String, Object>map2=followService.getFollowingList(search, sessionId);
		
		
		map.put("list1", map1.get("list"));
		map.put("totalCount1", map1.get("totalCount"));
		
		System.out.println("팔로잉리스트는????"+map1.get("list"));
		System.out.println("팔로잉토탈카운트는??"+map1.get("totalCount"));
		
		
		map.put("list2", map2.get("list"));
		map.put("totalCount2", map2.get("totalCount"));
		
		System.out.println("팔로워리스트는????"+map2.get("list"));
		System.out.println("팔로워토탈카운트는??"+map2.get("totalCount"));
	
		
		return map;
}
	
	
	
	/*@RequestMapping(value="json/addFollow/{requestId:.+}", method=RequestMethod.GET)
	public Follow addFollow(@PathVariable String requestId, HttpSession session)throws Exception{
		
		//@RequestBody Follow follow,@RequestBody Search search
		
		System.out.println("myPageRest/json/addFollow : GET");
		
		String sessionId=((User)session.getAttribute("user")).getUserId();
		
		
		
		if(sessionId != requestId) {
		followService.addFollow(sessionId, requestId);
		//Follow follow= followService.getFollow(sessionId, requestId);
		
		//model.addAttribute("follow", follow);
		//add 했으니깐 add 한 정보를 보내서 그사람 responseId가 내가 있다는 게 떠야함
		//controller에서 데이터를 보냈기 때문에 model 이고, 우린 restController라서 리턴타입을 보내야 함
		
		}
		Follow follow= followService.getFollow(sessionId, requestId);
		return follow;
}
	*/
	
	
	
	 /*@RequestMapping(value="json/deleteFollow/{requestId}", method=RequestMethod.GET)
	 public Follow deleteFollow(@PathVariable String requestId, HttpSession session, Follow follow)throws Exception{
		
		System.out.println("myPageRest/json/deleteFollow: GET");
		
		String sessionId=((User)session.getAttribute("user")).getUserId();
		
		//followService.deleteFollow(sessionId, requestId);
		
		

		if(sessionId != requestId) {
		followService.deleteFollow(sessionId, requestId);
		follow= followService.getFollow(sessionId, requestId);
		
		
		}	
		
		
		return follow;
		
	}
		*/
	
	/*
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
		
		*/
	


}
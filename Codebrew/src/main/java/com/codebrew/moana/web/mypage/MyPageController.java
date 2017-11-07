package com.codebrew.moana.web.mypage;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.codebrew.moana.common.Page;
import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Festival;
import com.codebrew.moana.service.domain.Follow;
import com.codebrew.moana.service.domain.User;
import com.codebrew.moana.service.domain.Zzim;
import com.codebrew.moana.service.festival.FestivalService;
import com.codebrew.moana.service.follow.FollowService;
import com.codebrew.moana.service.party.PartyService;
import com.codebrew.moana.service.purchase.PurchaseService;
import com.codebrew.moana.service.review.ReviewService;
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
	
	@Autowired
	@Qualifier("partyServiceImpl")
	private PartyService partyService;
	
	@Autowired
	@Qualifier("festivalServiceImpl")
	private FestivalService festivalService;
	
	
	@Autowired
	@Qualifier("reviewServiceImpl")
	private ReviewService reviewService;
	
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	@Value("#{imageRepositoryProperties['partyImageDir']}")
	String partyImageDir;
	
	
	
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
		
		System.out.println("다른 사람꺼 볼때 리스트에 잘 도착했나???"+map.get("list"));
		
		
		ModelAndView modelAndView=new ModelAndView();
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("user", user);
		/*modelAndView.setViewName("forward:/view/mypage/getFollowingList.jsp");*/
		modelAndView.setViewName("forward:/view/mypage/getMyPage.jsp");
	
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
		/*modelAndView.setViewName("forward:/view/mypage/getFollowerList.jsp");*/
		modelAndView.setViewName("forward:/view/mypage/getMyPage.jsp");
		
		return modelAndView;
	}
	
	@RequestMapping(value="getMyPage", method=RequestMethod.GET)
	public ModelAndView getMyPage(@RequestParam("requestId")String requestId, 
			@RequestParam(value = "purchaseFlag", required = false) String purchaseFlag,
			HttpSession session, @ModelAttribute("user")User user, @ModelAttribute("search") Search search,
			@ModelAttribute("page") Page page, HttpServletRequest request)throws Exception{
	
		System.out.println("/myPage/getMyPage : GET");
		
		
		//팔로잉, 팔로워
	    Map<String, Object>map=new HashMap<String, Object>();
	    map.put("requestId", requestId);
	    map.put("sessionId", ((User)session.getAttribute("user")).getUserId());
		
	    Follow follow=followService.getFollow(map.get("sessionId").toString(), requestId);
	    
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
		
		System.out.println("세션"+user);
		
		
		
		
		//공통
		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
	
		

		
		//축제111
		Zzim zzim = new Zzim();
		zzim.setUserId(user.getUserId());
		
		Map<String, Object> map1 = festivalService.getMyZzimList(search, user.getUserId());
		
		List<Festival> list1 = new ArrayList<Festival>();
		
		int listSize = ((List<Zzim>) map1.get("list")).size();
		
		for(int i =0; i<listSize ; i++){
			
			System.out.println("listSize......." +  listSize);
			
			Zzim returnZzim = ((List<Zzim>) map1.get("list")).get(i);
			
			//서비스단에서 map에 list로 담았기 때문에 list1으로 바꿔주면 null이 나옴
			
			Festival festival = festivalService.getFestivalDB(returnZzim.getFestivalNo());
			
			list1.add(festival);
			
		}
		
	   Page resultPage1 = new Page(search.getCurrentPage(), ((Integer) map1.get("totalCount")).intValue(), pageUnit,
				pageSize);
			
		
		//파티 222
		Map<String, Object> map2 = partyService.getMyPartyList(search, sessionId);//원래 userId 였음
		Page resultPage2 = new Page(search.getCurrentPage(), ((Integer) map2.get("totalCount")).intValue(), pageUnit,
				pageSize);	
		/*
		Search search2=new Search();
		search2.setSearchCondition("4");*/
	
				
	
		//리뷰333  
		Map<String, Object> map3 = reviewService.getMyReviewList(search, sessionId);//원래 userId 였음
		Page resultPage3 = new Page(search.getCurrentPage(), ((Integer) map3.get("totalCount")).intValue(), pageUnit,
				pageSize);	
				
		
		//구매444
		Map<String, Object> map4 = purchaseService.getPurchaseList(user.getUserId(), purchaseFlag, search);
		Page resultPage4 = new Page(search.getCurrentPage(), ((Integer) (map4.get("totalCount"))).intValue(), pageUnit, pageSize);
		
	
		
		//팔로잉55
		Map<String, Object>map5=followService.getFollowingList(search, sessionId);
		
		
		
		//팔로워66
		Map<String, Object>map6=followService.getFollwerList(search, sessionId);
		
	
		ModelAndView modelAndView=new ModelAndView();
		
		//팔로우
	    modelAndView.addObject("follow",follow);
	    
	    System.out.println("팔로우는????"+follow);
	    
	    //공통
	    modelAndView.addObject("search", search);
	    modelAndView.addObject("user", user);
	    
	    System.out.println("마이페이지속 유저는 누구???"+user);
	    
	    //축제
		modelAndView.addObject("list1", list1);
		modelAndView.addObject("resultPage1", resultPage1);
		
		System.out.println("축제리스트는????"+list1);
		
		//파티
		modelAndView.addObject("list2", map2.get("list"));
		modelAndView.addObject("resultPage2", resultPage2);
		/*modelAndView.addObject("search2", search2);*/
		
		System.out.println("파티리스트는?????" +map2.get("list"));
		
		
		//리뷰
		modelAndView.addObject("list3", map3.get("list"));
		modelAndView.addObject("userId", sessionId);//원래 userId였음
		modelAndView.addObject("resultPage3", resultPage3);
		
		System.out.println("리뷰리스트는????"+map3.get("list"));
		
		
		
		//구매
		modelAndView.addObject("list4", map4.get("list"));
		modelAndView.addObject("resultPage4", resultPage4);
		modelAndView.addObject("purchaseFlag", purchaseFlag);
		
		System.out.println("구매리스트????"+map4.get("list"));
		
		
		//팔로잉
		modelAndView.addObject("list5", map5.get("list"));
		modelAndView.addObject("totalCount5",map5.get("totalCount"));
		
		System.out.println("팔로잉리스트는????"+map5.get("list"));
		System.out.println("팔로잉토탈카운트는??"+map5.get("totalCount"));
		
		//팔로워
		modelAndView.addObject("list6", map6.get("list"));
		modelAndView.addObject("totalCount6",map6.get("totalCount"));
		
		
		System.out.println("팔로워리스트는????"+map6.get("list"));
		System.out.println("팔로워토탈카운트는??"+map6.get("list"));
		
		/*modelAndView.setViewName("forward:/view/mypage/getMyPage.jsp");*/
		
		modelAndView.setViewName("forward:/view/user/getMyPage2.jsp"); //테스트
		
		return modelAndView;
		
	
}
	
	
	
	
	/*@RequestMapping(value="getYourPage", method=RequestMethod.GET)
	public ModelAndView getYourPage(@RequestParam("userId")String userId,HttpSession session
			,@ModelAttribute("user")User user)throws Exception{
	
		System.out.println("/myPage/getYourPage : GET");
		
		
		String sessionId=((User)session.getAttribute("user")).getUserId();
		
	    Follow follow=followService.getFollow(sessionId, userId);
	   
		
		
		
		System.out.println("세션아디가 뭘로 변했나??"+sessionId);
		  
		user=userService.getUser(userId);
		
	
		ModelAndView modelAndView=new ModelAndView();
		modelAndView.addObject("user", user);
	    modelAndView.addObject("follow",follow);
		modelAndView.setViewName("forward:/view/mypage/getMyPage.jsp");
		
		return modelAndView;
		
	
}
	*/
	
	
	
	
	
}
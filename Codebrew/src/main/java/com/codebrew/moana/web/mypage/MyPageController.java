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
	public ModelAndView getMyPage(@RequestParam("requestId")String requestId, HttpSession session
			,@ModelAttribute("user")User user, @ModelAttribute("search") Search search,
			@ModelAttribute("page") Page page, HttpServletRequest request,
			@RequestParam(value = "purchaseFlag", required = false) String purchaseFlag)throws Exception{
	
		System.out.println("/myPage/getMyPage : GET");
		
		
		
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
		
		
		
		
		//getMyZZim축제
		

	  /*HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");*/
		
		System.out.println("세션"+user);
		
		//공통
		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit,
				pageSize);
		

		
		//축제
		Zzim zzim = new Zzim();
		zzim.setUserId(user.getUserId());
		
		Map<String, Object> map1 = festivalService.getMyZzimList(search, user.getUserId());
		
		List<Festival> list1 = new ArrayList<Festival>();
		
		int listSize = ((List<Zzim>) map1.get("list1")).size();
		
		for(int i =0; i<listSize ; i++){
			
			System.out.println("listSize......." +  listSize);
			
			Zzim returnZzim = ((List<Zzim>) map1.get("list1")).get(i);
			
			Festival festival = festivalService.getFestivalDB(returnZzim.getFestivalNo());
			
			list1.add(festival);
			
		}
			
		
		//파티 222
		Map<String, Object> map2 = partyService.getMyPartyList(search, sessionId);//원래 userId 였음
				
	
				
	
		//리뷰333  
		Map<String, Object> map3 = reviewService.getMyReviewList(search, sessionId);//원래 userId 였음
	
				
		
		
		
		
		
		
		
		
	
		ModelAndView modelAndView=new ModelAndView();
		modelAndView.addObject("user", user);
	    modelAndView.addObject("follow",follow);
	    
	    //공통
	    modelAndView.addObject("search", search);
		modelAndView.addObject("resultPage", resultPage);
	    
	    //축제
		modelAndView.addObject("list", list1);
		
		//파티
		modelAndView.addObject("list", map2.get("list"));
		
		//리뷰
		modelAndView.addObject("list", map3.get("list"));
		modelAndView.addObject("userId", sessionId);//원래 userId였음
		
		
		modelAndView.setViewName("forward:/view/mypage/getMyPage.jsp");
		
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
	@RequestMapping( value="getMyPartyList", method=RequestMethod.GET)
	public ModelAndView getMyPartyList( HttpSession session ) throws Exception {
		
		System.out.println("\n>>> /party/getMyPartyList :: GET start <<<");
		
		Search search = new Search();
		
		if(search.getCurrentPage() == 0){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		search.setSearchCondition("4");
		
		System.out.println("\n<<< /party/getMyPartyList :: GET :: search\n"+search);
		/*System.out.println("\n<<< /party/getMyPartyList :: GET :: currentPage\n"+search.getCurrentPage());
		System.out.println("\n<<< /party/getMyPartyList :: GET :: startPage\n"+search.getStartRowNum());
		System.out.println("\n<<< /party/getMyPartyList :: GET :: endPage\n"+search.getEndRowNum());*/
		
		
		String userId = ((User)session.getAttribute("user")).getUserId();
		System.out.println("\n<<< /party/getMyPartyList :: GET :: userId\n"+userId);
		
		
		//Business Logic
		Map<String, Object> map = partyService.getMyPartyList(search, userId);
		
		Page resultPage = new Page(search.getCurrentPage(),((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		
		//Model(data) & View(jsp)
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);
	 modelAndView.setViewName("forward:/view/party/getMyPartyList.jsp");
	 /*  modelAndView.setViewName("forward:/view/user/mypage/getMyPage2.jsp");*/
		return modelAndView;
	}
	
	@RequestMapping( value="getMyPartyList", method= RequestMethod.POST)
	public ModelAndView getMyPartyList( @ModelAttribute("search") Search search, HttpSession session) throws Exception{
		
		System.out.println("\n>>> /party/getMyPartyList :: POST start <<<");

		//search 도메인 파라미터 출력
		System.out.println(">>> /party/getMyPartyList :: POST :: search 도메인 파라미터 \n"+search);
				
		if(search.getCurrentPage() == 0){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		System.out.println("\n<<< /party/getMyPartyList :: POST :: currentPage\n"+search.getCurrentPage());
		
		String userId = ((User)session.getAttribute("user")).getUserId();
		System.out.println("\n<<< /party/getMyPartyList :: POST :: userId\n"+userId);
		
		
		//Business Logic
		Map<String, Object> map = partyService.getMyPartyList(search, userId);
		
		Page resultPage = new Page(search.getCurrentPage(),((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		
		//Model(data) & View(jsp)
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);
		modelAndView.setViewName("forward:/view/party/getMyPartyList.jsp");
		/*modelAndView.setViewName("forward:/view/user/getMyPage2.jsp");
		*/
		
		return modelAndView;
		
	}
	
	@RequestMapping(value = "getMyZzimList")
	public ModelAndView getMyZzimList(@ModelAttribute("search") Search search,
			@ModelAttribute("page") Page page, HttpServletRequest request) throws Exception {

		
		System.out.println("getzzim............" + search);
		
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		
		System.out.println("세션"+user);
		
		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);

		Zzim zzim = new Zzim();
		zzim.setUserId(user.getUserId());
		
		Map<String, Object> map = festivalService.getMyZzimList(search, user.getUserId());
		
		List<Festival> list = new ArrayList<Festival>();
		
		int listSize = ((List<Zzim>) map.get("list")).size();
		
		for(int i =0; i<listSize ; i++){
			
			System.out.println("listSize......." +  listSize);
			
			Zzim returnZzim = ((List<Zzim>) map.get("list")).get(i);
			
			Festival festival = festivalService.getFestivalDB(returnZzim.getFestivalNo());
			
			list.add(festival);
			
		}
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit,
				pageSize);

		ModelAndView modelAndView = new ModelAndView();

		modelAndView.setViewName("forward:/view/festival/getMyZzimList.jsp");
/*		modelAndView.setViewName("forward:/view/user/getMyPage2.jsp");*/
		
		modelAndView.addObject("search", search);
		modelAndView.addObject("list", list);
		modelAndView.addObject("resultPage", resultPage);
		

		return modelAndView;


	}
	
	@RequestMapping(value="getMyReviewList")
	public ModelAndView getMyReviewList( @ModelAttribute("search") Search search,   
										HttpSession session) throws Exception{
		
		System.out.println("/view/review/getMyReviewList");
		
		if(search.getCurrentPage() == 0){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic 수행
		String userId = ((User)(session.getAttribute("user"))).getUserId();
		Map<String, Object> map = reviewService.getMyReviewList(search, userId);
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model과 View 연결 : 확인 요망
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);
		modelAndView.addObject("userId", userId);
		
		modelAndView.setViewName("/view/review/getMyReviewList.jsp");
		
		/*modelAndView.setViewName("forward:/view/user/getMyPage2.jsp");*/
		
		return modelAndView;
	}
	
	
	
	
	
	
}
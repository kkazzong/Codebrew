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
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.codebrew.moana.common.Page;
import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Festival;
import com.codebrew.moana.service.domain.Follow;
import com.codebrew.moana.service.domain.Party;
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
/*	
	@RequestMapping(value="getMyPage", method=RequestMethod.GET)
	public ModelAndView getMyPage(@RequestParam("requestId")String requestId, 
			@RequestParam(value = "purchaseFlag", required = false) String purchaseFlag,
			HttpSession session, @ModelAttribute("user")User user, @ModelAttribute("search") Search search
			)throws Exception{
	
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
			
		
		//파티 333
		Map<String, Object> map2 = partyService.getMyPartyList(search, sessionId);//원래 userId 였음
		Page resultPage2 = new Page(search.getCurrentPage(), ((Integer) map2.get("totalCount")).intValue(), pageUnit,
				pageSize);	
		
		Search search2=new Search();
		search2.setSearchCondition("4");
	
				
	
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
		Map<String, Object>map6=followService.getFollowerList(search, sessionId);
		
	
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
		modelAndView.addObject("list3", map2.get("list"));
		modelAndView.addObject("resultPage3", resultPage2);
		modelAndView.addObject("search3", search2);
		
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
		
		//modelAndView.setViewName("forward:/view/mypage/getMyPage.jsp");
		
		modelAndView.setViewName("forward:/view/mypage/mmm.jsp"); //테스트
		
		return modelAndView;
		
	
}
	*/
/*	
	@RequestMapping(value="getMyPage", method=RequestMethod.GET)
	public ModelAndView getMyPage(@RequestParam("requestId")String requestId, 
			@RequestParam(value = "purchaseFlag", required = false) String purchaseFlag,
			HttpSession session, @ModelAttribute("user")User user, @ModelAttribute("search") Search search
			)throws Exception{
	
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
		
	
		

		
	
			
		
		//파티 333
		Map<String, Object> map2 = partyService.getMyPartyList(search, sessionId);//원래 userId 였음
		Page resultPage2 = new Page(search.getCurrentPage(), ((Integer) map2.get("totalCount")).intValue(), pageUnit,
				pageSize);	
		
		Search search2=new Search();
		search2.setSearchCondition("4");
	
				
	
		
		
		//팔로잉55
		Map<String, Object>map5=followService.getFollowingList(search, sessionId);
		
		
		
		//팔로워66
		Map<String, Object>map6=followService.getFollowerList(search, sessionId);
		*/
	
		/*ModelAndView modelAndView=new ModelAndView();
		
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
		modelAndView.addObject("list3", map2.get("list"));
		modelAndView.addObject("resultPage3", resultPage2);
		modelAndView.addObject("search3", search2);
		
		System.out.println("파티리스트는?????" +map2.get("list"));
		
		
	
		
		
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
		
		//modelAndView.setViewName("forward:/view/mypage/getMyPage.jsp");
		
		modelAndView.setViewName("forward:/view/mypage/mmm.jsp"); //테스트
		
		return modelAndView;
		
	
}*/
	
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
	

	
	
	/*@RequestMapping(value="addFollow", method=RequestMethod.GET)
	public void addFollow(@RequestParam("requestId") String requestId, HttpSession session)throws Exception{
		
		//@RequestBody Follow follow,@RequestBody Search search
		
		System.out.println("myPage/addFollow : GET");
		
		String sessionId=((User)session.getAttribute("user")).getUserId();
		
		
		
		if(sessionId != requestId) {
		followService.addFollow(sessionId, requestId);
		//Follow follow= followService.getFollow(sessionId, requestId);
		
		//model.addAttribute("follow", follow);
		//add 했으니깐 add 한 정보를 보내서 그사람 responseId가 내가 있다는 게 떠야함
		//controller에서 데이터를 보냈기 때문에 model 이고, 우린 restController라서 리턴타입을 보내야 함
		
		}
		//Follow follow= followService.getFollow(sessionId, requestId);
		//Follow follow= followService.getFollow(sessionId, requestId);
	  //model.addAttribute("follow", follow);
	
	    ModelAndView modelAndView=new ModelAndView();
	    modelAndView.setViewName("redirect:/view/mypage/getMyPage.jsp");
	}
	
	
	*/
	
	@RequestMapping(value="getMyPage", method=RequestMethod.GET)
	public ModelAndView getMyPage(@RequestParam(value="requestId", required=false)String requestId, HttpSession session
			,@ModelAttribute("user")User user,@ModelAttribute("search")Search search,
			@ModelAttribute("party")Party party)throws Exception{
	
		System.out.println("/myPage/getMyPage 수정 : GET");
		
		
	  Map<String, Object>map=new HashMap<String, Object>();
	  map.put("requestId", requestId);
	  map.put("sessionId", ((User)session.getAttribute("user")).getUserId());
			
    Follow follow=followService.getFollow(map.get("sessionId").toString(), requestId);
		   
    //일단 화면에서 받은 requestId(userId)와 나 sessionId상태로 getFollow를 가져온다
    //이사람과 내가 팔로우 되어있는지 안되어있는지 판단하기 위해...add 두번가면 무결성에러..니깐...
    
   
    
    
    
    
    
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
	  
	  
		  
		System.out.println("세션아디가 뭘로 변했나??"+sessionId);//리퀘스트 아이디로 변환
		
		user=userService.getUser(sessionId);//requstId(sessionId)의 유저 정보
			
	    System.out.println("세션"+user);
	   
		
	  //팔로잉11
	  Map<String, Object>map1=followService.getFollowingList(search, sessionId);
	  		
	  //sessionId가 requestId로		
	  		
	  //팔로워22
	  Map<String, Object>map2=followService.getFollowerList(search, sessionId);
		
	//sessionId가 responseId로	
		  
	 Search search2=new Search();
	 
	 if (search2.getCurrentPage() == 0) {
			search2.setCurrentPage(1);
		}
		search2.setPageSize(pageSize);
		
	  //파티33
	  Map<String, Object> map3 = partyService.getMyPartyList(search2, sessionId);//원래 userId였음
	  Page resultPage = new Page(search2.getCurrentPage(),((Integer)map3.get("totalCount")).intValue(), pageUnit, pageSize);


	  
	  
	
		ModelAndView modelAndView=new ModelAndView();
		modelAndView.addObject("user", user);//마이페이지 왔을때 그사람의 정보
	    modelAndView.addObject("follow",follow);//requestId가 있는지 없는지...
	    
	    // 리스트 정보를 마이페이지에 뿌려주지 않으면 getFollowList include 한 정보가 나오는것이기때문에 아무것도 안나옴..
	    
	    //팔로잉리스트
		modelAndView.addObject("list1", map1.get("list"));
		modelAndView.addObject("totalCount1",map1.get("totalCount"));
		
		System.out.println("팔로잉리스트는????"+map1.get("list"));
		System.out.println("팔로잉토탈카운트는??"+map1.get("totalCount"));
		
		//팔로워
		modelAndView.addObject("list2", map2.get("list"));
		modelAndView.addObject("totalCount2",map2.get("totalCount"));
		
		
		System.out.println("팔로워리스트는????"+map2.get("list"));
		System.out.println("팔로워토탈카운트는??"+map2.get("totalCount"));
	
	    //파티
		modelAndView.addObject("list3", map3.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search2);
	    modelAndView.addObject("party",party); 
	    
	    
	    System.out.println("파티리스트는???"+map3.get("list"));
	    System.out.println("파티 토탈카운트는??"+resultPage.getTotalCount());
	    System.out.println("파티정보는???"+party);
				
	    System.out.println("오긴왔니???");
	   //modelAndView.setViewName("forward:/view/mypage/mmm.jsp");
	    
	   //modelAndView.setViewName("forward:/view/mypage/getMyPage.jsp");
	   

	   modelAndView.setViewName("forward:/view/mypage/getMyPage.jsp");

		
		return modelAndView;
		
	
    }
	
	
	
	
	/*@RequestMapping(value = "getMyZzimList")
	public ModelAndView getMyZzimList(@ModelAttribute("search") Search search,
			@ModelAttribute("page") Page page, HttpServletRequest request) throws Exception {

		
		System.out.println("getzzimSearch............" + search);
		
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

		modelAndView.setViewName("forward:/view/mypage/getMyZzimList.jsp");
		
		modelAndView.addObject("search", search);
		modelAndView.addObject("list", list);
		modelAndView.addObject("resultPage", resultPage);
		

		return modelAndView;


	}
	
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
		System.out.println("\n<<< /party/getMyPartyList :: GET :: currentPage\n"+search.getCurrentPage());
		System.out.println("\n<<< /party/getMyPartyList :: GET :: startPage\n"+search.getStartRowNum());
		System.out.println("\n<<< /party/getMyPartyList :: GET :: endPage\n"+search.getEndRowNum());
		
		
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
		modelAndView.setViewName("forward:/view/mypage/getMyPartyList.jsp");
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
		modelAndView.setViewName("forward:/view/mypage/getMyPartyList.jsp");
		
		return modelAndView;
		
	}
	
	@RequestMapping(value = "getPurchaseList")
	public ModelAndView getPurchaseList(HttpSession session,
																	@ModelAttribute("search") Search search,
																	@RequestParam(value = "purchaseFlag", required = false) String purchaseFlag) {

		User user = (User) session.getAttribute("user");

		
		 * if(purchaseFlag == null) { purchaseFlag = "1"; //default is festival }
		 
		System.out.println(purchaseFlag);
		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		System.out.println(search);
		Map<String, Object> map = purchaseService.getPurchaseList(user.getUserId(), purchaseFlag, search);

		Page resultPage = new Page(search.getCurrentPage(), ((Integer) (map.get("totalCount"))).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);
		modelAndView.addObject("purchaseFlag", purchaseFlag);

		modelAndView.setViewName("/view/mypage/getPurchaseList.jsp");
		//modelAndView.setViewName("/view/purchase/getPurchaseListTest.jsp");
		
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
		
		modelAndView.setViewName("/view/mypage/getMyReviewList.jsp");
		
		return modelAndView;
	}
	
	*/
	
	
}
package com.codebrew.moana.web.user;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.codebrew.moana.common.Page;
import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.User;
import com.codebrew.moana.service.user.UserService;

@Controller
@RequestMapping("/user/*")
public class UserController {

	//field
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
/*	@Autowired
	 private JavaMailSender mailSender;*/
	
	
	//constructor
	public UserController() {
		System.out.println(this.getClass());
		
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
    
	
	//로그인 화면
	@RequestMapping(value="login", method=RequestMethod.GET)
	public ModelAndView login() throws Exception{
		
		System.out.println("/user/login : GET");
		
		ModelAndView modelAndView=new ModelAndView();
		modelAndView.setViewName("redirect:/view/user/login.jsp");
		return modelAndView;
	}
	
	//로그인
	@RequestMapping(value="login", method=RequestMethod.POST)
	public ModelAndView login(@ModelAttribute("user")User user,HttpSession session ) throws Exception{
	

	System.out.println("/user/login : POST");
	
	User dbUser=userService.getUser(user.getUserId());
	//user:내가 입력한 정보  /dbUser:디비에서 가져온 정보  / session 세션에 담고 있는 정보
	if(user.getPassword().equals(dbUser.getPassword())) {
		session.setAttribute("user", dbUser);
	}
	
	ModelAndView modelAndView=new ModelAndView();
	//modelAndView.addObject("user", user);//??
	modelAndView.setViewName("redirect:/index.jsp");
	return modelAndView;
	}
	
	
	//로그아웃
	@RequestMapping(value="logout", method=RequestMethod.GET)
	public ModelAndView logout(HttpSession session) throws Exception{
		
		System.out.println("/user/logout : GET");
		
		session.invalidate();
		
		ModelAndView modelAndView=new ModelAndView();
		modelAndView.setViewName("redirect:/index.jsp");
		return modelAndView;
		
	}
	
	//회원가입 화면이동
	@RequestMapping(value="addUser", method=RequestMethod.GET)
	public ModelAndView addUser()throws Exception{//페이지이동일뿐이니깐 들어가는 파라미터도 없음
	
		System.out.println("/user/addUser : GET");
		ModelAndView modelAndView=new ModelAndView();
		modelAndView.setViewName("redirect:/view/user/addUser.jsp");
		return modelAndView;
	}
	
	
	//진짜 회원가입
	@RequestMapping(value="addUser", method=RequestMethod.POST)
	public ModelAndView addUser(@ModelAttribute("user")User user)throws Exception{
	
	  System.out.println("/user/addUser : POST");
	  
	   userService.addUser(user);
	   
		ModelAndView modelAndView=new ModelAndView();
		modelAndView.setViewName("redirect:/view/user/login.jsp");
		return modelAndView;
	}
	
	//회원정보 조회
	@RequestMapping(value="getUser", method=RequestMethod.GET)
	public ModelAndView getUser(@RequestParam("userId") String userId)throws Exception{
		//업데이트화면에 온건 userId를 가지고 들어오니깐
		
		System.out.println("/user/getUser : GET");
		
		//비즈니스로직
		User user=userService.getUser(userId);
		
		ModelAndView modelAndView=new ModelAndView();
	
		modelAndView.addObject("user", user);
		modelAndView.setViewName("forward:/view/user/getProfile.jsp");
		return modelAndView;
	
	}
	
	//회원정보조회 및 수정화면이동
	@RequestMapping(value="updateUser", method=RequestMethod.GET)
	public ModelAndView updateUser(@RequestParam("userId") String userId)throws Exception{
		
		
		System.out.println("/user/getUser : GET");
		
		//비즈니스로직
		User user=userService.getUser(userId);
		
		ModelAndView modelAndView=new ModelAndView();
		//모델과 뷰 연결
		modelAndView.addObject("user", user);
		modelAndView.setViewName("forward:/view/user/updateUser.jsp");
		return modelAndView;
	
	}
	
	
	
	//진짜 회원정보 수정
	@RequestMapping(value="updateUser", method=RequestMethod.POST)
	public ModelAndView updateUser(@ModelAttribute("user")User user,HttpSession session)throws Exception{
		
		System.out.println("/user/updateUser : POST");
		
		//비즈니스로직
		userService.updateUser(user);
				
		String sessionId=((User)session.getAttribute("user")).getUserId();
		//user 클래스 형태로 형변환을  해줘야 userId를 꺼낼수 있다.
		
		//String sessionId1=(String)session.getAttribute("userId");
		//이건 안됨.. 왜냐면 세션에 user정보를 도메인으로 보내놨기 때문에
		
		if(sessionId.equals(user.getUserId())) {
			session.setAttribute("user", user);
		}
		//수정후 uservo의 userId와 현재 세션의 userId와 같다면 세션에 user정보를 넣는다
		//user.getUserId의 user는 updateUser시 바인딩되서 들어간 uservo(불러온 user정보:파라미터)를 의미함
		//데이터로 가기전에 수정된 정보는 user 도메인에 머금고 있다.그래서 userId랑 sessionId를 비교해주는 것이다.
		//수정하기전에 들어온 user.getUserId와 session에 있는 userId와 같다면 session에 user setAttribute
	
		ModelAndView modelAndView=new ModelAndView();
		modelAndView.setViewName("redirect:/view/user/getProfile.jsp");
		return modelAndView;
	}
	
	//아이디찾기 비밀번호찾기 화면이동
	@RequestMapping(value="findUser", method=RequestMethod.GET)
	public ModelAndView findUser()throws Exception{
		
		System.out.println("/user/findUser : GET");
		
		ModelAndView modelAndView=new ModelAndView();
		modelAndView.setViewName("redirect:/view/user/findUser.jsp");
		return modelAndView;
	}
	
	//타계정 회원가입 화면이동
	@RequestMapping (value="addExtraUser", method=RequestMethod.GET)
	public ModelAndView addExtraUser(@RequestParam("userId")String userId)throws Exception{
		
		System.out.println("/user/addExtraUser : GET");
		
		User user=userService.getUser(userId);
		
		ModelAndView modelAndView=new ModelAndView();
		modelAndView.addObject("user", user);
		//이화면에 왔을때 이미 정보가저장된 user를 가져온 상태인것
		modelAndView.setViewName("forward:/view/user/addExtraUser.jsp");
		return modelAndView;
		
	}
	
	//타계정 회원가입
	@RequestMapping(value="addExtraUser", method=RequestMethod.POST)
	public ModelAndView addExtraUser(@ModelAttribute("user")User user)throws Exception{
		
		System.out.println("/user/addExtraUser : POST ");
		
		userService.addUser(user);
		
		User dbUser=userService.getUser(user.getUserId());
		
		userService.updateUser(dbUser);
		
		ModelAndView modelAndView=new ModelAndView();
		modelAndView.setViewName("redirect:/index.jsp");
		return modelAndView;
	}
	
	//본인인증 화면이동
	@RequestMapping(value="confirmUser", method=RequestMethod.GET)
	public ModelAndView confirmUser()throws Exception{
		
		System.out.println("/user/confirmUser : GET");
		
		
		ModelAndView modelAndView=new ModelAndView();
		modelAndView.setViewName("redirect:/view/user/confirmUser.jsp");
		return modelAndView;
		
	}
		
	
	//회원리스트
	@RequestMapping(value="getUserList")
	public ModelAndView getUserList(@ModelAttribute("search")Search search)throws Exception{
		System.out.println("/user/getUserList : GET/POST");
		
		if(search.getCurrentPage()==0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		//비즈니스로직 수행
		Map<String,Object>map=userService.getUserList(search);
		
		Page resultPage=new Page(search.getCurrentPage(),((Integer)map.get("totalCount")).intValue(),pageSize,pageUnit);
				
		System.out.println(resultPage);
				
		
		ModelAndView modelAndView=new ModelAndView();
		
		modelAndView.addObject("search",search);
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("list",map.get("list"));
		modelAndView.setViewName("forward:/view/user/getUserList.jsp");
		return modelAndView;
		
	}
	
	
	
    //회원탈퇴화면이동
	@RequestMapping(value="withdrawUser", method=RequestMethod.GET)
	public ModelAndView withdrawUser(@RequestParam("userId")String userId, HttpSession session)throws Exception{
		
		System.out.println("/user/withdrawUser : GET");
		
		User user=userService.getUser(userId);
		
		ModelAndView modelAndView=new ModelAndView();
		modelAndView.addObject("user", user);
		modelAndView.setViewName("forward:/view/user/withdrawUser.jsp");
		return modelAndView;
		
		 
	}
	
	
	
	//진짜 회원탈퇴
	@RequestMapping(value="withdrawUser", method=RequestMethod.POST)
	public ModelAndView withdrawUser(@ModelAttribute("user")User user, HttpSession session)throws Exception{
		
		System.out.println("/user/withdrawUser : POST");
		
	    User dbUser=userService.getUser(user.getUserId());
		
		if(user.getPassword().equals(dbUser.getPassword())) {
		
		userService.deleteUser(user);
		
		}
		
		String sessionId=((User)session.getAttribute("user")).getUserId();
		
		if(sessionId.equals(user.getUserId())) {
			//여기서 user.getUserId는 deleteUser(DB:update)시킨 user임
			session.setAttribute("user",user);
			session.invalidate();
		}
		
		ModelAndView modelAndView=new ModelAndView();
		modelAndView.setViewName("redirect:/index.jsp");
		return modelAndView;
	}
	
	
	
	
	
	
}

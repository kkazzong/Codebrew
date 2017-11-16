package com.codebrew.moana.web.user;

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

import com.codebrew.moana.service.domain.Auth;
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
	
	
	@Value("#{coconutProperties['partyCoconut']}")
	int partyCoconut;
	
	@Value("#{coconutProperties['reviewCoconut']}")
	int reviewCoconut;
	
	
    //입력한 아이디와 비밀번호가 맞는지 알려주려고 만든 거
	@RequestMapping(value="json/getUser", method=RequestMethod.POST)
	public User getUser(@RequestParam("userId")String userId)throws Exception{
		
		System.out.println("/userRest/json/getUser : GET");
		
		return userService.getUser(userId);
		
	}
	
	
    //입력한 아이디와 비밀번호가 맞는지 알려주려고 만든 거
	@RequestMapping(value="json/getLoginUser", method=RequestMethod.POST)
	public User getLoginUser(@RequestParam("requestId")String requestId)throws Exception{
		
		System.out.println("/userRest/json/getUser : GET");
		
		return userService.getUser(requestId);
		
	}
	
	
	
	/*//api로그인할때 필요한 login() 폼으로 받을거니깐 post
	@RequestMapping(value="json/login", method=RequestMethod.POST)
	public User login(@RequestBody User user, HttpSession session)throws Exception{
	
		System.out.println("/userRest/json/login : POST");
		
		User dbUser=userService.getUser(user.getUserId());
		//user:내가 입력한 정보  /dbUser:디비에서 가져온 정보  / session 세션에 담고 있는 정보
		if(user.getPassword().equals(dbUser.getPassword())) {
	     session.setAttribute("user", user);
	     //"user"는 jsp에서 name으로 쓸 예정 ㅋㅋ
		}
		
		return dbUser;
	
	}*/
	
	
	
	/*@RequestMapping(value="json/logout", method=RequestMethod.GET)
	public void logout(HttpSession session)throws Exception{
		System.out.println("/userRest/json/logout : GET");
		
		session.invalidate();
	
	}
	*/
    //회원정보수정, 회원가입시 닉네임중복체크
	@RequestMapping(value="json/checkNickname", method=RequestMethod.POST)
	public boolean checkNickname(@RequestParam("nickname")String nickname)throws Exception{
		
		System.out.println("/userRest/json/checkNickname : POST");
	
		boolean result=userService.checkNickname(nickname);
		
		return result;
	}
	
  /*  //비밀번호찾을때 존재하지 않은 아이디임을 알려주는 아이디중복체크
	@RequestMapping(value="json/checkUserId/{userId:.+}", method=RequestMethod.POST)
	public boolean checkUserId(@PathVariable("userId") String userId)throws Exception{
		
		System.out.println("/userRest/json/checkUserId : POST ");
		
		boolean result=userService.checkUserId(userId);
		
		return result;
		
	}*/
	
	  //비밀번호찾을때 존재하지 않은 아이디임을 알려주는 아이디중복체크
		@RequestMapping(value="json/checkUserId", method=RequestMethod.POST)
		public boolean checkUserId(@RequestParam("userId")String userId)throws Exception{
			
			System.out.println("userId...."+ userId);
			
			System.out.println("/userRest/json/checkUserId : POST ");
			
			
			
			boolean result=userService.checkUserId(userId);
			
			return result;
			
		} 
		
		
		
	/*	//아이디와 비밀번호와 맞는지 알려주는 메소드
		@RequestMapping(value="json/checkPassword", method=RequestMethod.POST)
		public boolean checkPassword(@RequestParam("userId")String userId)throws Exception{
			
			System.out.println("/userRest/json/checkUserId : POST ");
			
			boolean result=userService.checkUserId(userId);
			
			return result;
			
		}*/
		 
	
	//회원 아이디 찾기
	@RequestMapping(value="/json/findUserId", method=RequestMethod.POST)
	public Map<String, String> findUserId(@RequestBody User user)throws Exception{
		
		/*@RequestParam("userName")String userName,
        @RequestParam("phone")String phone
		*/
		
		System.out.println("/userRest/json/findUserId : POST ");
		
		user=userService.findUserId(user); 
		//json 데이터를 받을때는 string 으로 리턴값을 하면 value값밖에 리턴이 안되기 때문에
		//map 형식으로 담거나. 도메인으로 리턴해야함(도메인은 코드하우스잭슨이 알아서 name:value로 넘겨줌)
	     
		String userId=user.getUserId() ;
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("userId", userId);
		return map;
		
	}
	
	//위치동의
	@RequestMapping(value="json/locateUser", method=RequestMethod.POST)
	public User locateUser(@RequestParam(value="locationFlag", defaultValue="n")String locationFlag,
                           @RequestBody User user, HttpSession session)throws Exception{
		
		System.out.println("/userRest/json/locateUser : POST");
		
		String sessionId=((User)session.getAttribute("user")).getUserId();
		
		if(sessionId.equals(user.getUserId())) {
	
		session.setAttribute("user", user);
		}
		
		return user;
  }
	
	

	
	
	
	//진짜 본인인증-메일로 보내고 인증번호받아오기
	@RequestMapping(value="json/confirmUser", method=RequestMethod.POST)
	public Auth confirmUser(@RequestBody Auth auth, Model model)throws Exception{
		
		System.out.println("/userRest/json/confirmUser : POST");
		
		 auth=userService.confirmUser(auth);
		 
		 //모델과 뷰 연결
		 //model.addAttribute("auth", auth);///???????????????????????
		 
	
		  return auth;
	}
	
	/*@RequestMapping(value = "kakaoLogin", method = RequestMethod.GET)
	public User kakaoLogin(@RequestParam(value="authorize_code") String authorize_Code,
			HttpSession session) throws Exception {

		
		System.out.println("/userRest/user/kakaoLogin : GET ");

		User user=new User();
		
		User dbUser = userService.getUser(user.getUserId());

		

		if (user.getUserId().equals(dbUser.getUserId())) {
			session.setAttribute("user", dbUser);
			//modelAndView.setViewName("redirect:/index.jsp");

		} else {

			User kakaoUser = userService.getCode(authorize_Code);
			userService.addUser(kakaoUser);
			session.setAttribute("user", kakaoUser);
			
		}
			

			//modelAndView.addObject("user", addExtraUser);

			//modelAndView.setViewName("forward:view/user/addExtraUser.jsp");
		
         return user;
	
	}
	*/
	

	//업데이트 코코넛	
	/*@RequestMapping(value="json/updateCoconut/{flag}", method=RequestMethod.POST)
	public User updateCoconut(@PathVariable("flag") String flag,
							  @RequestBody User user)throws Exception{
		
		System.out.println("/userRest/json/updateCoconut : POST");
		System.out.println("flag->>>>>"+flag);
		// 1이면 파티 ------ 수량까기
		// 2이면 후기 ------ 수량더하기
		
		user=userService.getUser(user.getUserId());
		
		int originCoconut=userService.getUser(user.getUserId()).getCoconutCount();
		
		int updateCoconut=user.getCoconutCount();
		
		if(flag.equals("1")) { //파티인경우
			user.setCoconutCount(originCoconut+updateCoconut);
		} else { //후기인경우
			if(originCoconut >= updateCoconut) {
				user.setCoconutCount(originCoconut-updateCoconut);
			} else {
				user.setCoconutCount(updateCoconut-originCoconut);
			}
		}
		
		userService.updateCoconut(user);
		
		return user;
	}*/
	
	@RequestMapping(value="json/updateCoconut/{flag}", method=RequestMethod.POST)
	public User updateCoconut(@PathVariable("flag") String flag,
			
							  HttpSession session)throws Exception{
		
		System.out.println("/userRest/json/updateCoconut : POST");
		System.out.println("flag->>>>>"+flag);
		System.out.println("session->>>>>"+session);
		// 1이면 파티 ------ 수량까기
		// 2이면 후기 ------ 수량더하기
		
		/*user=userService.getUser(user.getUserId());*/
		User user = userService.getUser(((User)session.getAttribute("user")).getUserId());
		int originCoconut=user.getCoconutCount();
		
	
		
		if(flag.equals("1")) { //파티인경우
			user.setCoconutCount(originCoconut-partyCoconut);
		} else { //후기인경우
		   user.setCoconutCount(originCoconut+reviewCoconut);
			
		}
		
		userService.updateCoconut(user);
		
		
		User dbUser=userService.getUser(user.getUserId());
		session.setAttribute("user", dbUser);
		
		return user;
	}
	
	
	/*@RequestMapping(value="json/updateCoconut/{userId}/{flag}", method=RequestMethod.GET)
	public User updateCoconut(@PathVariable("userId") String userId,
			@PathVariable("flag") String flag, @RequestBody User user)throws Exception{
		
		System.out.println("/userRest/json/updateCoconut : POST");
		System.out.println("flag->>>>>"+flag);
		// 1이면 파티 ------ 수량까기
		// 2이면 후기 ------ 수량더하기
		
		user=userService.getUser(user.getUserId());
		
		int originCoconut=userService.getUser(user.getUserId()).getCoconutCount();
		
	
		
		if(flag.equals("1")) { //파티인경우
			user.setCoconutCount(originCoconut-partyCoconut);
		} else { //후기인경우
		   user.setCoconutCount(originCoconut+reviewCoconut);
			
		}
		
		userService.updateCoconut(user);
		
		return user;
	}  */
	
	@RequestMapping(value="json/updateCoconut/{userId}/{flag}", method=RequestMethod.GET)
	public User updateCoconut(@PathVariable("userId") String userId,
			@PathVariable("flag") String flag, HttpSession session)throws Exception{
		
		System.out.println("/userRest/json/updateCoconut : POST");
		System.out.println("flag->>>>>"+flag);
		// 1이면 파티 ------ 수량까기
		// 2이면 후기 ------ 수량더하기
		
		/*user=userService.getUser(user.getUserId());*/
		User user = userService.getUser(userId);
		int originCoconut=user.getCoconutCount();
		
	
		
		if(flag.equals("1")) { //파티인경우
			user.setCoconutCount(originCoconut-partyCoconut);
		} else { //후기인경우
		   user.setCoconutCount(originCoconut+reviewCoconut);
			
		}
		
		userService.updateCoconut(user);
		
		User dbUser=userService.getUser(user.getUserId());
		session.setAttribute("user", dbUser);
		
		return user;
	}  

	
}

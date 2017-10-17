package com.codebrew.moana.web.user;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.codebrew.moana.service.domain.User;
import com.codebrew.moana.service.user.UserService;

@Controller
@RequestMapping("/user/*")
public class UserController {

	//field
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	@Autowired
	 private JavaMailSender mailSender;
	
	
	//constructor
	public UserController() {
		System.out.println(this.getClass());
		
	}
	
	/*@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;*/

	@RequestMapping(value="login", method=RequestMethod.GET)
	public ModelAndView login() throws Exception{
		
		System.out.println("/user/login : GET");
		
		ModelAndView modelAndView=new ModelAndView();
		modelAndView.setViewName("redirect:/view/user/login.jsp");
		return modelAndView;
	}
	
	@RequestMapping(value="login", method=RequestMethod.POST)
	public ModelAndView login(@ModelAttribute("user")User user,HttpSession session ) throws Exception{
	
    
	System.out.println("/user/login : POST");
	
	User dbUser=userService.getUser(user.getUserId());
	
	if(user.getPassword().equals(dbUser.getPassword())) {
		session.setAttribute("user", dbUser);
	}
	
	ModelAndView modelAndView=new ModelAndView();
	modelAndView.setViewName("redirect:/index.jsp");//개인정보 보호
	return modelAndView;
	}
	
}

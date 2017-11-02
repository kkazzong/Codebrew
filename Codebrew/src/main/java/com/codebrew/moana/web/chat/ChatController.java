package com.codebrew.moana.web.chat;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.net.URL;
import java.util.Map;

import javax.imageio.ImageIO;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.codebrew.moana.common.Page;
import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Festival;
import com.codebrew.moana.service.domain.Party;
import com.codebrew.moana.service.domain.PartyMember;
import com.codebrew.moana.service.domain.Ticket;
import com.codebrew.moana.service.domain.User;
import com.codebrew.moana.service.festival.FestivalService;
import com.codebrew.moana.service.party.PartyService;
import com.codebrew.moana.service.ticket.TicketService;
import com.codebrew.moana.service.user.UserService;


//==> 파티관리 Controller
@Controller
@RequestMapping("/chat/*")
public class ChatController {

	///Field///
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	
	///Constructor///
	public ChatController() {
		super();
		// TODO Auto-generated constructor stub
		System.out.println("\n>>> "+this.getClass()+" Default Constructor Call <<<\n");
	}
	
	
	///Method///
	@RequestMapping( value="getChatting")
	public ModelAndView getChatting(@RequestParam("sender") String sender, @RequestParam("recipient") String recipient) throws Exception {
		
		System.out.println("\n>>> /chat/getChatting :: GET start <<<");
		
		//sender, recipient 파라미터 출력
		System.out.println(">>> /chat/getChatting :: GET :: sender 파라미터 \n"+sender);
		System.out.println(">>> /chat/getChatting :: GET :: recipient 파라미터 \n"+recipient);
		
		
		User dbSender = userService.getUser(sender);
		User dbRecipient = userService.getUser(recipient);
		//User 도메인 출력
		System.out.println("\n<<< /chat/getChatting :: GET :: sender 도메인  \n"+dbSender);
		System.out.println("\n<<< /chat/getChatting :: GET :: recipient 도메인  \n"+dbRecipient);
		
		
		
		//Model(data) & View(jsp)
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("sender", dbSender);
		modelAndView.addObject("recipient", dbRecipient);
		
		modelAndView.setViewName("forward:/view/chat/chatting.jsp");
		
		return modelAndView;
	}

}

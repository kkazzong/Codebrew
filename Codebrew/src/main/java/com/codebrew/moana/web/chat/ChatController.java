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
	
	@Autowired
	@Qualifier("partyServiceImpl")
	private PartyService partyService;
	
	
	///Constructor///
	public ChatController() {
		super();
		// TODO Auto-generated constructor stub
		System.out.println("\n>>> "+this.getClass()+" Default Constructor Call <<<\n");
	}
	
	
	///Method///
	@RequestMapping( value="getChatting")
	public ModelAndView getChatting(@RequestParam("sender") String sender,
																@RequestParam(value="recipient", required=false) String recipient) throws Exception {
		
		System.out.println("\n>>> /chat/getChatting :: POST start <<<");
		
		//sender, recipient 파라미터 출력
		System.out.println(">>> /chat/getChatting :: POST :: sender 파라미터 \n"+sender);
		System.out.println(">>> /chat/getChatting :: POST :: recipient 파라미터 \n"+recipient);
		
		User dbSender = null;
		User dbRecipient = null;
		
		//게스트가 채팅할때
		if(recipient != null) {
			dbSender = userService.getUser(sender);
			dbRecipient = userService.getUser(recipient);
		} else {
			dbSender = userService.getUser(sender);
		}
		//User 도메인 출력
		System.out.println("\n<<< /chat/getChatting :: POST :: sender 도메인  \n"+dbSender);
		System.out.println("\n<<< /chat/getChatting :: POST :: recipient 도메인  \n"+dbRecipient);
		
		
		
		//Model(data) & View(jsp)
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("sender", dbSender);
		modelAndView.addObject("recipient", dbRecipient);
		
		//modelAndView.setViewName("forward:/view/chat/chatting2.jsp");
		modelAndView.setViewName("forward:/view/chat2/chatting.jsp");
		
		return modelAndView;
	}
	
	//수정된 부분. RequestMethod
	@RequestMapping( value="getGroupChatting", method=RequestMethod.POST)
	public ModelAndView getGroupChatting(@RequestParam("sender") String sender, @RequestParam("partyNo") String partyNo) throws Exception {
		
		System.out.println("\n>>> /chat/getGroupChatting :: POST start <<<");
		
		//sender, recipient 파라미터 출력
		System.out.println(">>> /chat/getGroupChatting :: POST :: sender 파라미터 \n"+sender);
		System.out.println(">>> /chat/getGroupChatting :: POST :: partyNo 파라미터 \n"+partyNo);
		
		int dbPartyNo = Integer.parseInt(partyNo);
		
		User dbSender = userService.getUser(sender);
		Party dbParty = partyService.getParty(dbPartyNo, "");
		//도메인 출력
		System.out.println("\n<<< /chat/getChatting :: POST :: sender 도메인  \n"+dbSender);
		System.out.println("\n<<< /chat/getChatting :: POST :: party 도메인  \n"+dbParty);
		
		
		//Model(data) & View(jsp)
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("sender", dbSender);
		modelAndView.addObject("party", dbParty);
		
		modelAndView.setViewName("forward:/view/chat/groupChatting.jsp");
		
		return modelAndView;
	}
	
	//나의채팅목록
	@RequestMapping( value="getChattingList")
	public ModelAndView getChattingList(HttpSession session) throws Exception {
		
		System.out.println("\n>>> /chat/getChattingList :: POST start <<<");
		
		User sender = (User)session.getAttribute("user");
		ModelAndView modelAndView = new ModelAndView();
		
		if(sender != null) {
			modelAndView.addObject("sender", sender);
			modelAndView.setViewName("/view/chat/getChattingList.jsp");
		} 
		
		return modelAndView;
	}

}

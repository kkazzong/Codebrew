package com.codebrew.moana.web.party;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.eclipse.jdt.internal.compiler.parser.ParserBasicInformation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.codebrew.moana.service.domain.Party;
import com.codebrew.moana.service.domain.Ticket;
import com.codebrew.moana.service.domain.User;
import com.codebrew.moana.service.party.PartyService;
import com.codebrew.moana.service.ticket.TicketService;


//==> 파티관리 Controller
@Controller
@RequestMapping("/party/*")
public class PartyController {

	///Field///
	@Autowired
	@Qualifier("partyServiceImpl")
	private PartyService partyService;
	
	@Autowired
	@Qualifier("ticketServiceImpl")
	private TicketService ticketService;
	
	
	///Constructor///
	public PartyController() {
		super();
		// TODO Auto-generated constructor stub
		System.out.println(">>> "+this.getClass()+" Default Constructor Call <<<");
	}
	
	
	///Method///
	@RequestMapping( value="addParty", method=RequestMethod.GET)
	public ModelAndView addParty(@RequestParam("userId") String userId){
		
		System.out.println("\n>>> /party/addParty :: GET start <<<");
		
		System.out.println("addParty :: userId :: "+userId);
		
		
		User user = new User();
		user.setUserId(userId);
		user.setNickname("쎄리");
		
		//Model(data) & View(jsp)
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject(user);
		modelAndView.setViewName("/view/party/addParty.jsp");
		
		return modelAndView;
	}
	
	@RequestMapping( value="addParty", method=RequestMethod.POST)
	public ModelAndView addParty(@ModelAttribute("party") Party party, HttpServletRequest request) throws Exception {
		
		System.out.println("\n>>> /party/addParty :: POST start <<<");
		
		//party 도메인 출력
		System.out.println(">>> /party/addParty party 도메인 \n"+party);
		
		//Party Image Upload
		MultipartFile uploadfile = party.getUploadFile();
		
		if(uploadfile != null){
			String partyImage = uploadfile.getOriginalFilename();
			System.out.println("uploaded file name :: "+partyImage);
			
			String fileDirectory = request.getServletContext().getInitParameter("fileDirectory");
			System.out.println("uploaded file Directory :: "+fileDirectory);
			
			if(partyImage != null && !partyImage.equals("")){
				partyImage = System.currentTimeMillis()+"_"+partyImage;
				
				File file = new File(fileDirectory+partyImage);
				uploadfile.transferTo(file);
				party.setPartyImage(partyImage);
			}
			
		}
		
		//partyTime = hour + minutes
		party.setPartyTime(party.getHour()+"시 "+party.getMinutes()+"분");
		System.out.println("Party Time ==>"+party.getPartyTime());
		
		//Business Logic
		/* 파티 등록 */
		partyService.addParty(party);
		
		
		/* 파티 티켓 등록 */
		Ticket ticket = new Ticket();
		ticket.setParty(party);
		ticket.setTicketPrice(party.getTicketPrice());
		ticket.setTicketCount(party.getTicketCount());

		ticketService.addTicket(ticket);
		
		//Model(data) & View(jsp)
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject(party);
		modelAndView.setViewName("/view/party/getParty.jsp");
		
		return modelAndView;
	}

	
	////////////////////////////////////////////////////////////////
	/*@RequestMapping( value="getProfileImage", method=RequestMethod.GET)
	public MultipartFile getProfileImage(@RequestParam("userId") String userId){
		MultipartFile uploadfile = party.getUploadFile();
		
	}*/
}

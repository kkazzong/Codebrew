package com.codebrew.moana.web.party;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.eclipse.jdt.internal.compiler.parser.ParserBasicInformation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
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
	
	
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	@Value("#{imageRepositoryProperties['partyImageDir']}")
	String partyImageDir;
	
	
	///Constructor///
	public PartyController() {
		super();
		// TODO Auto-generated constructor stub
		System.out.println(">>> "+this.getClass()+" Default Constructor Call <<<");
	}
	
	
	///Method///
	@RequestMapping( value="addParty", method=RequestMethod.GET)
	public ModelAndView addParty(){
		
		System.out.println("\n>>> /party/addParty :: GET start <<<");
		
		//Model(data) & View(jsp)
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("forward:/view/party/addParty.jsp");
		
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
			
			String fileDirectory = partyImageDir;
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

	
	@RequestMapping( value="joinParty", method=RequestMethod.POST )
	public ModelAndView joinParty(@ModelAttribute("party") Party party, HttpSession session) {
		
		System.out.println("\n>>> /party/joinParty :: POST start <<<");
		
		int partyNo = party.getPartyNo();
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("partyNo", partyNo);
		
		return null; 
	}
	
	@RequestMapping( value="deleteParty", method=RequestMethod.POST )
	public ModelAndView deleteParty(@RequestParam("partyNo") String partyNo, HttpSession session) {
		
		
		return null;
	}
}

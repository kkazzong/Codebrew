package com.codebrew.moana.web.party;

import java.io.File;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.codebrew.moana.common.Page;
import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Party;
import com.codebrew.moana.service.domain.PartyMember;
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
	public ModelAndView addParty(@ModelAttribute("party") Party party, HttpServletRequest request, HttpSession session) throws Exception {
		
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
		/* 파티 티켓 셋팅 */
		Ticket ticket = new Ticket();
		ticket.setTicketPrice(party.getTicketPrice());
		ticket.setTicketCount(party.getTicketCount());
		
		/* 파티 등록 */
		Party dbParty = partyService.addParty(party);
		//party = partyService.getParty(party.getPartyNo(), party.getPartyFlag());
		//party 도메인 출력
		System.out.println("\n<<< /party/addParty :: POST :: 결과 party 도메인  \n"+dbParty);
		
		/* 파티 티켓 등록 */
		if(dbParty.getFestival() == null) {
			ticket.setParty(dbParty);
			ticket = ticketService.addTicket(ticket);
			//ticket 도메인 출력
			System.out.println("\n<<< /party/addParty :: POST :: 결과 ticket 도메인  \n"+ticket);
		}
		
		/* 주최자 파티 멤버 셋팅 */
		PartyMember partyMember = new PartyMember();
		User user = (User)session.getAttribute("user");
		partyMember.setParty(party);
		partyMember.setUser(user);
		partyMember.setRole("host");
		
		/* 주최자 파티 멤버 등록 */
		Map<String, Object> map = partyService.joinParty(partyMember);
		//Map<String, Object> map = partyService.getPartyMemberList(party.getPartyNo(), new Search());
		
		/*파티 비율 셋팅*/
		Party partyRatio = partyService.getGenderRatio(dbParty.getPartyNo());
		dbParty.setFemalePercentage(partyRatio.getFemalePercentage());
		dbParty.setFemaleAgeAverage(partyRatio.getFemaleAgeAverage());
		dbParty.setMalePercentage(partyRatio.getMalePercentage());
		dbParty.setMaleAgeAverage(partyRatio.getMaleAgeAverage());
		
		//Model(data) & View(jsp)
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("party", dbParty);
		modelAndView.addObject("ticket", ticket);
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("currentMemberCount", map.get("currentMemberCount"));
		modelAndView.setViewName("/view/party/getParty.jsp");
		
		return modelAndView;
	}

	
	@RequestMapping( value="joinParty", method=RequestMethod.GET )
	public ModelAndView joinParty(@RequestParam("partyNo") String partyNo, HttpSession session) throws Exception {
		
		System.out.println("\n>>> /party/joinParty :: GET start <<<");
		//partyNo 파라미터 출력
		System.out.println(">>> /party/joinParty partyNo 파라미터 \n"+partyNo);
		
		//PartyMember 정보 셋팅
		Party party = new Party();
		int dbPartyNo = Integer.parseInt(partyNo);
		party.setPartyNo(dbPartyNo);
		
		PartyMember partyMember = new PartyMember();
		partyMember.setParty(party);
		partyMember.setRole("guest");
		
		User user = (User)session.getAttribute("user");
		partyMember.setUser(user);
		
		
		//Business Logic
		partyService.joinParty(partyMember);
		
		//Model(data) & View(jsp)
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("party", party);
		modelAndView.setViewName("/view/party/getParty.jsp");
		
		return modelAndView;
	}
	
	
	@RequestMapping( value="cancelParty", method=RequestMethod.GET )
	public ModelAndView cancelParty(@RequestParam("partyNo") String partyNo, HttpSession session) throws Exception {
		
		System.out.println("\n>>> /party/cancelParty :: GET start <<<");
		//partyNo 파라미터 출력
		System.out.println(">>> /party/cancelParty :: GET :: partyNo 파라미터 \n"+partyNo);
		
		
		//Business Logic
		int dbPartyNo = Integer.parseInt(partyNo);
		User user = (User)session.getAttribute("user");
		String userId = user.getUserId();
		
		partyService.cancelParty(dbPartyNo, userId);
		

		//Model(data) & View(jsp)
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/view/party/getParty.jsp");
		
		return modelAndView;
	}
	
	
	@RequestMapping( value="deletePartyMember", method=RequestMethod.GET )
	public ModelAndView deletePartyMember(@RequestParam("partyNo") String partyNo, HttpSession session) throws Exception {
		
		System.out.println("\n>>> /party/deletePartyMember :: GET start <<<");
		//partyNo 파라미터 출력
		System.out.println(">>> /party/deletePartyMember :: GET :: partyNo 파라미터 \n"+partyNo);
		
		
		//Business Logic
		int dbPartyNo = Integer.parseInt(partyNo);
		User user = (User)session.getAttribute("user");
		String userId = user.getUserId();
		
		partyService.cancelParty(dbPartyNo, userId);
		

		//Model(data) & View(jsp)
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/view/party/getMyPartyList.jsp");
		
		return modelAndView;
	}
	
	
	@RequestMapping( value="getParty", method=RequestMethod.GET )
	public ModelAndView getParty(@RequestParam("partyNo") String partyNo, @RequestParam(value="partyFlag", required=false) String partyFlag) throws Exception {
		
		System.out.println("\n>>> /party/getParty :: GET start <<<");
		
		//partyNo, partyFlag 파라미터 출력
		System.out.println(">>> /party/getParty partyNo 파라미터 \n"+partyNo);
		System.out.println(">>> /party/getParty partyFlag 파라미터 \n"+partyFlag);
		
		
		Search search = new Search();
		
		/*if(search.getCurrentPage() == 0){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);*/

		
		//Business Logic
		int dbPartyNo = Integer.parseInt(partyNo);
		Party dbParty = partyService.getGenderRatio(dbPartyNo);
		Ticket ticket = ticketService.getTicket(dbPartyNo, "2");
		//Party party = partyService.getParty(dbPartyNo, partyFlag);
		Party party = partyService.getParty(dbPartyNo, partyFlag);
		
		
		party.setFemalePercentage(dbParty.getFemalePercentage());
		party.setFemaleAgeAverage(dbParty.getFemaleAgeAverage());
		party.setMalePercentage(dbParty.getMalePercentage());
		party.setMaleAgeAverage(dbParty.getMaleAgeAverage());
		
		//party 도메인 출력
		System.out.println("\n<<< /party/getParty party 도메인  \n"+party);
		
		Map<String, Object> map = partyService.getPartyMemberList(dbPartyNo, search);
		
		/*Page resultPage = new Page(search.getCurrentPage(),((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);*/
	
		
		//Model(data) & View(jsp)
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("party", party);
		modelAndView.addObject("ticket", ticket);
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("currentMemberCount", map.get("currentMemberCount"));
		modelAndView.setViewName("/view/party/getParty.jsp");
		
		return modelAndView;
	}
	
	
	@RequestMapping( value="updateParty", method=RequestMethod.GET )
	public ModelAndView updateParty(@RequestParam("partyNo") String partyNo, @RequestParam("partyFlag") String partyFlag) throws Exception {
		
		System.out.println("\n>>> /party/updateParty :: GET start <<<");
		
		//partyNo 파라미터 출력
		System.out.println(">>> /party/updateParty partyNo 파라미터 \n"+partyNo);
		
		//Business Logic
		int dbPartyNo = Integer.parseInt(partyNo);
		Party party = partyService.getParty(dbPartyNo, partyFlag);
		Ticket ticket = ticketService.getTicket(dbPartyNo, "2");
		
		//Model(data) & View(jsp)
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("party", party);
		modelAndView.addObject("ticket", ticket);
		modelAndView.setViewName("forward:/view/party/updateParty.jsp");
		
		return modelAndView;
	}
	
	
	@RequestMapping( value="updateParty", method=RequestMethod.POST)
	public ModelAndView updateParty(@ModelAttribute("party") Party party, HttpServletRequest request) throws Exception {
		
		System.out.println("\n>>> /party/updateParty :: POST start <<<");
		
		//party 도메인 파라미터 출력
		System.out.println(">>> /party/updateParty party 도메인 파라미터 \n"+party);
		
		
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
		/* 티켓 수정 */
		Ticket ticket = new Ticket();
		ticket.setParty(party);
		ticket.setTicketCount(party.getTicketCount());
		ticket.setTicketPrice(party.getTicketPrice());
		
		ticket=ticketService.updateTicket(ticket);
		//ticket 도메인 출력
		System.out.println("\n<<< /party/updateParty ticket 도메인  \n"+ticket);
		
		/* 파티 수정 */
		Party dbParty = partyService.updateParty(party);
		
		/*int partyNo = party.getPartyNo();
		String partyFlag = party.getPartyFlag();
		
		party = partyService.getParty(partyNo, partyFlag);*/
		//party 도메인 출력
		System.out.println("\n<<< /party/updateParty :: POST :: party 출력 도메인  \n"+dbParty);
		
		
		//Model(data) & View(jsp)
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("party", dbParty);
		modelAndView.addObject("ticket", ticket);
		modelAndView.setViewName("forward:/view/party/getParty.jsp");
		
		return modelAndView;
	}
	
	
	@RequestMapping( value="getPartyList", method=RequestMethod.GET)
	public ModelAndView getPartyList( @RequestParam(value="festivalNo", required=false) String festivalNo ) throws Exception {
		
		System.out.println("\n>>> /party/getPartyList :: GET start <<<");
		
		Search search = new Search();
		
		if( festivalNo != null) {
			//festivalNo 파라미터 출력
			System.out.println(">>> /party/getPartyList festivalNo 파라미터 \n"+festivalNo); 
			search.setSearchCondition("5");
			search.setSearchKeyword(festivalNo);
		}
		
		if(search.getCurrentPage() == 0){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		System.out.println("\n<<< /party/getPartyList :: GET :: search 도메인\n"+search);
		
		
		//Business Logic
		Map<String, Object> map = partyService.getPartyList(search);
	
		Page resultPage = new Page(search.getCurrentPage(),((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
	
		
		//Model(data) & View(jsp)
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);
		modelAndView.setViewName("forward:/view/party/getPartyList.jsp");
		
		return modelAndView;
		
	}
	
	
	@RequestMapping( value="getPartyList", method=RequestMethod.POST)
	public ModelAndView getPartyList( @ModelAttribute("search") Search search) throws Exception{
		
		System.out.println("\n>>> /party/getPartyList :: POST start <<<");

		//search 도메인 파라미터 출력
		System.out.println(">>> /party/getPartyList search 도메인 파라미터 \n"+search);
				
		if(search.getCurrentPage() == 0){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		System.out.println("\n<<< /party/getPartyList :: POST :: currentPage\n"+search.getCurrentPage());
		
		
		//Business Logic
		Map<String, Object> map = partyService.getPartyList(search);
		
		Page resultPage = new Page(search.getCurrentPage(),((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		
		//Model(data) & View(jsp)
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);
		modelAndView.setViewName("forward:/view/party/getPartyList.jsp");
		
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
		System.out.println("\n<<< /party/getMyPartyList :: GET :: pageSize\n"+search.getPageSize());
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
		
		return modelAndView;
		
	}
	
	
	@RequestMapping( value="getPartyMemberList", method=RequestMethod.GET)
	public ModelAndView getPartyMemberList(@RequestParam("partyNo") String partyNo) throws Exception {
		
		System.out.println("\n>>> /party/getPartyMemberList :: GET start <<<");

		//partyNo 파라미터 출력
		System.out.println(">>> /party/getPartyMemberList partyNo 파라미터 \n"+partyNo);
		
		Search search = new Search();
		
		if(search.getCurrentPage() == 0){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		System.out.println("\n<<< /party/getPartyList currentPage\n"+search.getCurrentPage());
		
		
		//Business Logic
		int dbPartyNo = Integer.parseInt(partyNo);
		Map<String, Object> map = partyService.getPartyMemberList(dbPartyNo, search);
		
		Page resultPage = new Page(search.getCurrentPage(),((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		
		//Model(data) & View(jsp)
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);
		//modelAndView.setViewName("forward:/view/party/getPartyMemberList.jsp");
				
		return modelAndView;
	}
	
	
	@RequestMapping( value="getGenderRatio", method=RequestMethod.GET)
	public ModelAndView getGenderRatio(@RequestParam("partyNo") String partyNo) throws Exception {
		
		System.out.println("\n>>> /party/getGenderRatio :: GET start <<<");

		//partyNo 파라미터 출력
		System.out.println(">>> /party/getGenderRatio partyNo 파라미터 \n"+partyNo);
		
		
		//Business Logic
		int dbPartyNo = Integer.parseInt(partyNo);
		
		Party party = partyService.getGenderRatio(dbPartyNo);
		//party 도메인 출력
		System.out.println("\n<<< /party/getGenderRatio party 도메인  \n"+party);
		
		
		//Model(data) & View(jsp)
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("party", party);
		//modelAndView.setViewName("forward:/view/party/getParty.jsp");
		
		return modelAndView;
	}
}

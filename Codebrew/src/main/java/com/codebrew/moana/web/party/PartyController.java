package com.codebrew.moana.web.party;

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
	
	@Autowired
	@Qualifier("festivalServiceImpl")
	private FestivalService festivalService;
	
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
		System.out.println("\n>>> "+this.getClass()+" Default Constructor Call <<<\n");
	}
	
	
	///Method///
	@RequestMapping( value="addParty", method=RequestMethod.GET)
	public ModelAndView addParty(@RequestParam(value = "festivalNo", required = false) String festivalNo) throws Exception{
		
		System.out.println("\n>>> /party/addParty :: GET start <<<");
		
		//festivalNo 파라미터 출력
		System.out.println(">>> /party/addParty :: GET :: festivalNo 파라미터 \n"+festivalNo);
		
		
		//Model(data) & View(jsp)
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("forward:/view/party/addParty.jsp");
		
		
		//Business Logic
		if( festivalNo != null ) {
			int dbFestivalNo = Integer.parseInt(festivalNo);
			Festival festival = festivalService.getFestivalDB(dbFestivalNo);
		
			modelAndView.addObject("festival", festival);
			
			modelAndView.setViewName("forward:/view/party/addAfterParty.jsp");
		}
		
		
		return modelAndView;
	}
	
	@RequestMapping( value="addParty", method=RequestMethod.POST)
	public ModelAndView addParty(@ModelAttribute("party") Party party, HttpServletRequest request, HttpSession session) throws Exception {
		
		System.out.println("\n>>> /party/addParty :: POST start <<<");
		
		//party 도메인 출력
		System.out.println(">>> /party/addParty :: POST :: party 도메인 \n"+party);
		
		
		//Party Image Upload
				MultipartFile uploadfile = party.getUploadFile();
				
				if(uploadfile != null){
					String partyImage = uploadfile.getOriginalFilename();
					System.out.println("\nuploaded file name :: "+partyImage);
					
					String orgFileDirectory = partyImageDir;
					System.out.println("\nuploaded file Directory :: "+orgFileDirectory);
					
					//WAS 배포 경로
					String disFileDirectory = session.getServletContext().getRealPath("/")+"\\resources\\uploadFile\\";
					System.out.println("\nWAS distributed file Directory :: "+disFileDirectory);
					
					
					if(partyImage != null && !partyImage.equals("")){
						partyImage = System.currentTimeMillis()+"_"+partyImage;
						
						File orgFile = new File(orgFileDirectory+partyImage);
						File disFile = new File(disFileDirectory+partyImage);
						uploadfile.transferTo(disFile);
						
						FileInputStream fis = null;
						FileOutputStream fos = null; 

						try {
							fis = new FileInputStream(disFile); // 원본파일
							fos = new FileOutputStream(orgFile); // 복사위치
							   
							byte[] buffer = new byte[1024];
							int readcount = 0;
							  
							while((readcount=fis.read(buffer)) != -1) {
								fos.write(buffer, 0, readcount); // 파일 복사 
							}
						} catch(Exception e) {
							e.printStackTrace();
						} finally {
							fis.close();
							fos.close();
						}
						
						party.setPartyImage(partyImage);
					}
				}
		
		
		
		//partyTime = hour + minutes
		party.setPartyTime(party.getHour()+"시 "+party.getMinutes()+"분");
		
		/////////// 디비 입출력시 엔터처리 ////////////////
		String partyDetail = party.getPartyDetail();
		partyDetail = partyDetail.replaceAll("\n", "<br>");
		System.out.println("\n<<< /party/addParty :: POST :: partyDetail \n"+partyDetail);
		party.setPartyDetail(partyDetail);
		/////////// 디비 입출력시 엔터처리 ////////////////
		
		
		//Business Logic
		/* 세션 */
		User user = (User)session.getAttribute("user");
		
		/* 파티 티켓 셋팅 */
		Ticket ticket = new Ticket();
		ticket.setTicketPrice(party.getTicketPrice());
		ticket.setTicketCount(party.getTicketCount());
		
		/* 파티 등록 */
		party.setUser(user);
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
		partyMember.setParty(dbParty);
		partyMember.setUser(user);
		partyMember.setRole("host");
		
		/* 주최자 파티 멤버 등록 */
		partyService.joinParty(partyMember);
		//Map<String, Object> map = partyService.getPartyMemberList(party.getPartyNo(), new Search());
		
		/*파티 비율 셋팅*/
		/*Party partyRatio = partyService.getGenderRatio(dbParty.getPartyNo());
		dbParty.setFemalePercentage(partyRatio.getFemalePercentage());
		dbParty.setFemaleAgeAverage(partyRatio.getFemaleAgeAverage());
		dbParty.setMalePercentage(partyRatio.getMalePercentage());
		dbParty.setMaleAgeAverage(partyRatio.getMaleAgeAverage());*/
		
		//Model(data) & View(jsp)
		ModelAndView modelAndView = new ModelAndView();
		//dbParty.setUser(user);
		modelAndView.addObject("party", dbParty);
		modelAndView.addObject("ticket", ticket);
		//modelAndView.addObject("list", map.get("list"));
		//modelAndView.addObject("currentMemberCount", map.get("currentMemberCount"));
		//modelAndView.setViewName("/view/party/getParty.jsp");
		modelAndView.setViewName("redirect:/party/getParty?partyNo="+dbParty.getPartyNo());
		
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
		//Map<String, Object> map = partyService.joinParty(partyMember);
		Party dbParty = partyService.joinParty(partyMember);
		System.out.println("\n<<< /party/joinParty :: GET :: party도메인\n"+dbParty);
		
		//Model(data) & View(jsp)
		ModelAndView modelAndView = new ModelAndView();
		//modelAndView.addObject("list", map.get("list"));
		//modelAndView.addObject("currentMemberCount", map.get("currentMemberCount"));
		modelAndView.addObject("party", dbParty);
		modelAndView.setViewName("redirect:/party/getParty?partyNo="+dbParty.getPartyNo());
		
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
		
		Party party = partyService.cancelParty(dbPartyNo, userId);
		System.out.println("\n<<< /party/cancelParty :: GET :: party도메인\n"+party);

		//Model(data) & View(jsp)
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("party", party);
		modelAndView.setViewName("redirect:/party/getParty?partyNo="+party.getPartyNo());
		
		return modelAndView;
	}
	
	
	@RequestMapping( value="deleteMyPartyList", method=RequestMethod.POST )
	public ModelAndView deleteMyPartyList(@ModelAttribute("partyNo") String partyNo, HttpSession session) throws Exception {
		
		System.out.println("\n>>> /party/deleteMyPartyList :: POST start <<<");
		//partyNo 파라미터 출력
		System.out.println(">>> /party/deleteMyPartyList :: POST :: partyNo 파라미터 \n"+partyNo);
		
		Search search = new Search();
		
		if(search.getCurrentPage() == 0){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		search.setSearchCondition("4");
		
		System.out.println("\n<<< /party/deleteMyPartyList :: POST :: search\n"+search);
		
		//Business Logic
		int dbPartyNo = Integer.parseInt(partyNo);
		User user = (User)session.getAttribute("user");
		String userId = user.getUserId();
		
		partyService.deleteMyPartyList(dbPartyNo, userId);
		Map<String,Object> map = partyService.getMyPartyList(search, userId);
		
		Page resultPage = new Page(search.getCurrentPage(),((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		
		//Model(data) & View(jsp)
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);
		modelAndView.setViewName("forward:/view/party/getMyPartyList.jsp");
		
		return modelAndView;
	}
	
	
	@RequestMapping( value="getParty", method=RequestMethod.GET )
	public ModelAndView getParty(@RequestParam("partyNo") String partyNo, @RequestParam(value="partyFlag", required=false) String partyFlag, HttpSession session) throws Exception {
		
		System.out.println("\n>>> /party/getParty :: GET start <<<");
		
		//partyNo, partyFlag 파라미터 출력
		System.out.println(">>> /party/getParty :: GET :: partyNo 파라미터 \n"+partyNo);
		System.out.println(">>> /party/getParty :: GET :: partyFlag 파라미터 \n"+partyFlag);
		
		
		Search search = new Search();
		
		if(search.getCurrentPage() == 0){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);

		
		//Business Logic
		int dbPartyNo = Integer.parseInt(partyNo);
		//Party dbParty = partyService.getGenderRatio(dbPartyNo);
		Ticket ticket = ticketService.getTicket(dbPartyNo, "2");
		Party party = partyService.getParty(dbPartyNo, partyFlag);
		
		
		/*party.setFemalePercentage(dbParty.getFemalePercentage());
		party.setFemaleAgeAverage(dbParty.getFemaleAgeAverage());
		party.setMalePercentage(dbParty.getMalePercentage());
		party.setMaleAgeAverage(dbParty.getMaleAgeAverage());*/
		
		//party 도메인 출력
		System.out.println("\n<<< /party/getParty :: GET :: party 도메인  \n"+party);
		
		//partyPlace Parsing
		String dbPartyPlace = party.getPartyPlace();
		int index = dbPartyPlace.indexOf(',');
		
		if( index != -1) {
			dbPartyPlace = dbPartyPlace.substring(0, index);
			party.setPartyPlace(dbPartyPlace);
			
			System.out.println("\n<<< /party/getParty :: GET :: psPartyPlace \n"+dbPartyPlace);
		}
		
		System.out.println("\n<<< /party/getParty :: GET :: party 도메인2 \n"+party);
		
		Map<String, Object> map = partyService.getPartyMemberList(dbPartyNo, search);
		
		/*Page resultPage = new Page(search.getCurrentPage(),((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);*/
	
		//user 
		User user = (User)session.getAttribute("user");
		System.out.println("\n<<< /party/getParty :: GET :: user 도메인 \n"+user);
		
		
		//Model(data) & View(jsp)
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("party", party);
		modelAndView.addObject("ticket", ticket);
		//modelAndView.addObject("user", user);
		
		//modelAndView.addObject("list", map.get("list"));
		//modelAndView.addObject("currentMemberCount", map.get("currentMemberCount"));
		modelAndView.setViewName("forward:/view/party/getParty.jsp");
		
		return modelAndView;
	}
	
	
	@RequestMapping( value="updateParty", method=RequestMethod.GET )
	public ModelAndView updateParty(@RequestParam("partyNo") String partyNo, @RequestParam("partyFlag") String partyFlag) throws Exception {
		
		System.out.println("\n>>> /party/updateParty :: GET start <<<");
		
		//partyNo 파라미터 출력
		System.out.println(">>> /party/updateParty :: GET ::  partyNo 파라미터 \n"+partyNo);
		
		//Business Logic
		int dbPartyNo = Integer.parseInt(partyNo);
		Party party = partyService.getParty(dbPartyNo, partyFlag);
		Ticket ticket = ticketService.getTicket(dbPartyNo, "2");
		
		/////////// 디비 입출력시 엔터처리 ////////////////
		String partyDetail = party.getPartyDetail();
		partyDetail = partyDetail.replaceAll("<br>", "\n");
		party.setPartyDetail(partyDetail);
		/////////// 디비 입출력시 엔터처리 ////////////////
		
		
		//Model(data) & View(jsp)
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("party", party);
		modelAndView.addObject("ticket", ticket);
		modelAndView.setViewName("forward:/view/party/updateParty.jsp");
		
		return modelAndView;
	}
	
	
	@RequestMapping( value="updateParty", method=RequestMethod.POST)
	public ModelAndView updateParty(@ModelAttribute("party") Party party, HttpServletRequest request, HttpSession session) throws Exception {
		
		System.out.println("\n>>> /party/updateParty :: POST start <<<");
		
		//party 도메인 파라미터 출력
		System.out.println(">>> /party/updateParty :: POST :: party 도메인 파라미터 \n"+party);
		
		
		//Party Image Upload
		MultipartFile uploadfile = party.getUploadFile();
		
		if(uploadfile != null){
			String partyImage = uploadfile.getOriginalFilename();
			System.out.println("\nuploaded file name :: "+partyImage);
			
			String orgFileDirectory = partyImageDir;
			System.out.println("\nuploaded file Directory :: "+orgFileDirectory);
			
			//WAS 배포 경로
			String disFileDirectory = session.getServletContext().getRealPath("/")+"\\resources\\uploadFile\\";
			System.out.println("\nWAS distributed file Directory :: "+disFileDirectory);
			
			
			if(partyImage != null && !partyImage.equals("")){
				partyImage = System.currentTimeMillis()+"_"+partyImage;
				
				File orgFile = new File(orgFileDirectory+partyImage);
				File disFile = new File(disFileDirectory+partyImage);
				uploadfile.transferTo(disFile);
				
				FileInputStream fis = null;
				FileOutputStream fos = null; 

				try {
					fis = new FileInputStream(disFile); // 원본파일
					fos = new FileOutputStream(orgFile); // 복사위치
					   
					byte[] buffer = new byte[1024];
					int readcount = 0;
					  
					while((readcount=fis.read(buffer)) != -1) {
						fos.write(buffer, 0, readcount); // 파일 복사 
					}
				} catch(Exception e) {
					e.printStackTrace();
				} finally {
					fis.close();
					fos.close();
				}
				
				party.setPartyImage(partyImage);
			}
		}
		
		//partyTime = hour + minutes
		party.setPartyTime(party.getHour()+"시 "+party.getMinutes()+"분");
		
		/////////// 디비 입출력시 엔터처리 ////////////////
		String partyDetail = party.getPartyDetail();
		partyDetail = partyDetail.replaceAll("\n", "<br>");
		System.out.println("\n<<< /party/addParty :: POST :: partyDetail \n"+partyDetail);
		party.setPartyDetail(partyDetail);
		/////////// 디비 입출력시 엔터처리 ////////////////
		
		
		//Business Logic
		/* 티켓 수정 */
		Ticket ticket = new Ticket();
		ticket.setParty(party);
		ticket.setTicketCount(party.getTicketCount());
		ticket.setTicketPrice(party.getTicketPrice());
		
		ticket=ticketService.updateTicket(ticket);
		//ticket 도메인 출력
		System.out.println("\n<<< /party/updateParty :: POST :: ticket 도메인  \n"+ticket);
		
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
		modelAndView.setViewName("redirect:/party/getParty?partyNo="+dbParty.getPartyNo());
		
		return modelAndView;
	}
	
	
	@RequestMapping( value="getPartyList", method=RequestMethod.GET)
	public ModelAndView getPartyList( @RequestParam(value="festivalNo", required=false) String festivalNo,  @RequestParam(value="partyFlag", required=false) String partyFlag ) throws Exception {
		
		System.out.println("\n>>> /party/getPartyList :: GET start <<<");
		
		Search search = new Search();
		
		if( festivalNo != null) {
			//festivalNo 파라미터 출력
			System.out.println(">>> /party/getPartyList :: GET :: festivalNo 파라미터 \n"+festivalNo); 
			search.setSearchCondition("5");
			search.setSearchKeyword(festivalNo);
		}else if( partyFlag == "1" ){
			search.setSearchCondition("1");
		}else if( partyFlag == "2" ) {
			search.setSearchCondition("2");
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
		System.out.println(">>> /party/getPartyList :: POST :: search 도메인 파라미터 \n"+search);
				
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
/*		  modelAndView.setViewName("forward:/user/mypage/getMyPage2.jsp");*/
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
		/*System.out.println("\n<<< /party/getMyPartyList :: GET :: currentPage\n"+search.getCurrentPage());
		System.out.println("\n<<< /party/getMyPartyList :: GET :: startPage\n"+search.getStartRowNum());
		System.out.println("\n<<< /party/getMyPartyList :: GET :: endPage\n"+search.getEndRowNum());*/
		
		
		String userId = ((User)session.getAttribute("user")).getUserId();
		System.out.println("\n<<< /party/getMyPartyList :: GET :: userId\n"+userId);
		
		
		//Business Logic
		Map<String, Object> map = partyService.getMyPartyListByUserId(userId);
		
		Page resultPage = new Page(search.getCurrentPage(),((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		
		//Model(data) & View(jsp)
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);
	    /*modelAndView.setViewName("forward:/view/party/getMyPartyList.jsp");*/
		modelAndView.setViewName("forward:/view/party/getMyPartyList3.jsp");
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
		
		System.out.println("\n<<< /party/getPartyList :: GET :: search 도메인\n"+search);
		
		
		//Business Logic
		int dbPartyNo = Integer.parseInt(partyNo);
		Map<String, Object> map = partyService.getPartyMemberList(dbPartyNo, search);
		
		Page resultPage = new Page(search.getCurrentPage(),((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		
		//Model(data) & View(jsp)
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);
		modelAndView.setViewName("forward:/view/party/getPartyMemberList.jsp");
				
		return modelAndView;
	}
	
	
	/*@RequestMapping( value="getGenderRatio", method=RequestMethod.GET)
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
	}*/
}

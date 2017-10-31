package com.codebrew.moana.web.festival;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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

import com.codebrew.moana.common.Page;
import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Festival;
import com.codebrew.moana.service.domain.Ticket;
import com.codebrew.moana.service.domain.User;
import com.codebrew.moana.service.domain.Weather;
import com.codebrew.moana.service.domain.Zzim;
import com.codebrew.moana.service.festival.FestivalService;
import com.codebrew.moana.service.ticket.TicketService;

@Controller
@RequestMapping("/festival/*")
public class FestivalController {

	@Autowired
	@Qualifier("festivalServiceImpl")
	private FestivalService festivalService;

	@Autowired
	@Qualifier("ticketServiceImpl")
	private TicketService ticketService;

	public FestivalController() {
		System.out.println(this.getClass());
	}

	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	@Value("#{commonProperties['pageSize']}")
	int pageSize;

	@Value("#{imageRepositoryProperties['fileRoot']}")
	String fileRoot;
	
	@RequestMapping(value = "/deleteZzim/{festivalNo}/{userId}" , method = RequestMethod.GET)
	public ModelAndView deleteZzim(@PathVariable ("festivalNo") int festivalNo, @PathVariable ("userId") String userId)
			throws Exception {

		System.out.println("deleteZzim........");
		

		Zzim returnZzim = new Zzim(userId, festivalNo);

		festivalService.deleteZzim(returnZzim);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("forward:/festival/getMyZzimList");
		
		return modelAndView;


	}
	
	@RequestMapping(value = "getMyZzimList")
	public ModelAndView getMyZzimList(@ModelAttribute("search") Search search,
			@ModelAttribute("page") Page page, HttpServletRequest request) throws Exception {

		
		System.out.println("getzzim............" + search);
		
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

		modelAndView.setViewName("forward:/view/festival/getMyZzimList.jsp");
		
		modelAndView.addObject("search", search);
		modelAndView.addObject("list", list);
		modelAndView.addObject("resultPage", resultPage);
		

		return modelAndView;


	}
	
	@RequestMapping(value = "getFestivalListDB")
	public ModelAndView getFestivalListDB(@ModelAttribute("search") Search search, @ModelAttribute("page") Page page,
			@RequestParam("menu") String menu) throws Exception {

		System.out.println("search 확인 : " + search);
		
		System.out.println("menu 확인........" + menu);

		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);

		Map<String, Object> map = festivalService.getFestivalListDB(search);

		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit,
				pageSize);

		ModelAndView modelAndView = new ModelAndView();

		modelAndView.addObject("search", search);
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);

		if (menu.equals("db")) {
			modelAndView.setViewName("forward:/view/festival/getFestivalListDB.jsp");
		} else {
			modelAndView.setViewName("forward:/view/festival/popupListDB.jsp");
		}

		return modelAndView;

	}

	@RequestMapping(value = "weather")
	public ModelAndView weather(@RequestParam("festivalLongitude") String festivalLongitude,
			@RequestParam("festivalLatitude") String festivalLatitude) throws Exception {

		System.out.println("weather");

		String[] festivalLat = festivalLatitude.split(".");
		String[] festivalLon = festivalLongitude.split(".");

		Weather weather = festivalService.weather(festivalLat[0], festivalLon[0]);

		ModelAndView modelAndView = new ModelAndView();

		modelAndView.addObject("weather", weather);

		modelAndView.setViewName("forward:/view/festival/weather.jsp");

		return modelAndView;
	}

	@RequestMapping(value = "writeFestival")
	public ModelAndView writeFestival(@ModelAttribute("festival") Festival festival,
			@RequestParam("file") MultipartFile file) throws Exception {

		System.out.println("/write");

		String areaCode = festival.getAddr();

		String a[] = areaCode.split(" ");

		switch (a[0]) {

		case "서울":
			areaCode = "1";
			break;

		case "인천":
			areaCode = "2";
			break;

		case "대전":
			areaCode = "3";
			break;

		case "대구":
			areaCode = "4";
			break;

		case "광주":
			areaCode = "5";
			break;

		case "부산":
			areaCode = "6";
			break;

		case "울산":
			areaCode = "7";
			break;

		case "세종":
			areaCode = "8";
			break;

		case "경기":
			areaCode = "31";
			break;

		case "강원":
			areaCode = "32";
			break;

		case "충북":
			areaCode = "33";
			break;

		case "충남":
			areaCode = "34";
			break;

		case "경북":
			areaCode = "35";
			break;

		case "경남":
			areaCode = "36";
			break;

		case "전북":
			areaCode = "37";
			break;

		case "전남":
			areaCode = "38";
			break;

		case "제주":
			areaCode = "39";
			break;

		}

		festival.setAreaCode(areaCode);

		ModelAndView modelAndView = new ModelAndView();

		System.out.println(1);

		if (file.getSize() > 0) {

			System.out.println("size=0 으로 들어옴!! ");

			File UploadedFile = new File(fileRoot, file.getOriginalFilename());

			festival.setFestivalImage(file.getOriginalFilename());

			file.transferTo(UploadedFile);

			festivalService.writeFestival(festival);

			System.out.println("writeFestival: " + festival);

			modelAndView.setViewName("forward:/view/festival/addFestival.jsp");
			modelAndView.addObject(festival);

		} else {

			System.out.println("else로 들어옴!! ");

			festival.setFestivalImage("no.png");
			festivalService.writeFestival(festival);
			System.out.println("writeFestival: " + festival);

			modelAndView.setViewName("forward:/view/festival/addFestival.jsp");
			modelAndView.addObject(festival);

		}

		Ticket ticket = new Ticket();
		ticket.setFestival(festival);
		ticket.setTicketPrice(festival.getTicketPrice());
		ticket.setTicketCount(festival.getTicketCount());

		ticketService.addTicket(ticket);

		System.out.println("최festival.......: " + festival);

		return modelAndView;
	}

	@RequestMapping(value = "deleteFestival")
	public ModelAndView deleteFestival(@ModelAttribute("page") Page page, @ModelAttribute("search") Search search,
			@RequestParam("festivalNo") int festivalNo, @RequestParam("deleteFlag") String deleteFlag)
			throws Exception {

		System.out.println("deleteFlag들어옴...");

		Festival festival = new Festival();

		festival.setFestivalNo(festivalNo);

		festival = festivalService.getFestivalDB(festivalNo);

		festival.setDeleteFlag("1");

		festivalService.deleteFestival(festival);

		ModelAndView modelAndView = new ModelAndView();

		modelAndView.setViewName("forward:/festival/getFestivalListDB?menu=db");

		return modelAndView;
	}

	@RequestMapping(value = "addFestivalView", method = RequestMethod.GET)
	public ModelAndView addFestivalView(@RequestParam("festivalNo") int festivalNo) throws Exception {

		System.out.println("/addView");

		Festival festival = new Festival();

		festival.setFestivalNo(festivalNo);

		festival = festivalService.getFestival(festivalNo);

		ModelAndView modelAndView = new ModelAndView();

		modelAndView.addObject(festival);

		modelAndView.setViewName("forward:/view/festival/addFestivalView.jsp");

		return modelAndView;

	}

	@RequestMapping(value = "addFestival", method = RequestMethod.POST)
	public ModelAndView addFestival(@ModelAttribute("festival") Festival festival,
			@RequestParam("file") MultipartFile file) throws Exception {

		System.out.println("/add");

		ModelAndView modelAndView = new ModelAndView();

		if (file.getSize() > 0) {

			System.out.println("size=0 으로 들어옴!! " + festival.getFestivalNo());

			File UploadedFile = new File(fileRoot, file.getOriginalFilename());

			festival.setFestivalImage(file.getOriginalFilename());

			file.transferTo(UploadedFile);

			festivalService.addFestival(festival);

			modelAndView.setViewName("forward:/view/festival/addFestival.jsp");
			modelAndView.addObject(festival);

		} else {

			System.out.println("else로 들어옴!! " + festival.getFestivalNo());

			festivalService.addFestival(festival);

			modelAndView.setViewName("forward:/view/festival/addFestival.jsp");
			modelAndView.addObject(festival);

		}

		Ticket ticket = new Ticket();
		ticket.setFestival(festival);
		ticket.setTicketPrice(festival.getTicketPrice());
		ticket.setTicketCount(festival.getTicketCount());

		ticketService.addTicket(ticket);

		return modelAndView;
	}

	@RequestMapping(value = "searchKeywordList", method = RequestMethod.GET)
	public ModelAndView searchKeywordList(@ModelAttribute("search") Search search, @ModelAttribute("page") Page page)
			throws Exception {

		System.out.println("컨트롤러 들어옴");

		if (search.getArrange() == null) {
			search.setArrange("");
		}

		Date dt = new Date();

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy");

		String currentDate = sdf.format(dt).toString();

		if (search.getSearchKeyword() == null || search.getSearchKeyword() == "") {
			search.setSearchKeyword(currentDate);
		}

		Map<String, Object> map = festivalService.searchKeywordList(search);

		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit,
				pageSize);

		ModelAndView modelAndView = new ModelAndView();

		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);

		modelAndView.setViewName("forward:/view/festival/searchKeywordList.jsp");

		return modelAndView;

	}

	@RequestMapping(value = "getFestivalList", method = RequestMethod.GET)

	public ModelAndView getFestivalList(@ModelAttribute("search") Search search, @ModelAttribute("page") Page page)
			throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();

		
		try{
			
		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}

		if (search.getSearchCondition() == null || search.getSearchCondition() == "") {
			search.setSearchCondition("");
		}

		search.setPageSize(pageSize);

		Map<String, Object> map = festivalService.getFestivalList(search);

		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit,
				pageSize);

		

		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);

		modelAndView.setViewName("forward:/view/festival/getFestivalList.jsp");

		return modelAndView;
		}catch(Exception e){
			
			modelAndView.setViewName("forward:/view/festival/nullFestival.jsp");
			
			return modelAndView;
		}

	}

	@RequestMapping(value = "getFestival", method = RequestMethod.GET)
	public ModelAndView getFestival(@RequestParam("festivalNo") int festivalNo) throws Exception {

		System.out.println("/get");

		ModelAndView modelAndView = new ModelAndView();

		Festival festival = new Festival();

		boolean duplication = festivalService.duplication(festivalNo);

		try {

			if (duplication == true) {

				festival.setFestivalNo(festivalNo);

				festival = festivalService.getFestival(festivalNo);

				modelAndView.addObject(festival);
				modelAndView.setViewName("forward:/view/festival/getFestival.jsp");

				return modelAndView;

			}

			festival = festivalService.getFestivalDB(festivalNo);

			if (festival.getDeleteFlag().equals("1")) {

				festival.setFestivalNo(festivalNo);
				festival.setDeleteFlag(null);

				festival = festivalService.getFestivalDB(festivalNo);

				festival.setIsNull(true);

				modelAndView.addObject(festival);
				modelAndView.setViewName("forward:/view/festival/getFestival.jsp");
				return modelAndView;

			}

		} catch (NullPointerException e) {
			modelAndView.setViewName("forward:/view/festival/duplication.jsp");
			return modelAndView;
		}

		return modelAndView;

	}

	@RequestMapping(value = "getFestivalDB")
	public ModelAndView getFestivalDB(@RequestParam("festivalNo") int festivalNo, HttpServletRequest request)
			throws Exception {

		System.out.println("getFestivalDB..............");

		try {

			HttpSession session = request.getSession();
			User user = (User) session.getAttribute("user");

			Festival festival = festivalService.getFestivalDB(festivalNo);

			System.out.println("lat" + festival.getFestivalLatitude() + "\n" + "lon" + festival.getFestivalLongitude());

			Weather weather = festivalService.weather(festival.getFestivalLatitude(), festival.getFestivalLongitude());

			festival.setReadCount(festival.getReadCount() + 1);

			festivalService.appendReadCount(festival);

			Zzim zzim = new Zzim();

			zzim.setFestivalNo(festivalNo);
			zzim.setUserId(user.getUserId());

			Zzim returnZzim = festivalService.getZzim(zzim);

			Ticket ticket = ticketService.getTicket(festivalNo, "1");

			festival.setTicketCount(ticket.getTicketCount());
			festival.setTicketPrice(ticket.getTicketPrice());

			ModelAndView modelAndView = new ModelAndView();

			modelAndView.addObject("festival", festival);
			modelAndView.addObject("returnZzim", returnZzim);
			modelAndView.addObject("ticket", ticket);
			modelAndView.addObject("weather", weather);

			modelAndView.setViewName("forward:/view/festival/getFestival.jsp");

			return modelAndView;

		} catch (Exception e) {

			Festival festival = festivalService.getFestival(festivalNo);
			ModelAndView modelAndView = new ModelAndView();
			modelAndView.addObject("festival", festival);
			modelAndView.setViewName("forward:/view/festival/getFestival.jsp");

			return modelAndView;

		}

	}

	@RequestMapping(value = "updateFestivalView", method = RequestMethod.GET)
	public ModelAndView updateFestivalView(@RequestParam("festivalNo") int festivalNo,
			@RequestParam("isNull") boolean isNull) throws Exception {

		System.out.println("/updateView");

		Festival festival = new Festival();

		festival.setFestivalNo(festivalNo);

		festival = festivalService.getFestivalDB(festivalNo);
		festival.setIsNull(isNull);

		Ticket ticket = ticketService.getTicket(festivalNo, "1");
		festival.setTicketCount(ticket.getTicketCount());
		festival.setTicketPrice(ticket.getTicketPrice());

		ModelAndView modelAndView = new ModelAndView();

		modelAndView.addObject(festival);

		modelAndView.setViewName("forward:/view/festival/updateFestivalView.jsp");

		return modelAndView;

	}

	@RequestMapping(value = "updateFestival", method = RequestMethod.POST)
	public ModelAndView updateFestival(@ModelAttribute("festival") Festival festival,
			@RequestParam("file") MultipartFile file) throws Exception {

		System.out.println("/update");

		ModelAndView modelAndView = new ModelAndView();

		try {

			if (file.getSize() > 0) {

				System.out.println("size=0 으로 들어옴!! " + festival.getFestivalNo());

				File UploadedFile = new File(fileRoot, file.getOriginalFilename());

				festival.setFestivalImage(file.getOriginalFilename());

				file.transferTo(UploadedFile);

				festivalService.updateFestival(festival);

				System.out.println("festivalCh..........." + festival);

				modelAndView.setViewName("forward:/view/festival/updateFestival.jsp");
				modelAndView.addObject(festival);

			} else {

				System.out.println("else로 들어옴!! " + festival.getFestivalNo());

				festivalService.updateFestival(festival);
				System.out.println("festivalCh..........." + festival);
				modelAndView.setViewName("forward:/view/festival/updateFestival.jsp");
				modelAndView.addObject(festival);

			}

			Ticket ticket = new Ticket();
			ticket.setFestival(festival);
			ticket.setTicketPrice(festival.getTicketPrice());
			ticket.setTicketCount(festival.getTicketCount());

			ticketService.updateTicket(ticket);

			return modelAndView;

		} catch (Exception e) {
			e.printStackTrace();

		}

		return modelAndView;

	}

	@RequestMapping(value = "addZzim", method = RequestMethod.GET)
	public ModelAndView addZzim(@RequestParam String userId, @RequestParam int festivalNo) throws Exception {

		System.out.println("addZzim........");

		Zzim zzim = new Zzim(userId, festivalNo);

		ModelAndView modelAndView = new ModelAndView();

		if (festivalService.getZzim(zzim) == null) {

			festivalService.addZzim(zzim);

			modelAndView.addObject("zzim", zzim);
			modelAndView.setViewName("forward:/view/festival/getFestival.jsp");

			return modelAndView;

		} else {
			festivalService.deleteZzim(zzim);
			modelAndView.setViewName("forward:/view/festival/getFestival.jsp");
			return modelAndView;

		}

	}

	@RequestMapping(value = "getZzim", method = RequestMethod.GET)
	public ModelAndView getZzim(@ModelAttribute("user") User user, @RequestParam int festivalNo) throws Exception {

		System.out.println("getZzim........");

		Zzim zzim = new Zzim();

		zzim.setFestivalNo(festivalNo);
		zzim.setUserId(user.getUserId());

		festivalService.getZzim(zzim);

		ModelAndView modelAndView = new ModelAndView();

		modelAndView.setViewName("forward:/view/festival/getFestival.jsp");
		modelAndView.addObject("zzim", zzim);

		return modelAndView;

	}

}
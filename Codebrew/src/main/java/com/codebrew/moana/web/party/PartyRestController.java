package com.codebrew.moana.web.party;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.apache.commons.fileupload.DiskFileUpload;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUpload;
import org.apache.commons.fileupload.FileUploadException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.codebrew.moana.common.Page;
import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Party;
import com.codebrew.moana.service.domain.User;
import com.codebrew.moana.service.party.PartyService;


@RestController
@RequestMapping("/partyRest/*")
public class PartyRestController {

	///Field///
	@Autowired
	@Qualifier("partyServiceImpl")
	private PartyService partyService;
	
	
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	
	///Constructor///
	public PartyRestController() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass()+"Default Constructor Call");
	}
	

	///Method///
	@RequestMapping( value="json/getGenderRatio/{partyNo}", method=RequestMethod.GET)
	public Party getGenderRatio(@PathVariable String partyNo) throws Exception {
		
		System.out.println("\n>>> /partyRest/json/getGenderRatio :: GET start <<<");

		//partyNo 파라미터 출력
		System.out.println(">>> /partyRest/json/getGenderRatio partyNo 파라미터 \n"+partyNo);
		
		
		//Business Logic
		int dbPartyNo = Integer.parseInt(partyNo);
		
		Party party = partyService.getGenderRatio(dbPartyNo);
		//party 도메인 출력
		System.out.println("\n<<< /partyRest/json/getGenderRatio party 도메인  \n"+party);
		
		
		return party;
	}
	
	
	
	/*@RequestMapping( value="json/getPartyMemberList", method=RequestMethod.POST)
	public Map<String, Object> getPartyMemberList(@PathVariable String partyNo, @ModelAttribute("search") Search search) throws Exception {
		
		System.out.println("\n>>> /party/json/getPartyMemberList :: POST start <<<");

		//partyNo 파라미터 출력
		System.out.println(">>> /party/json/getPartyMemberList :: POST :: partyNo 파라미터 \n"+partyNo);
		//search 파라미터 도메인 출력
		//System.out.println(">>> /party/json/getPartyMemberList :: POST :: search 도메인 파라미터 \n"+search);
		
		
		if(search.getCurrentPage() == 0){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		System.out.println("\n<<< /party/json/getPartyList :: POST :: search 도메인\n"+search);
		
		
		//Business Logic
		int dbPartyNo = Integer.parseInt(partyNo);
		Map<String, Object> map = partyService.getPartyMemberList(dbPartyNo, search);
		
		Page resultPage = new Page(search.getCurrentPage(),((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		
		//Model(data) & View(jsp)
		//ModelAndView modelAndView = new ModelAndView();
		//modelAndView.addObject("list", map.get("list"));
		//modelAndView.addObject("resultPage", resultPage);
		//modelAndView.addObject("search", search);
		
				
		return map;
	}*/
	
	@RequestMapping( value="json/getPartyMemberList/{partyNo}", method=RequestMethod.GET)
	public Map<String, Object> getPartyMemberList(@PathVariable String partyNo) throws Exception {
		
		System.out.println("\n>>> /party/json/getPartyMemberList :: GET start <<<");

		//partyNo 파라미터 출력
		System.out.println(">>> /party/json/getPartyMemberList :: GET :: partyNo 파라미터 \n"+partyNo);
		//search 파라미터 도메인 출력
		//System.out.println(">>> /party/json/getPartyMemberList :: GET :: search 도메인 파라미터 \n"+search);
		
		
		Search search = new Search();
		
		//Business Logic
		int dbPartyNo = Integer.parseInt(partyNo);
		Map<String, Object> map = partyService.getPartyMemberList(dbPartyNo, search);
		
		//Page resultPage = new Page(search.getCurrentPage(),((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		
		//Model(data) & View(jsp)
		//ModelAndView modelAndView = new ModelAndView();
		//modelAndView.addObject("list", map.get("list"));
		//modelAndView.addObject("resultPage", resultPage);
		//modelAndView.addObject("search", search);
		
				
		return map;
	}
	
	
	/*@RequestMapping( value="json/cancelParty/{partyNo}", method=RequestMethod.GET )
	public Party cancelParty(@PathVariable String partyNo, HttpSession session) throws Exception {
		
		System.out.println("\n>>> /partyRest/json/cancelParty :: GET start <<<");
		//partyNo 파라미터 출력
		System.out.println(">>> /partyRest/json/cancelParty :: GET :: partyNo 파라미터 \n"+partyNo);
		
		
		//Business Logic
		int dbPartyNo = Integer.parseInt(partyNo);
		User user = (User)session.getAttribute("user");
		String userId = user.getUserId();
		
		Party party = partyService.cancelParty(dbPartyNo, userId);
		//party 도메인 출력
		System.out.println("\n<<< /partyRest/json/cancelParty :: GET :: party 도메인  \n"+party);

		//Model(data) & View(jsp)
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/view/party/getParty.jsp");
		
		return party;
	}*/
}


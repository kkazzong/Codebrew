package com.codebrew.moana.web.festival;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Contents;
import com.codebrew.moana.service.domain.Festival;
import com.codebrew.moana.service.domain.Zzim;
import com.codebrew.moana.service.festival.FestivalService;
import com.codebrew.moana.service.ticket.TicketService;

@RestController
@RequestMapping("/festivalRest/*")
public class FestivalRestController {

	@Autowired
	@Qualifier("festivalServiceImpl")
	private FestivalService festivalService;

	@Autowired
	@Qualifier("ticketServiceImpl")
	private TicketService ticketService;

	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	@Value("#{commonProperties['pageSize']}")
	int pageSize;

	@Value("#{imageRepositoryProperties['fileRoot']}")
	String fileRoot;
	
	public FestivalRestController() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass());
	}
	
	@RequestMapping(value = "/json/getSigunguCode/{areaCode}")
	public Map<String, Object> getSigunguCode (@PathVariable ("areaCode") String areaCode) throws Exception {

		System.out.println("json/getSigunguCode........ : " + areaCode);
		
		Map<String,Object> map = new HashMap<String,Object>();
		
			map = festivalService.getSigunguCode(areaCode);
			
			System.out.println("레스트에서 시군구map....." + map);
			
			return map;

		}
	
	@RequestMapping(value = "/json/getAreaCode")
	public Map<String, Object> getAreaCode () throws Exception {

		System.out.println("json/getAreaCode........");
		
		Map<String,Object> map = new HashMap<String,Object>();
		
			map = festivalService.getAreaCode();
			
			return map;

		}


	
	@RequestMapping(value = "json/kakaoWeb", method=RequestMethod.GET)
	public Contents kakaoWeb(@RequestParam("festivalName0") String festivalName0,
										@RequestParam("festivalName1") String festivalName1,
											@RequestParam("festivalName2") String festivalName2) throws Exception {
		
		System.out.println("레스트 컨트롤러............." + festivalName0 + "," + festivalName1 + "," +festivalName2);
		
		
		Contents contents = festivalService.kakaoWeb(festivalName0,festivalName1,festivalName2);
		
		if(contents.getUrl0()!=null){
		String url0 = contents.getUrl0();
		int eqIndex0 = url0.indexOf("=");
		String youtubeEmbed0 = url0.substring(eqIndex0+1);
		contents.setUrl0(youtubeEmbed0);
		return contents;
		}
		
		if(contents.getUrl1()!=null){
		String url1 = contents.getUrl1();
		int eqIndex1 = url1.indexOf("=");
		String youtubeEmbed1 = url1.substring(eqIndex1+1);
		contents.setUrl1(youtubeEmbed1);
		return contents;
		}
		
		if(contents.getUrl2()!=null){
		String url2 = contents.getUrl2();
		int eqIndex2 = url2.indexOf("=");
		String youtubeEmbed2 = url2.substring(eqIndex2+1);
		contents.setUrl(youtubeEmbed2);
		return contents;
		}
		
		System.out.println("다없으면 기본값..............." );
		
//	festivalName3 만들어서 '지역축제홍보영상' 검색한 값 가져와서 변수로 선언.. 아니면 우리 디폴트 동영상..
		contents.setUrl("ILg6DsEso94");
		return contents;


	}
	
	@RequestMapping(value = "json/getKeyword", method=RequestMethod.POST)
	public List<Festival> getKeyword(@RequestBody Search search) throws Exception {
		
		
		System.out.println("getKeyword에서 search" + search);
		
		if(search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);

		Map<String,Object> map = festivalService.getFestivalListDB(search);

		return (List<Festival>) map.get("list");

	}
	
	@RequestMapping(value = "/json/getInitListDB")
	public Map<String,Object> getInitListDB() throws Exception {
		
		Map<String, Object> map = festivalService.getInitListDB();
		
		System.out.println(map);

		return map;

	}

	@RequestMapping(value = "/json/addZzim/{userId}/{festivalNo}")
	public Zzim addZzim(@PathVariable("userId") String userId, @PathVariable("festivalNo") int festivalNo)
			throws Exception {

		System.out.println("json/addZzim........");
		System.out.println("festivalNo : " + festivalNo);
		System.out.println("userId : " + userId);

		Zzim returnZzim = new Zzim(userId, festivalNo);

		if (festivalService.getZzim(returnZzim) == null) {

			System.out.println("addZzim 댐");

			festivalService.addZzim(returnZzim);

			return returnZzim;

		} else {

			System.out.println("deleteZzim~~~~~~~~~~~");

			festivalService.deleteZzim(returnZzim);

			returnZzim = null;

			return returnZzim;

		}

	}

	@RequestMapping(value = "/json/deleteZzim/{userId}"+"/{festivalNo}")
	public Zzim deleteZzim(@PathVariable("userId") String userId, @PathVariable("festivalNo") int festivalNo)
			throws Exception {

		System.out.println("json/deleteZzim........");

		System.out.println("deleteZzim userId........." + userId + "," + festivalNo);

		Zzim returnZzim = new Zzim(userId, festivalNo);

		festivalService.deleteZzim(returnZzim);

		// returnZzim=null;

		System.out.println("returnZzim 확인 : " + returnZzim);

		return returnZzim;

	}

	@RequestMapping(value = "json/getZzim", method = RequestMethod.GET)
	public Zzim getZzim(@RequestParam String userId, @RequestParam int festivalNo) throws Exception {

		System.out.println("getZzim........");

		Zzim zzim = new Zzim();

		zzim.setUserId(userId);
		zzim.setFestivalNo(festivalNo);

		Zzim returnZzim = festivalService.getZzim(zzim);

		return returnZzim;

	}

	@RequestMapping(value = "json/getFestivalDB/{festivalNo}")
	public Festival getFestivalDB(@PathVariable ("festivalNo") int festivalNo) throws Exception {
		
		System.out.println("rest getFDB............." + festivalNo);

		Festival festival = festivalService.getFestivalDB(festivalNo);
		
		System.out.println("restful getFestivalDB Check..." + festival);

		return festival;

	}


}

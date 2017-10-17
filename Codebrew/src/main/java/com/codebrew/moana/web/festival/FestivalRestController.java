package com.codebrew.moana.web.festival;

import java.io.File;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.codebrew.moana.service.domain.Zzim;
import com.codebrew.moana.service.festival.FestivalService;

@RestController
@RequestMapping("/festivalRest/*")
public class FestivalRestController {
	
	@Autowired
	@Qualifier("festivalServiceImpl")
	private FestivalService festivalService;

	public FestivalRestController() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	@Value("#{commonProperties['pageSize']}")
	int pageSize;

	@Value("#{imageRepositoryProperties['fileRoot']}")
	String fileRoot;
	
	@RequestMapping(value = "/json/addZzim/{userId}/{festivalNo}")
	public Zzim addZzim(@PathVariable("userId") String userId, @PathVariable("festivalNo") int festivalNo) throws Exception{
		
		System.out.println("json/addZzim........");
		System.out.println("festivalNo : "+festivalNo);
		System.out.println("userId : "+userId);
		
		Zzim returnZzim = new Zzim();
		
		returnZzim.setUserId(userId);
		returnZzim.setFestivalNo(festivalNo);
		
		festivalService.addZzim(returnZzim); 
				
		return returnZzim;
		
		}
	
	@RequestMapping(value = "/json/deleteZzim/{userId}/{festivalNo}")
	public Zzim deleteZzim(@PathVariable("userId") String userId, @PathVariable("festivalNo") int festivalNo ) throws Exception{
		
		System.out.println("json/deleteZzim........");
		
		System.out.println("deleteZzim userId........." + userId + "," + festivalNo);
		
		
		Zzim returnZzim = new Zzim();
		
		returnZzim.setUserId(userId);
		returnZzim.setFestivalNo(festivalNo);
		
		festivalService.deleteZzim(returnZzim); 
				
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

}

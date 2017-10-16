package com.codebrew.moana.web.festival;


import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

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
import com.codebrew.moana.service.festival.FestivalService;

@Controller
@RequestMapping("/festival/*")
public class FestivalController {

	@Autowired
	@Qualifier("festivalServiceImpl")
	private FestivalService festivalService;

	public FestivalController() {
		System.out.println(this.getClass());
	}

	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	@Value("#{commonProperties['pageSize']}")
	int pageSize;

	@Value("#{imageRepositoryProperties['fileRoot']}")
	String fileRoot;

	@RequestMapping(value = "addFestivalView", method = RequestMethod.GET)
	public ModelAndView addFestivalView(@RequestParam("festivalNo") int festivalNo) throws Exception {

		System.out.println("/addView");

		Festival festival = new Festival();

		festival.setFestivalNo(festivalNo);

		festival = festivalService.getFestival(festivalNo);

		ModelAndView modelAndView = new ModelAndView();

		modelAndView.addObject(festival);

		modelAndView.setViewName("forward:/festival/addFestivalView.jsp");

		return modelAndView;

	}

	@RequestMapping(value = "addFestival", method = RequestMethod.POST)
	public ModelAndView addFestival(@ModelAttribute("festival") Festival festival,
			@RequestParam("file") MultipartFile file) throws Exception {

		System.out.println("/add");
		
		ModelAndView modelAndView = new ModelAndView();

		boolean duplication = festivalService.duplication(festival.getFestivalNo());
		
		System.out.println("add에서 축제등록 중복체ㅡ................." + duplication);

		if (duplication==true) {

			if (file.getSize() > 0) {

				System.out.println("size=0 으로 들어옴!! " + festival.getFestivalNo());

				File UploadedFile = new File(fileRoot, file.getOriginalFilename());

				festival.setFestivalImage(file.getOriginalFilename());

				file.transferTo(UploadedFile);

				festivalService.addFestival(festival);

				modelAndView.setViewName("forward:/festival/addFestival.jsp");
				modelAndView.addObject(festival);

			} else {

				System.out.println("else로 들어옴!! " + festival.getFestivalNo());

				festivalService.addFestival(festival);

				modelAndView.setViewName("forward:/festival/addFestival.jsp");
				modelAndView.addObject(festival);

			}
		}else{
			
			modelAndView.setViewName("forward:/festival/duplication.jsp");
			
		}
		
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

		modelAndView.setViewName("forward:/festival/searchKeywordList.jsp");

		return modelAndView;

	}

	@RequestMapping(value = "getFestivalList", method = RequestMethod.GET)

	public ModelAndView getFestivalList(@ModelAttribute("search") Search search, @ModelAttribute("page") Page page)
			throws Exception {

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

		ModelAndView modelAndView = new ModelAndView();

		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);

		modelAndView.setViewName("forward:/festival/getFestivalList.jsp");

		return modelAndView;

	}

	@RequestMapping(value = "getFestival", method = RequestMethod.GET)
	public ModelAndView getFestival(@RequestParam("festivalNo") int festivalNo) throws Exception {

		System.out.println("/get");

		System.out.println("festivalNo" + festivalNo);

		Festival festival = new Festival();

		festival.setFestivalNo(festivalNo);

		festival = festivalService.getFestival(festivalNo);

		ModelAndView modelAndView = new ModelAndView();

		modelAndView.addObject(festival);

		modelAndView.setViewName("forward:/festival/getFestival.jsp");

		return modelAndView;

	}
	
	@RequestMapping(value = "getFestivalListDB")

	public ModelAndView getFestivalListDB(@ModelAttribute("search") Search search, @ModelAttribute("page") Page page)
			throws Exception {

		
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

		modelAndView.setViewName("forward:/festival/getFestivalListDB.jsp");

		return modelAndView;

	}
	


}
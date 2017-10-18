package com.codebrew.moana.web.review;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.codebrew.moana.common.Page;
import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Image;
import com.codebrew.moana.service.domain.Review;
import com.codebrew.moana.service.domain.User;
import com.codebrew.moana.service.review.ReviewService;

//==> review controller
@Controller
@RequestMapping("/review/*")
public class ReviewController {
	
	///Field
	@Autowired
	@Qualifier("reviewServiceImpl")
	private ReviewService reviewService;

	public ReviewController() {
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	

	//1. GET 인 경우 : addReview.jsp(review를 등록하는 form)를 불러온다. : ok
	@RequestMapping(value="addReview", method=RequestMethod.GET)
	public ModelAndView addReview() throws Exception {

		System.out.println("/view/review/addReview");
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/view/review/addReview.jsp");
		
		return modelAndView;
	}
	
	//2. POST 인 경우 : addReview.jsp에서 form작성을 완료하여 실제로 등록한 후 getReview.jsp로 넘어간다.
	@RequestMapping(value="addReview", method=RequestMethod.POST)
	public ModelAndView addReview(@ModelAttribute("review") Review review, 
									@RequestParam("reviewImage") MultipartHttpServletRequest reviewImage, 
									@RequestParam("reviewVideo") MultipartHttpServletRequest reviewVideo, 
									Model model) throws Exception{
		
		System.out.println("addReview processing...");
		
		//List<MultipartFile> uploadImage = reviewImage.getFiles("fileName[]");
		List<Image> uploadImageList = new ArrayList();
		
		System.out.println("loadImage : "+uploadImageList);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/view/review/getReview.jsp");
		
		return modelAndView;
	}
	
	
	@RequestMapping(value="getReview", method = RequestMethod.GET)
	public ModelAndView getReview( @RequestParam("reviewNo") int reviewNo) throws Exception {
		
		System.out.println("/review/getReview");
		
		//Business Logic
		Review review = reviewService.getReview(reviewNo);
		// Model 과 View 연결
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("review", review);
		modelAndView.setViewName("/review/getReview.jsp");
		
		return modelAndView;
	}
	
	// update 하는 form 출력
	@RequestMapping(value="updateReview", method = RequestMethod.GET)
	public ModelAndView updateReview( @RequestParam("reviewNo") int reviewNo) throws Exception{

		System.out.println("/review/updateReview");
		//Business Logic
		Review review = reviewService.getReview(reviewNo);
		
		// Model 과 View 연결
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("review", review);
		modelAndView.setViewName("/review/updateReview.jsp");
		
		return modelAndView;
	}
	
	@RequestMapping(value="getReviewList")
	public ModelAndView getReviewList( @ModelAttribute("search") Search search, 
									@ModelAttribute("review") Review review) throws Exception{
		
		/*
		 * 매개변수 Model type : model 삭제함.
		 * 매개변수 HttpServletRequest type : request 삭제함.
		 */
		
		System.out.println("/review/getReviewList");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic 수행
		Map<String, Object> map = reviewService.getReviewList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model 과 View 연결
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);
		
		modelAndView.setViewName("/review/getReviewList.jsp");
		
		return modelAndView;
	}
	
	@RequestMapping(value="getMyReviewList")
	public ModelAndView getMyReviewList( @ModelAttribute("search") Search search,
										@ModelAttribute("review") Review review, 
										HttpSession session) throws Exception{
		
		System.out.println("/review/getMyReviewList");
		
		if(search.getCurrentPage() == 0){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic 수행
		User writer = (User)(session.getAttribute("user"));
		String writerId = writer.getUserId();
		
		Map<String, Object> map = reviewService.getMyReviewList(search, writerId);
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model과 View 연결 : 확인 요망
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);
		modelAndView.addObject("writerId", writerId);
		
		modelAndView.setViewName("/review/getMyReviewList.jsp");
		
		return modelAndView;
	}
	
	@RequestMapping(value="getCheckReviewList")
	public ModelAndView getCheckReviewList( @ModelAttribute("search") Search search,
											@ModelAttribute("review") Review review)
											throws Exception{
		
		/*
		 * 매개변수 HttpSession Type : session 삭제
		 */
		
		System.out.println("/review/getCheckReviewList");
		
		if(search.getCurrentPage() == 0){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic 수행
		ModelAndView modelAndView = new ModelAndView();
		String checkCode = null;
		if(checkCode == "1" || checkCode == "11"){			
			Map<String, Object> map = reviewService.getCheckReviewList(search, checkCode);
			Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
			System.out.println(resultPage);
			// Model과 View 연결 : 확인 요망
			modelAndView.addObject("list", map.get("list"));
			modelAndView.addObject("resultPage", resultPage);
			modelAndView.addObject("search", search);
			
			modelAndView.setViewName("/review/getCheckReviewList.jsp");
			
		}
		return modelAndView;
		
	}

}

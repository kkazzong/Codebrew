package com.codebrew.moana.web.review;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

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
import com.codebrew.moana.service.domain.Hashtag;
import com.codebrew.moana.service.domain.Image;
import com.codebrew.moana.service.domain.Review;
import com.codebrew.moana.service.domain.User;
import com.codebrew.moana.service.domain.Video;
import com.codebrew.moana.service.festival.FestivalService;
import com.codebrew.moana.service.review.ReviewService;
import com.codebrew.moana.service.user.UserService;

//==> review controller
@Controller
@RequestMapping("/review/*")
public class ReviewController {
	
	///Field
	@Autowired
	@Qualifier("reviewServiceImpl")
	private ReviewService reviewService;
	
	@Autowired
	@Qualifier("festivalServiceImpl")
	private FestivalService festivalService;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;

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
	public ModelAndView addReview(HttpSession session,
									@ModelAttribute("review") Review review, 
									@RequestParam("uploadReviewImageList") List<MultipartFile> uploadReviewImage, 
									@RequestParam("uploadReviewVideoList") List<MultipartFile> uploadReviewVideo, 
									@RequestParam("uploadHashtagList") String uploadHashtag) throws Exception{
		
//		@RequestParam("uploadReviewVideo") MultipartHttpServletRequest reviewVideo
		
		System.out.println("addReview processing...");
		
		/*
		 * upload Image List List<multipartFile> 
		 */
		String filePath1 = "C:\\Users\\Admin\\git\\Codebrew\\Codebrew\\WebContent\\resources\\uploadFile\\"; // 실제 directory 경로로 파일을 영구적으로 저장하기 위함이다.
		String filePath2 = session.getServletContext().getRealPath("/")+"\\resources\\uploadFile\\"; //실제 folder가 아닌 tomcat의 임시 서버로서 add후 바로 get을 했을때 이미지를 볼 수 있도록 한다.
		
		System.out.println("\n\n\nfilePath :: \n"+filePath2);
		
		if(uploadReviewImage != null && uploadReviewImage.size() > 0){
			
			List<Image> uploadImageList = new ArrayList<Image>();
			for(MultipartFile multipartFile : uploadReviewImage){
				Image eachImage = new Image();
				String fileName = UUID.randomUUID().toString()+System.currentTimeMillis()+multipartFile.getOriginalFilename().substring(multipartFile.getOriginalFilename().lastIndexOf("."), multipartFile.getOriginalFilename().length());
				eachImage.setReviewImage(fileName); //각각의 이미지 fileName을 setting
				
				uploadImageList.add(eachImage); //생성한 list에 setting이 끝난 각각의 Image 객체를 넣어줌
				File file1 = new File(filePath1+fileName); // 1st Path : 실제 존재하는 uploadFile 경로+fileName
				//File file1 = new File(filePath1, fileName);
				File file2 = new File(filePath2+fileName); // 2nd Path : Tomcat의 temporary folder 경로+fileName
				//File file2 = new File(filePath2, fileName);
				
				System.out.println("\n\n\n\n\nmultipartFile"+multipartFile);
				multipartFile.transferTo(file2);
				
				FileInputStream fis = null;
				FileOutputStream fos = null; 

				try {
					fis = new FileInputStream(file2);	// 원본파일
					fos = new FileOutputStream(file1);	// 복사위치
					   
					byte[] buffer = new byte[1024];
					int readcount = 0;
					  
					while((readcount=fis.read(buffer)) != -1) {
						fos.write(buffer, 0, readcount);				// 파일 복사 
					}
				} catch(Exception e) {
					e.printStackTrace();
				} finally {
					fis.close();
					fos.close();
				}
			}
			review.setReviewImageList(uploadImageList);
		}
		
		/*
		 * upload Video <multipartFile> 
		 */
		if(uploadReviewVideo != null && uploadReviewVideo.size() > 0){
			
			List<Video> uploadVideoList = new ArrayList<Video>();
			for(MultipartFile multipartFile : uploadReviewVideo){
				Video eachVideo = new Video();
				String fileName = UUID.randomUUID().toString()+System.currentTimeMillis()+multipartFile.getOriginalFilename().substring(multipartFile.getOriginalFilename().lastIndexOf("."), multipartFile.getOriginalFilename().length());
				eachVideo.setReviewVideo(fileName); //각각의 이미지 fileName을 setting
				
				uploadVideoList.add(eachVideo); //생성한 list에 setting이 끝난 각각의 video 객체를 넣어줌
				File file1 = new File(filePath1+fileName); // 1st Path : 실제 존재하는 uploadFile 경로+fileName
				//File file1 = new File(filePath1, fileName);
				File file2 = new File(filePath2+fileName); // 2nd Path : Tomcat의 temporary folder 경로+fileName
				//File file2 = new File(filePath2, fileName);
				
				System.out.println("\n\n\n\n\nmultipartFile"+multipartFile);
				multipartFile.transferTo(file2);
				
				FileInputStream fis = null;
				FileOutputStream fos = null; 

				try {
					fis = new FileInputStream(file2);	// 원본파일
					fos = new FileOutputStream(file1);	// 복사위치
					   
					byte[] buffer = new byte[1024];
					int readcount = 0;
					  
					while((readcount=fis.read(buffer)) != -1) {
						fos.write(buffer, 0, readcount);				// 파일 복사 
					}
				} catch(Exception e) {
					e.printStackTrace();
				} finally {
					fis.close();
					fos.close();
				}
			}
			review.setReviewVideoList(uploadVideoList);
		}
		
		/*
		 * upload Hashtag List List<String> 
		 */
		if(uploadHashtag != null){
			
			List<Hashtag> uploadHashtagList = new ArrayList<Hashtag>();
			for(String splitedHashtag : uploadHashtag.split(";")){
				Hashtag eachHashtag = new Hashtag();
				eachHashtag.setHashtagDetail(splitedHashtag.replaceAll("#", ""));
				uploadHashtagList.add(eachHashtag);
			}
			review.setReviewHashtagList(uploadHashtagList);
		}
		
		System.out.println("\n\n\n\n\n=====okokokokok=====\n\n\n\n\n");
		
		review = reviewService.addReview(review);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject(review);
		modelAndView.setViewName("/view/review/getReview.jsp");
		
		return modelAndView;
	}
	
	
	@RequestMapping(value="getReview", method = RequestMethod.GET)
	public ModelAndView getReview( @RequestParam("reviewNo") int reviewNo) throws Exception {
		
		System.out.println("/view/review/getReview");
		
		//Business Logic
		Review review = reviewService.getReview(reviewNo);
		User user = userService.getUser(review.getUserId());
		Festival festival = festivalService.getFestival(review.getFestivalNo());
		
		// Model 과 View 연결
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("user", user);
		modelAndView.addObject("festival", festival);
		modelAndView.addObject("review", review);
		modelAndView.setViewName("/view/review/getReview.jsp");
		
		return modelAndView;
	}
	
	// update 하는 form 출력
	@RequestMapping(value="updateReview", method = RequestMethod.GET)
	public ModelAndView updateReview( @RequestParam("reviewNo") int reviewNo) throws Exception{

		System.out.println("/view/review/updateReview");
		//Business Logic
		Review review = reviewService.getReview(reviewNo);
		
		Festival festival = festivalService.getFestival(review.getFestivalNo());
		
		// Model 과 View 연결
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("review", review);
		modelAndView.addObject("festival", festival);
		modelAndView.setViewName("/view/review/updateReview.jsp");
		
		return modelAndView;
	}
	
	@RequestMapping(value="getReviewList")
	public ModelAndView getReviewList( @ModelAttribute("search") Search search, 
									@ModelAttribute("review") Review review) throws Exception{
		
		/*
		 * 매개변수 Model type : model 삭제함.
		 * 매개변수 HttpServletRequest type : request 삭제함.
		 */
		
		System.out.println("/view/review/getReviewList");
		
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
		
		modelAndView.setViewName("/view/review/getReviewList.jsp");
		
		return modelAndView;
	}
	
	@RequestMapping(value="getMyReviewList")
	public ModelAndView getMyReviewList( @ModelAttribute("search") Search search,
										@ModelAttribute("review") Review review, 
										HttpSession session) throws Exception{
		
		System.out.println("/view/review/getMyReviewList");
		
		if(search.getCurrentPage() == 0){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic 수행
		User user = (User)(session.getAttribute("user"));
		String userId = user.getUserId();
		
		Map<String, Object> map = reviewService.getMyReviewList(search, userId);
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model과 View 연결 : 확인 요망
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);
		modelAndView.addObject("userId", userId);
		
		modelAndView.setViewName("/view/review/getMyReviewList.jsp");
		
		return modelAndView;
	}
	
	@RequestMapping(value="getCheckReviewList")
	public ModelAndView getCheckReviewList( @ModelAttribute("search") Search search,
											@ModelAttribute("review") Review review)
											throws Exception{
		
		/*
		 * 매개변수 HttpSession Type : session 삭제
		 */
		
		System.out.println("/view/review/getCheckReviewList");
		
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
			
			modelAndView.setViewName("/view/review/getCheckReviewList.jsp");
			
		}
		return modelAndView;
		
	}

}

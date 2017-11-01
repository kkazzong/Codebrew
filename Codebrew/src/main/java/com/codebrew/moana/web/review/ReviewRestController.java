package com.codebrew.moana.web.review;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.codebrew.moana.common.Page;
import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Good;
import com.codebrew.moana.service.domain.Image;
import com.codebrew.moana.service.domain.Review;
import com.codebrew.moana.service.review.ReviewService;

//==>후기관리 & 댓글관리 RestController
@RestController
@RequestMapping("/reviewRest/*")
public class ReviewRestController {
	
	///Field
	@Autowired
	@Qualifier("reviewServiceImpl")
	private ReviewService reviewService;
	
	public ReviewRestController() {
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	//아래거 미완 : 미완
	@RequestMapping(value = "/json/addReview/{userId}/{festivalNo}")
	public Review addReview(HttpSession session, 
							@PathVariable("review") Review review, 
							@PathVariable("uploadReviewImageList") List<MultipartFile> uploadReviewImage, 
							@PathVariable("uploadReviewVideoList") List<MultipartFile> uploadReviewVideo)
							throws Exception {
	
		System.out.println("Review RestController :: addReview");
		
		String filePath1 = "C:\\Users\\Admin\\git\\Codebrew\\Codebrew\\WebContent\\resources\\uploadFile\\"; // 실제 directory 경로로 파일을 영구적으로 저장하기 위함이다.
		String filePath2 = session.getServletContext().getRealPath("/")+"\\resources\\uploadFile\\"; //실제 folder가 아닌 tomcat의 임시 서버로서 add후 바로 get을 했을때 이미지를 볼 수 있도록 한다.
		
		if(uploadReviewImage != null && uploadReviewImage.size() > 0){
			
			List<Image> uploadImageList = new ArrayList<Image>();
			for(MultipartFile multipartFile : uploadReviewImage){
				Image eachImage = new Image();
				String fileName = UUID.randomUUID().toString()+System.currentTimeMillis()+multipartFile.getOriginalFilename().substring(multipartFile.getOriginalFilename().lastIndexOf("."), multipartFile.getOriginalFilename().length());
				//여기서부터 수정
			}
		}
		
		return null;
		
	}
	
	//하는중 : 미완
	@RequestMapping(value = "/json/uploadImageList") // 리스트로 이미지 객체들만 보내주면 되는가?
	public List<Image> uploadImageList(HttpSession session, 
										@PathVariable("uploadImageList") List<MultipartFile> uploadImageList) throws Exception {
		
		System.out.println("Review RestContorller :: uploadImageList");
		
		/*
		 * upload Image List List<multipartFile> : view에서 javaScript로 사진을 무조건 1장이상 올리게 했기 때문에 조건절 간단하게 써줌
		 */
		String filePath1 = "C:\\Users\\Admin\\git\\Codebrew\\Codebrew\\WebContent\\resources\\uploadFile\\"; // 실제 directory 경로로 파일을 영구적으로 저장하기 위함이다.
		String filePath2 = session.getServletContext().getRealPath("/")+"\\resources\\uploadFile\\"; //실제 folder가 아닌 tomcat의 임시 서버로서 add후 바로 get을 했을때 이미지를 볼 수 있도록 한다.
		
		return null;
	}
	
	//완
	@RequestMapping(value = "json/getReview/{reviewNo}", method=RequestMethod.GET)
	public Review getReview(@PathVariable int reviewNo) throws Exception {
		
		System.out.println("Review RestController :: getReview");
		
		System.out.println("\n\nreviewNo :: "+reviewNo);
		Review returnReview = reviewService.getReview(reviewNo);
		return returnReview;
	}
	
	//완
	@RequestMapping(value = "json/getReviewList")
	public Map<String, Object> getReviewList(@RequestBody Search search) throws Exception {
		
		System.out.println("Review RestController :: getReviewList");
		
		if(search.getCurrentPage() == 0){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		//Business Logic
		Map<String, Object> map = reviewService.getReviewList(search);
		System.out.println("getReviewList map :: "+map);
		
		//resultpage 를 map에 넣어주면
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		System.out.println("\n\ngetReviewList resultPage :: "+resultPage);
		System.out.println("\n\nreturn map :: "+map.toString());
		
		return map;
		
	}
	
	//완료는 : Good을 리턴하는 것이 아니라 review를 리턴해야...해당 화면에 Review 객체에 대한 정보를 보내줄 수 있다.
	@RequestMapping(value = "/json/addGood/{userId}/{reviewNo}")
	public Review addGood(@PathVariable("userId") String userId, 
						@PathVariable("reviewNo") int reviewNo)
						throws Exception {
		
		System.out.println("Review RestController :: addGood");
		
		System.out.println("\n\nreviewNo :: "+reviewNo+"\n\n");
		System.out.println("\n\nuserId :: "+userId+"\n\n");
		
		Good returnGood = new Good(reviewNo, userId);
		
		if(reviewService.checkGood(returnGood) == null || reviewService.checkGood(returnGood).equals("")){
			System.out.println("좋아요 + 1");
			reviewService.addGood(returnGood);
			return reviewService.getReview(reviewNo);
		}else{
			System.out.println("좋아요 - 1");
			reviewService.deleteGood(returnGood);
			return reviewService.getReview(reviewNo);
		}
	}
		
}

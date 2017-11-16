package com.codebrew.moana.web.review;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
import com.codebrew.moana.service.domain.Good;
import com.codebrew.moana.service.domain.Image;
import com.codebrew.moana.service.domain.Reply;
import com.codebrew.moana.service.domain.Review;
import com.codebrew.moana.service.domain.User;
import com.codebrew.moana.service.domain.Video;
import com.codebrew.moana.service.festival.FestivalService;
import com.codebrew.moana.service.reply.ReplyService;
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
	
	@Autowired
	@Qualifier("replyServiceImpl")
	private ReplyService replyService;

	public ReviewController() {
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	@Value("#{imageRepositoryProperties['reviewUploadFilesDir']}")
	String reviewUploadFilesDir;
	
	public static class TIME_MAXIMUM{
		public static final int SEC = 60;
        public static final int MIN = 60;
        public static final int HOUR = 24;
        public static final int DAY = 30;
        public static final int MONTH = 12;
	}

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
									@RequestParam("uploadReviewVideoList") List<MultipartFile> uploadReviewVideo) throws Exception {
		
//		@RequestParam("uploadReviewVideo") MultipartHttpServletRequest reviewVideo
		
		System.out.println("addReview processing...");
		
		/*
		 * upload Image List List<multipartFile> : view에서 javaScript로 사진을 무조건 1장이상 올리게 했기 때문에 조건절 간단하게 써줌
		 */
		String filePath1 = reviewUploadFilesDir; // 실제 directory 경로로 파일을 영구적으로 저장하기 위함이다. 관리가 되는 폴더(commonProperties로 관리한다)
		String filePath2 = session.getServletContext().getRealPath("/")+"\\resources\\uploadFile\\"; //실제 folder가 아닌 tomcat의 임시 서버로서 add후 바로 get을 했을때 이미지를 볼 수 있도록 한다.
		
		System.out.println("\n\n\nfilePath :: \n"+filePath2);
		
		if(uploadReviewImage != null && uploadReviewImage.size() > 0){
			
			List<Image> uploadImageList = new ArrayList<Image>();
			for(MultipartFile multipartFile : uploadReviewImage){
				Image eachImage = new Image();
				String fileName = "review"+UUID.randomUUID().toString()+System.currentTimeMillis()+multipartFile.getOriginalFilename().substring(multipartFile.getOriginalFilename().lastIndexOf("."), multipartFile.getOriginalFilename().length());
				eachImage.setReviewImage(fileName); //각각의 이미지 fileName을 setting
				
				uploadImageList.add(eachImage); //생성한 list에 setting이 끝난 각각의 Image 객체를 넣어줌
				File file1 = new File(filePath1+fileName); // 1st Path : 실제 존재하는 uploadFile 경로+fileName
				//File file1 = new File(filePath1, fileName);
				File file2 = new File(filePath2+fileName); // 2nd Path : Tomcat의 temporary folder 경로+fileName
				//File file2 = new File(filePath2, fileName);
				
				System.out.println("\n\n\n\n\nmultipartFile :: Image :: "+multipartFile+"\n\n\n\n\n");
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
		 * upload Video <multipartFile> : 동영상은 선택적으로 올릴수 있기 때문에 조건절 복잡 : 나중을 위하여 List로 받음(jsp상 multiple은 아니다)
		 */
		if(uploadReviewVideo.get(0).getOriginalFilename() != "" && uploadReviewVideo != null && uploadReviewVideo.size() > 0){
			
			List<Video> uploadVideoList = new ArrayList<Video>();
			for(MultipartFile multipartFile : uploadReviewVideo){
				Video eachVideo = new Video();
				String fileName = "review"+UUID.randomUUID().toString()+System.currentTimeMillis()+multipartFile.getOriginalFilename().substring(multipartFile.getOriginalFilename().lastIndexOf("."), multipartFile.getOriginalFilename().length());
				eachVideo.setReviewVideo(fileName); //각각의 이미지 fileName을 setting
				
				uploadVideoList.add(eachVideo); //생성한 list에 setting이 끝난 각각의 video 객체를 넣어줌
				File file1 = new File(filePath1+fileName); // 1st Path : 실제 존재하는 uploadFile 경로+fileName
				//File file1 = new File(filePath1, fileName);
				File file2 = new File(filePath2+fileName); // 2nd Path : Tomcat의 temporary folder 경로+fileName
				//File file2 = new File(filePath2, fileName);
				
				System.out.println("\n\n\n\n\nmultipartFile :: Video :: "+multipartFile+"\n\n\n\n\n");
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
		
		/////////// 디비 입출력시 엔터처리 ////////////////
		String reviewDetail = review.getReviewDetail();
		System.out.println("\n\nreviewDetail :: \n"+reviewDetail);
		reviewDetail = reviewDetail.replaceAll("\n", "<br>");
		review.setReviewDetail(reviewDetail);
		/////////// 디비 입출력시 엔터처리 ////////////////
		
		System.out.println("\n\n\n\n\n=====okokokokok=====\n\n\n\n\n");
		
		review = reviewService.addReview(review);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject(review);
		modelAndView.setViewName("/view/review/getReview.jsp");
		
		return modelAndView;
	}
	
	
	@RequestMapping(value="getReview", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView getReview( @RequestParam("reviewNo") int reviewNo, 
									@ModelAttribute("Search") Search search) throws Exception {
		
		//parameter인 @ModelAttribute("search") Search search 는 Reply paging 처리때문에 받음.
		
		System.out.println("/view/review/getReview");		
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		//Business Logic
		Review review = reviewService.getReview(reviewNo);
		
		//아래 test
		//List<Reply> replyList = (List<Reply>) replyService.getReplyList(search, reviewNo).get("replyList");
		
		Map<String, Object> map = replyService.getReplyList(search, reviewNo);
		
		@SuppressWarnings("unchecked")
		List<Reply> replyList = (List<Reply>)map.get("replyList");
		
		long presentTime = System.currentTimeMillis();
		
		String replyUserId;
		User replyUser;
		String eachUserNickname;
		
		//id가 아닌 nickname 노출, 정확한 날짜가 아닌 대략적인 날짜 노출
		for(int i = 0; i < replyList.size(); i++){
			
			replyUserId = replyList.get(i).getUserId();
			replyUser = userService.getUser(replyUserId);
			eachUserNickname = replyUser.getNickname();
			replyList.get(i).setUserId(eachUserNickname);
			
			System.out.println("\nreplyList.get(i).getReplyRegDate() :: \n"+replyList.get(i).getReplyRegDate());
			Date eachReplyRegDateTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S").parse(replyList.get(i).getReplyRegDate());
			long diffTime = (presentTime - eachReplyRegDateTime.getTime())/1000;
			
			if(diffTime < TIME_MAXIMUM.SEC) {
				replyList.get(i).setReplyRegDate("바로 전");
			}else if((diffTime /= TIME_MAXIMUM.SEC) < TIME_MAXIMUM.MIN) {
				replyList.get(i).setReplyRegDate(diffTime+"분 전");
			}else if((diffTime /= TIME_MAXIMUM.MIN) < TIME_MAXIMUM.HOUR) {
				replyList.get(i).setReplyRegDate(diffTime+"시간 전");
			}else if((diffTime /= TIME_MAXIMUM.HOUR) < TIME_MAXIMUM.DAY) {
				replyList.get(i).setReplyRegDate(diffTime+"일 전");
			}else if((diffTime /= TIME_MAXIMUM.DAY) < TIME_MAXIMUM.MONTH) {
				replyList.get(i).setReplyRegDate(diffTime+"달 전");
			}else{
				replyList.get(i).setReplyRegDate(diffTime+"년 전");
			}
		}
		
		
		System.out.println("\n\n test :: replyList.toString() :: "+replyList.toString());
		
		//Page처리
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		review.setReplyList(replyList);
		
		// Model 과 View 연결
		ModelAndView modelAndView = new ModelAndView();
		
		//modelAndView.addObject("festival", festival);
		modelAndView.addObject("review", review);
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.setViewName("/view/review/getReview.jsp");
		
		return modelAndView;
	}
	
	// update 하는 form 출력
	@RequestMapping(value="updateReview", method = RequestMethod.GET)
	public ModelAndView updateReview( @RequestParam("reviewNo") int reviewNo) throws Exception{

		System.out.println("/view/review/updateReview");
		//Business Logic
		Review review = reviewService.getReview(reviewNo);
		
		/////////// 디비 입출력시 엔터처리 ////////////////
		String reviewDetail = review.getReviewDetail();
		reviewDetail = reviewDetail.replaceAll("<br>", "\n");
		review.setReviewDetail(reviewDetail);
		/////////// 디비 입출력시 엔터처리 ////////////////
		
		Festival festival = festivalService.getFestivalDB(review.getFestivalNo());
		
		// Model 과 View 연결
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("review", review);
		modelAndView.addObject("festival", festival);
		modelAndView.setViewName("/view/review/updateReview.jsp");
		
		return modelAndView;
	}
	
	// 실제 update 하여 getReview로 넘어감
	@RequestMapping(value="updateReview", method=RequestMethod.POST)
	public ModelAndView updateReview(HttpSession session, 
									@ModelAttribute("review") Review review, 
									@RequestParam(value = "uploadReviewImageList", required = false) List<MultipartFile> uploadReviewImage, 
									@RequestParam(value = "uploadReviewVideoList", required = false) List<MultipartFile> uploadReviewVideo) throws Exception{
		
		int reviewNo = review.getReviewNo();
		//test
		System.out.println("\n\n\ntest Controller updateReview review :: \n"+review);
		System.out.println("\n\n\ntest Controller updateReview review.getCheckCode() :: \n"+review.getCheckCode());
		
		System.out.println("\n\nreviewNo :: "+reviewNo);
		System.out.println("updateReview processing...");
		
		String filePath1 = reviewUploadFilesDir; // 실제 directory 경로로 파일을 영구적으로 저장하기 위함이다.
		String filePath2 = session.getServletContext().getRealPath("/")+"\\resources\\uploadFile\\"; //실제 folder가 아닌 tomcat의 임시 서버로서 add후 바로 get을 했을때 이미지를 볼 수 있도록 한다.
		
		System.out.println("\n\n\nfilePath :: \n"+filePath2);
		
		//새롭게 업로드할 이미지가 있는 경우
		if(uploadReviewImage != null && uploadReviewImage.size() > 0){
			
			List<Image> uploadImageList = new ArrayList<Image>();
			
			for(MultipartFile multipartFile : uploadReviewImage){
				
				if(!multipartFile.getOriginalFilename().isEmpty()) {
					
					reviewService.deleteReviewImage(reviewNo);
					
					System.out.println("멀티파트파일이잇군요");
					System.out.println(" 파일네임 -> "+multipartFile.getOriginalFilename());
					
					Image eachImage = new Image();
					
					String fileName = "review"+UUID.randomUUID().toString()+System.currentTimeMillis()+multipartFile.getOriginalFilename().substring(multipartFile.getOriginalFilename().lastIndexOf("."), multipartFile.getOriginalFilename().length());
					eachImage.setReviewImage(fileName); //각각의 이미지 fileName을 setting
					
					uploadImageList.add(eachImage); //생성한 list에 setting이 끝난 각각의 Image 객체를 넣어줌
					File file1 = new File(filePath1+fileName); // 1st Path : 실제 존재하는 uploadFile 경로+fileName
					//File file1 = new File(filePath1, fileName);
					File file2 = new File(filePath2+fileName); // 2nd Path : Tomcat의 temporary folder 경로+fileName
					//File file2 = new File(filePath2, fileName);
					
					System.out.println("\n\n\nmultipartFile :: Image :: \n"+multipartFile+"\n\n\n\n\n");
					multipartFile.transferTo(file2);
					
					FileInputStream fis = null;
					FileOutputStream fos = null; 
	
					try {
						fis = new FileInputStream(file2); // 원본파일
						fos = new FileOutputStream(file1); // 복사위치
						   
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
				}
				review.setReviewImageList(uploadImageList);
			} //이름이 엠티가 아님
		}
		
		/*
		 * upload Video <multipartFile> : 동영상은 선택적으로 올릴수 있기 때문에 조건절 복잡 : 나중을 위하여 List로 받음(jsp상 multiple은 아니다)
		 */
		if(uploadReviewVideo.get(0).getOriginalFilename() != "" && uploadReviewVideo != null && uploadReviewVideo.size() > 0){
			
			List<Video> uploadVideoList = new ArrayList<Video>();
			for(MultipartFile multipartFile : uploadReviewVideo){
				
				if(!multipartFile.getOriginalFilename().isEmpty()) {
					
					reviewService.deleteReviewVideo(reviewNo);
				
					Video eachVideo = new Video();
					String fileName = "review"+UUID.randomUUID().toString()+System.currentTimeMillis()+multipartFile.getOriginalFilename().substring(multipartFile.getOriginalFilename().lastIndexOf("."), multipartFile.getOriginalFilename().length());
					eachVideo.setReviewVideo(fileName); //각각의 이미지 fileName을 setting
					
					uploadVideoList.add(eachVideo); //생성한 list에 setting이 끝난 각각의 video 객체를 넣어줌
					File file1 = new File(filePath1+fileName); // 1st Path : 실제 존재하는 uploadFile 경로+fileName
					//File file1 = new File(filePath1, fileName);
					File file2 = new File(filePath2+fileName); // 2nd Path : Tomcat의 temporary folder 경로+fileName
					//File file2 = new File(filePath2, fileName);
					
					System.out.println("\n\n\n\n\nmultipartFile :: Video :: "+multipartFile+"\n\n\n\n\n");
					multipartFile.transferTo(file2);
					
					FileInputStream fis = null;
					FileOutputStream fos = null; 
	
					try {
						fis = new FileInputStream(file2); // 원본파일
						fos = new FileOutputStream(file1); // 복사위치
						   
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
				}
				review.setReviewVideoList(uploadVideoList);
			}
		}
		
		
		/////////// 디비 입출력시 엔터처리 ////////////////
		String reviewDetail = review.getReviewDetail();
		System.out.println("\n\nreviewDetail :: \n"+reviewDetail);
		reviewDetail = reviewDetail.replaceAll("\n", "<br>");
		review.setReviewDetail(reviewDetail);
		/////////// 디비 입출력시 엔터처리 ////////////////
		
		System.out.println("\n\n\n\n\n=====okokokokok=====\n\n\n\n\n");
		
		reviewService.updateReview(review);
		
		//test
		System.out.println("\n\nreviewService.getReview(reviewNo) :: "+reviewService.getReview(reviewNo));
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject(reviewService.getReview(reviewNo));
		modelAndView.setViewName("/view/review/getReview.jsp");
		
		return modelAndView;
		
	}
	
	
	
	@RequestMapping(value="getReviewList")
	public ModelAndView getReviewList( @ModelAttribute("search") Search search ) throws Exception{
		
		
		/*
		 * 매개변수 Model type : model 삭제함.
		 * 매개변수 HttpServletRequest type : request 삭제함.
		 * @ModelAttribute("review") Review review 삭제함
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
										HttpSession session) throws Exception{
		
		System.out.println("/view/review/getMyReviewList");
		
		if(search.getCurrentPage() == 0){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic 수행
		String userId = ((User)(session.getAttribute("user"))).getUserId();
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
											HttpSession session)
											throws Exception {
		
		System.out.println("/view/review/getCheckReviewList");
		
		System.out.println("((User)(session.getAttribute('user'))).getRole() :: "+((User)(session.getAttribute("user"))).getRole());
		
		if(((User)(session.getAttribute("user"))).getRole().equals("a")){
			
			if(search.getCurrentPage() == 0){
				search.setCurrentPage(1);
			}
			search.setPageSize(pageSize);
			
			// Business logic 수행
			Map<String, Object> map = reviewService.getCheckReviewList(search);
			Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
			System.out.println("\ngetCheckReviewList resultPage :: "+resultPage);
			
			ModelAndView modelAndView = new ModelAndView();
			modelAndView.addObject("list", map.get("list"));
			modelAndView.addObject("resultPage", resultPage);
			modelAndView.addObject("search", search);
			modelAndView.setViewName("/view/review/getCheckReviewList.jsp");
			return modelAndView;

		} else {
			ModelAndView modelAndView = new ModelAndView();
			modelAndView.setViewName("/index.jsp");
			return modelAndView;
		}
		
		
	}
	
	@RequestMapping(value="passCheckCode", method=RequestMethod.GET)
	public ModelAndView passCheckCode(@RequestParam("reviewNo") int reviewNo) throws Exception {
		
		System.out.println("review/passCheckCode");
		
		Review returnReview = reviewService.getReview(reviewNo); // review 객체를 method로 생성하여 받음
		reviewService.passCheckCode(returnReview);
		returnReview = reviewService.getReview(reviewNo);
		
		//Business Logic수행
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject(returnReview);
		modelAndView.setViewName("/view/review/getReview.jsp");
		return modelAndView;
	}
	
	@RequestMapping(value="passCheckCodeFromCheckReviewList", method=RequestMethod.GET)
	public ModelAndView passCheckCodeFromCheckReviewList(@RequestParam("reviewNo") int reviewNo) throws Exception {
		
		System.out.println("review/passCheckCodeFromCheckReviewList");
		
		Review returnReview = reviewService.getReview(reviewNo);
		reviewService.passCheckCode(returnReview);
		
		//Business Logic수행
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("redirect:/review/getCheckReviewList");
		return modelAndView;
	}
	
	@RequestMapping(value="failCheckCode", method=RequestMethod.GET)
	public ModelAndView failCheckCode(@RequestParam("reviewNo") int reviewNo) throws Exception {
		
		System.out.println("review/failCheckCode");
		
		Review returnReview = reviewService.getReview(reviewNo); // review 객체를 method로 생성하여 받음
		reviewService.failCheckCode(returnReview);
		returnReview = reviewService.getReview(reviewNo);
		
		//Business Logic수행
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject(returnReview);
		modelAndView.setViewName("/view/review/getReview.jsp");
		return modelAndView;
	}
	
	@RequestMapping(value="failCheckCodeFromCheckReviewList", method=RequestMethod.GET)
	public ModelAndView failCheckCodeFromCheckReviewList(@RequestParam("reviewNo") int reviewNo) throws Exception {
		
		System.out.println("review/failCheckCodeFromCheckReviewList");
		
		Review returnReview = reviewService.getReview(reviewNo);
		reviewService.failCheckCode(returnReview);
		
		//Business Logic수행
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("redirect:/review/getCheckReviewList");
		return modelAndView;
	}
	
	//Controller 이름 혼동하지 말것. addGood은 deleteGood과 함께한다
	@RequestMapping(value="addGood", method=RequestMethod.GET)
	public ModelAndView addGood(@RequestParam("reviewNo") int reviewNo, 
								@RequestParam("userId") String userId) throws Exception {
		
		System.out.println("review/addGood");
		
		Good good = new Good(reviewNo, userId);
		
		if(reviewService.checkGood(good) == null){
			reviewService.addGood(good);
		}else{
			reviewService.deleteGood(good);
		}
		
		Review returnReview = reviewService.getReview(reviewNo);
		
		//Business Logic수행
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject(returnReview);
		modelAndView.setViewName("/view/review/getReview.jsp");
		return modelAndView;
	}
	
	@RequestMapping(value="deleteReview", method=RequestMethod.POST)
	public ModelAndView deleteReview( @RequestParam("deleteReviewNo") int reviewNo, 
									@ModelAttribute("search") Search search) throws Exception {
		
		System.out.println("review/deleteReview");
		
		//test
		System.out.println("\n\n\n ReviewController search :: "+search+"\n\n\n");
		System.out.println("\n\n\n ReviewController reviewNo :: "+reviewNo+"\n\n\n");
		
		reviewService.deleteReview(reviewNo);
		
		//Business Logic수행
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/review/getMyReviewList");
		
		return modelAndView;
	}
	
	/*
	 * 아래의 Controller는 ckEditor를 이용한 이미지 업로드
	 * 미완
	 */
	@RequestMapping(value="imageUpload")
	public void imageUpload(HttpServletRequest request, HttpServletResponse response, @RequestParam("upload") MultipartFile upload) throws Exception{
		
		System.out.println(upload.getOriginalFilename());
		String fileName="upload.getOriginalFilename()";
		String path=request.getServletContext().getRealPath("/")+"\\resources\\uploadFile\\";
		
		File file=new File(path+fileName);
		String cknp=request.getParameter("CKEditorFuncNum");
		upload.transferTo(file);
		
		response.getWriter().println("<script type='text/javascript'>window.parent.CKEDITOR.tools.callFunction("
    			+ cknp
    			+ ",'"
                + "/resources/uploadFile/"+fileName
                + "','이미지를 업로드 하였습니다.'"
                + ")</script>");
		response.getWriter().flush();
		/*
		OutputStream out = null;
		PrintWriter printWriter = null;
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		
		try{
			String fileName = upload.getOriginalFilename();
			byte[] bytes = upload.getBytes();
			String uploadPath = "C:\\Users\\Admin\\git\\Codebrew\\Codebrew\\WebContent\\resources\\uploadFile\\"+fileName;
			
			out = new FileOutputStream(new File(uploadPath));
			out.write(bytes);
			String callback = request.getParameter("CKEditorFuncNum");
			
			printWriter = response.getWriter();
			String fileUrl = "imageUpload\\"+fileName; 
			
			printWriter.println("<script type='text/javascript'>window.parent.CKEDITOR.tools.callFunction("
                    			+ callback
                    			+ ",'"
			                    + fileUrl
			                    + "','이미지를 업로드 하였습니다.'"
			                    + ")</script>");
			printWriter.flush();
		} catch(IOException e) {
			e.printStackTrace();
		} finally {
			try{
				if (out != null){
					out.close();
				}
				if(printWriter != null){
					printWriter.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return;*/
	}

}

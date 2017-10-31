package com.codebrew.moana.web.reply;

import java.util.Map;

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
import org.springframework.web.servlet.ModelAndView;

import com.codebrew.moana.common.Page;
import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Reply;
import com.codebrew.moana.service.domain.User;
import com.codebrew.moana.service.reply.ReplyService;
import com.codebrew.moana.service.review.ReviewService;

@Controller
@RequestMapping("/reply/*")
public class ReplyController {

	///Field
	@Autowired
	@Qualifier("replyServiceImpl")
	private ReplyService replyService;
	
	@Autowired
	@Qualifier("reviewServiceImpl")
	private ReviewService reviewService;
	
	public ReplyController() {
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	
	//1. addReply : POST 방식 : 실제로 등록하여 getReview.jsp 로 넘어간다.(Rest가 아님)
	@RequestMapping(value="addReply", method=RequestMethod.POST)
	public ModelAndView addReply(@ModelAttribute("reply") Reply reply, 
								@RequestParam("reviewNo") int reviewNo, 
								HttpSession session, 
								HttpServletRequest request) throws Exception {
		
		System.out.println("ReplyController :: addReplyList");
		System.out.println("/view/reply/getReplyList ===>>> /view/review/getReplyList");
		
		User user = (User)session.getAttribute("user");
		System.out.println("user"+user);
		
		reply.setUserId(user.getUserId());
		reply.setReviewNo(reviewNo);
		
		replyService.addReply(reply);
		
		ModelAndView modelAndView = new ModelAndView();
		//modelAndView.addObject("reviewNo", reviewNo);
		modelAndView.addObject("reply", reply);
		modelAndView.setViewName("/review/getReview?reviewNo="+reviewNo);
		
		return modelAndView;
		
	}
	
	//2. getReplyList : 해당(reviewNo)에 맞는 reply목록들을 불러온다.
	public ModelAndView getReplyList(@RequestParam("search") Search search,
									@RequestParam("reply") Reply reply) throws Exception {
		
		System.out.println("ReplyController :: getReplyList");
		System.out.println("/view/reply/getReplyList ===>>> /view/review/getReplyList");
		
		if(search.getCurrentPage() == 0){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic 수행
		Map<String, Object> map = replyService.getReplyList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize );
		System.out.println(resultPage);
		
		// Model 과 View 연결
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);
		
		modelAndView.setViewName("/view/review/getReplyList.jsp");
		
		return modelAndView;
	}
	
	//3. updateReply : 본인이 작성한 댓글을 수정
	public ModelAndView updateReply(@RequestParam("search") Search search, 
									@RequestParam("reply") Reply reply) throws Exception {
		
		System.out.println("ReplyController :: updateReply");
		System.out.println("/view/reply/getReplyList ===>>> /view/review/getReplyList");
		
		// Business Logic 수행
		replyService.updateReply(reply);
		
		if(search.getCurrentPage() == 0){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		Map<String, Object> map = replyService.getReplyList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize );
		System.out.println(resultPage);
		
		//Model 과 View  연결
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);
		
		modelAndView.setViewName("/view/review/getReplyList.jsp");
		return modelAndView;
	}
	
	//4. deleteReply : 본인이 작성한 댓글을 삭제
	public ModelAndView deleteReply(@RequestParam("search") Search search, 
									@RequestParam("replyNo") int replyNo) throws Exception {
		
		System.out.println("ReplyController :: deleteReply");
		System.out.println("/view/reply/getReplyList ===>>> /view/review/getReplyList");
		
		//Business Logic 수행
		replyService.deleteReply(replyNo);
		
		if(search.getCurrentPage() == 0){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		Map<String, Object> map = replyService.getReplyList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		//Model 과 View 연결
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);
		
		modelAndView.setViewName("/view/review/getReplyList.jsp");
		return null;
	}
	
	
}

package com.codebrew.moana.web.review;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Reply;
import com.codebrew.moana.service.domain.User;
import com.codebrew.moana.service.reply.ReplyService;
import com.codebrew.moana.service.review.ReviewService;

//==>후기관리 & 댓글관리 RestController
@RestController
@RequestMapping({"/review/*", "/reply/*"})
public class ReviewRestController {
	
	///Field
	@Autowired
	@Qualifier("reviewServiceImpl")
	private ReviewService reviewService;
	
	@Autowired
	@Qualifier("replyServiceImpl")
	private ReplyService replyService;

	public ReviewRestController() {
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
//	@RequestMapping(value="json/addReply", method=RequestMethod.POST)
//	public List<Reply> addReply(@RequestBody Reply reply, Model model) throws Exception{
//		
//		System.out.println("/reply/addReply");
//		
//		//Business Logic
//		String userId = reply.getUser().getUserId();
//		//User user = userService.setUser(userId);
//		int reviewNo = reply.getReviewNo();
//		
//		//reply.setUser(user);
//		reply.setReviewNo(reviewNo);
//		
//		replyService.addReply(reply);
//		List<Reply> list = replyService.getReplyList(search, userId);
//		
//		return null;
//		
//	}
	
	
	@RequestMapping(value="json/getReply", method=RequestMethod.GET)
	public Reply getReply(@PathVariable int replyNo) throws Exception{
		
		System.out.println("/reply/json/getReply : GET");
		
		//Business Logic
		return replyService.getReply(replyNo);
	}
	
	
//	@RequestMapping(value="json/updateReply", method=RequestMethod.POST)
//	public Review updateReply(@RequestBody Reply reply) throws Exception{
//		
//		System.out.println("/reply/updateReply");
//		
//		//Business Logic
//		replyService.updateReply(reply);
//		
//	}
	
	//only for 'admin'
	@RequestMapping(value="json/getAllReplyList", method=RequestMethod.POST)
	public Map<String, Object> getAllReplyList(@RequestBody Search search) throws Exception{
		
		System.out.println("/reply/getAllReplyList");
		
		if(search.getCurrentPage() == 0){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		//BusinessLogic
		Map<String, Object> map = replyService.getAllReplyList(search);
		
		return map;
	}
		
	//for normal user
	@RequestMapping(value="json/getReplyList", method=RequestMethod.POST)
	public Map<String, Object> getReplyList(@RequestBody Search search, @RequestParam String userId) throws Exception{
		
		System.out.println("/reply/getReplyList");
		
		if(search.getCurrentPage() == 0){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		//BusinessLogic
		Map<String, Object> map = replyService.getReplyList(search, userId);
		
		return map;
	}	
	
}

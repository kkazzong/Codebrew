package com.codebrew.moana.web.reply;

import java.util.Map;

import javax.servlet.http.HttpSession;

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
import com.codebrew.moana.service.domain.Reply;
import com.codebrew.moana.service.reply.ReplyService;
import com.codebrew.moana.service.user.UserService;

@RestController
@RequestMapping("/replyRest/*")
public class ReplyRestController {

	///Field
	@Autowired
	@Qualifier("replyServiceImpl")
	private ReplyService replyService;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	
	public ReplyRestController(){
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	
	@RequestMapping(value="json/addReply", method=RequestMethod.POST)
	public Reply addReply(@RequestBody Reply reply, 
							HttpSession session) throws Exception {
		
		System.out.println("ReplyRestController");
		
		String userId = (String)session.getAttribute("userId");
		System.out.println("\n\nuserId :: "+userId);
		
		reply.setUserId(userId);
		replyService.addReply(reply);
		int replyNo = reply.getReplyNo();
		System.out.println("\n\nreplyNo"+replyNo);
		
		Reply returnReply = replyService.getReply(replyNo);
		
		return returnReply;
		
	}
	
	
	@RequestMapping(value="json/getReply/{replyNo}", method=RequestMethod.GET)
	public Reply getReply(@PathVariable int replyNo) throws Exception{
		
		System.out.println("/reply/json/getReply : GET");
		
		//Business Logic
		return replyService.getReply(replyNo);
	}
	
	
	@RequestMapping(value="/json/updateReply", method=RequestMethod.POST)
	public Reply updateReply(@RequestBody Reply reply) throws Exception{
		
		System.out.println("/reply/updateReply");
		System.out.println(reply);
		
		String returnReplyDetail = reply.getReplyDetail(); // 인자로 받은 replyDetail을 reutnReplyDetail로 넣음
		
		int replyNo = reply.getReplyNo();
		
		reply = replyService.getReply(replyNo); //인자로 받은 replyNo와 동일한 reply객체를 불러옴
		reply.setReplyDetail(returnReplyDetail); // 바로 위에서 불러온 reply객체에 returnReplyDetail을 set해준다.
		
		//test
		System.out.println("\n\nreplyNo :: "+reply.getReplyNo());
		System.out.println("\n\nreplyDetail :: "+reply.getReplyDetail());
		System.out.println("\n\nreviewNo :: "+reply.getReviewNo());
		System.out.println("\n\n\nreply :: "+reply+"\n\n\n");
		

		//Business Logic
		replyService.updateReply(reply);
		
		//test
		System.out.println("\n\n\n\n\nokokokokok\n\n\n\n\n");
		
		reply = replyService.getReply(replyNo);
		
		return reply;
		
	}
	
	
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
	public Map<String, Object> getReplyList(@RequestBody Search search, 
											@RequestParam String userId) throws Exception{
		
		System.out.println("/reply/getReplyList");
		
		if(search.getCurrentPage() == 0){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		
		return null;
	}	
	
}

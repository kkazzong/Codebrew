package com.codebrew.moana.web.reply;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Reply;
import com.codebrew.moana.service.domain.Review;
import com.codebrew.moana.service.domain.User;
import com.codebrew.moana.service.reply.ReplyService;
import com.codebrew.moana.service.user.UserService;

@RestController
@RequestMapping({"/reply/*"})
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
	public ResponseEntity<String> addReply(@RequestBody Reply reply, 
											HttpSession session) throws Exception{
		
		ResponseEntity<String> entity = null;
		String userId = (String) session.getAttribute("userId");
		reply.setUserId(userId);
		replyService.addReply(reply);
		
		entity = new ResponseEntity<String>("success", HttpStatus.OK);
		
		return entity;
		
	}
	
	
	@RequestMapping(value="json/getReply/{replyNo}", method=RequestMethod.GET)
	public Reply getReply(@PathVariable int replyNo) throws Exception{
		
		System.out.println("/reply/json/getReply : GET");
		
		//Business Logic
		return replyService.getReply(replyNo);
	}
	
	
	@RequestMapping(value="json/updateReply/{replyNo}", method=RequestMethod.POST)
	public Review updateReply(@RequestBody Reply reply) throws Exception{
		
		System.out.println("/reply/updateReply");
		
		//Business Logic
		replyService.updateReply(reply);
		
		//계속 수정요망
		return null;
		
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

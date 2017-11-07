package com.codebrew.moana.web.reply;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.codebrew.moana.common.Page;
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
	public Reply addReply(@RequestBody Reply reply) throws Exception {
		
		System.out.println("ReplyRestController");
		
		System.out.println("\n\nreply.toString() :: \n"+reply);
		
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
	
	
	@RequestMapping(value="json/updateReply", method=RequestMethod.POST)
	public Reply updateReply(@RequestBody Reply reply) throws Exception{
		
		System.out.println("/reply/updateReply");
		System.out.println(reply);
		
		String returnReplyDetail = reply.getReplyDetail(); // 인자로 받은 replyDetail을 reutnReplyDetail로 넣음
		
		int replyNo = reply.getReplyNo();
		
		reply = replyService.getReply(replyNo); //인자로 받은 replyNo와 동일한 reply객체를 불러옴
		reply.setReplyDetail(returnReplyDetail); // 바로 위에서 불러온 reply객체에 returnReplyDetail을 set해준다.
		
		//test
		System.out.println("\n\nreplyNo :: \n"+reply.getReplyNo());
		System.out.println("\n\nreplyDetail :: \n"+reply.getReplyDetail());
		System.out.println("\n\nreviewNo :: \n"+reply.getReviewNo());
		System.out.println("\n\n\nreply :: \n"+reply+"\n\n\n");
		

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
	public Map<String, Object> getReplyList(@RequestBody(required=false) Search search, 
											@PathVariable int reviewNo) throws Exception{
		
		System.out.println("/reply/getReplyList");
		
		if(search.getCurrentPage() == 0){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		//Business Logic
		Map<String, Object> map = replyService.getReplyList(search, reviewNo);
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);

		System.out.println("ReplyRestController :: map getReplyList"+map);
		System.out.println("\n\nRest : getReplyList resultPage :: "+resultPage);
		System.out.println("\n\nreturn mpa :: "+map.toString());
		
		//resultMap을 map에
		map.put("resultPage", resultPage);
		map.put("search", search);
		
		return map;
	}	
	
}

package com.codebrew.moana.service.reply;

import java.util.Map;

import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Reply;

//==> 댓글관리 CRUD : Service interface
//TTL Method : 6 EA
public interface ReplyService {
	
	//1
	public void addReply(Reply reply) throws Exception;
	
	//2
	public Reply getReply(int replyNo) throws Exception;
	
	//3
	public void updateReply(Reply reply) throws Exception;
	
	//4
	public void deleteReply(int replyNo) throws Exception;
	
	//5 안써
	public Map<String, Object> getAllReplyList(Search search) throws Exception;
	
	//6
	public Map<String, Object> getReplyList(Search search, int reviewNo) throws Exception;

}

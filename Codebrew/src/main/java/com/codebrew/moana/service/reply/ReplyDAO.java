package com.codebrew.moana.service.reply;

import java.util.List;

import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Reply;

//==> 댓글관리 CRUD : DAO interface
//TTL Method : 7 EA
public interface ReplyDAO {
	
	//1
	public void addReply(Reply reply) throws Exception;
	
	//2
	public Reply getReply(int replyNo) throws Exception;
	
	//3
	public void updateReply(Reply reply) throws Exception;
	
	//4
	public void deleteReply(int replyNo) throws Exception;
	
	//5
	public List<Reply> getAllReplyList(Search search) throws Exception;
	
	//6
	public List<Reply> getReplyList(Search search) throws Exception;
	
	//7
	public int getTotalCount(Search search) throws Exception;
}

package com.codebrew.moana.service.reply;

import java.util.List;

import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Reply;

//==> 댓글관리 CRUD : DAO interface
//TTL Method : 7 EA
public interface ReplyDAO {
	
	//1 댓글 입력
	public void addReply(Reply reply) throws Exception;
	
	//2 단일 댓글상세조회
	public Reply getReply(int replyNo) throws Exception;
	
	//3 댓글 수정
	public void updateReply(Reply reply) throws Exception;
	
	//4 댓글 삭제
	public void deleteReply(int replyNo) throws Exception;
	
	//5 해당 review에 대한 댓글 목록
	public List<Reply> getReplyList(Search search, int reviewNo) throws Exception;
	
	//6 댓글 갯수
	public int getTotalCount(Search search, int reviewNo) throws Exception;
}

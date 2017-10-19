package com.codebrew.moana.service.reply.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Reply;
import com.codebrew.moana.service.reply.ReplyDAO;
import com.codebrew.moana.service.reply.ReplyService;

@Service("replyServiceImpl")
public class ReplyServiceImpl implements ReplyService {

	///Field
	@Autowired
	@Qualifier("replyDAOImpl")
	ReplyDAO replyDAO;
	
	public ReplyServiceImpl() {
		System.out.println(this.getClass());
	}
	@Override
	public void addReply(Reply reply) throws Exception {
		// TODO Auto-generated method stub
		
	}
	@Override
	public Reply getReply(int replyNo) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public void updateReply(Reply reply) throws Exception {
		// TODO Auto-generated method stub
		
	}
	@Override
	public void deleteReply(int replyNo) throws Exception {
		// TODO Auto-generated method stub
		
	}
	@Override
	public Map<String, Object> getAllReplyList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public Map<String, Object> getReplyList(Search search, String userId) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	///Service Method
	

}

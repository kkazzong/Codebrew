package com.codebrew.moana.service.reply.impl;

import java.util.HashMap;
import java.util.List;
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
	public void setReplyDAO(ReplyDAO replyDAO){
		this.replyDAO = replyDAO;
	}
	
	public ReplyServiceImpl() {
		System.out.println(this.getClass());
	}
	
	///Service Method
	@Override //1
	public void addReply(Reply reply) throws Exception {
		replyDAO.addReply(reply);
	}
	@Override //2
	public Reply getReply(int replyNo) throws Exception {
		return replyDAO.getReply(replyNo);
	}
	@Override //3
	public void updateReply(Reply reply) throws Exception {
		replyDAO.updateReply(reply);
	}
	@Override //4
	public void deleteReply(int replyNo) throws Exception {
		replyDAO.deleteReply(replyNo);
	}
	@Override //5
	public Map<String, Object> getAllReplyList(Search search) throws Exception {
		/*
		List<Reply> replyList = replyDAO.getReplyList(search);
		int totalCount = replyDAO.getTotalCount(search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("replyList", replyList);
		map.put("totalCount", new Integer(totalCount));
		*/
		return null;
	}
	
	@Override //6
	public Map<String, Object> getReplyList(Search search, int reviewNo) throws Exception {
		
		List<Reply> replyList = replyDAO.getReplyList(search, reviewNo);
		int totalCount = replyDAO.getTotalCount(search, reviewNo);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("replyList", replyList);
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}

}

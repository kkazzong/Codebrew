package com.codebrew.moana.service.reply.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Reply;
import com.codebrew.moana.service.reply.ReplyDAO;

@Repository("replyDAOImpl")
public class ReplyDAOImpl implements ReplyDAO {
	
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;

	///Constructor
	public ReplyDAOImpl() {
		System.out.println(this.getClass());
	}
	
	///DAO Method
	public void setSqlSession(SqlSession sqlSession){
		this.sqlSession = sqlSession;
	}

	@Override //1 댓글 작성
	public void addReply(Reply reply) throws Exception {
		System.out.println("DAO :: addReply");
		sqlSession.insert("ReplyMapper.addReply", reply);
	}

	
	@Override //2 단일 댓글 조회
	public Reply getReply(int replyNo) throws Exception {
		System.out.println("DAO :: getReply");
		return sqlSession.selectOne("ReplyMapper.getReply", replyNo);
	}

	
	@Override //3 댓글 수정
	public void updateReply(Reply reply) throws Exception {
		System.out.println("DAO :: updateReply");
		sqlSession.update("ReplyMapper.updateReply", reply);
	}

	
	@Override //4 댓글 삭제
	public void deleteReply(int replyNo) throws Exception {
		System.out.println("DAO :: deleteReply");
		sqlSession.delete("ReplyMapper.deleteReply", replyNo);
	}

	
	@Override //5 해당 후기에 대한 댓글들
	public List<Reply> getReplyList(Search search, int reviewNo) throws Exception {
		System.out.println("DAO :: getReplyList");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("reviewNo", reviewNo);
		
		return sqlSession.selectList("ReplyMapper.getReplyList", map);
	}
	
	
	@Override //6 해당 후기에 대한 댓글이 몇개인지
	public int getTotalCount(Search search, int reviewNo) throws Exception{
		System.out.println("DAO :: getTotalCount");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("reviewNo", reviewNo);
		
		return sqlSession.selectOne("ReplyMapper.getTotalCount", map);
	}

}

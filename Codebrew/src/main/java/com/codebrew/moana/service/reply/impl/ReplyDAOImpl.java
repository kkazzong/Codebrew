package com.codebrew.moana.service.reply.impl;

import java.util.List;

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

	
	@Override //5 댓글 목록
	public List<Reply> getReplyList(Search search) throws Exception {
		System.out.println("DAO :: getReplyList");
		return sqlSession.selectList("ReplyMapper.getReplyList", search);
	}
	
	
	@Override //6
	public int getTotalCount(Search search) throws Exception{
		System.out.println("DAO :: getTotalCount");
		return sqlSession.selectOne("ReplyMapper.getTotalCount", search);
	}

}

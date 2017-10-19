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

	@Override
	public void addReply(Reply reply) throws Exception {
		sqlSession.insert("ReplyMapper.addReply", reply);
	}

	@Override
	public Reply getReply(int replyNo) throws Exception {
		return sqlSession.selectOne("ReplyMapper.getReply", replyNo);
	}

	@Override
	public void updateReply(Reply reply) throws Exception {
		sqlSession.update("ReplyMapper.updateReply", reply);
	}

	@Override
	public void deleteReply(int replyNo) throws Exception {
		sqlSession.delete("ReplyMapper.deleteReply", replyNo);
	}

	@Override
	public List<Reply> getAllReplyList(Search search) throws Exception {
		return sqlSession.selectList("ReplyMapper.getAllReplyList", search);
	}

	@Override
	public List<Reply> getReplyList(Search search) throws Exception {
		return sqlSession.selectList("ReplyMapper.getReplyList", search);
	}
	
	@Override
	public int getTotalCount(Search search) throws Exception{
		return sqlSession.selectOne("ReplyMapper.getTotalCount", search);
	}

}

package com.codebrew.moana.service.review.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Review;
import com.codebrew.moana.service.domain.User;
import com.codebrew.moana.service.review.ReviewDAO;

@Repository("reviewDAOImpl")
public class ReviewDAOImpl implements ReviewDAO {
	
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession){
		this.sqlSession = sqlSession;
	}
	
	///Constructor
	public ReviewDAOImpl() {
		System.out.println(this.getClass());
	}

	
	///DAO Method TTL : 11EA
	@Override //1
	public void addReview(Review review) throws Exception {
		sqlSession.insert("ReviewMapper.addReview", review);
	}
	@Override //2
	public Review getReview(int reviewNo) throws Exception {
		return sqlSession.selectOne("ReviewMapper.getReview", reviewNo);
	}
	@Override //3
	public void updateReview(Review review) throws Exception {
		sqlSession.update("ReviewMapper.updateReview", review);
	}
	@Override //4
	public void deleteReview(int reviewNo) throws Exception {
		sqlSession.delete("ReviewMapper.deleteReview", reviewNo);
	}
	@Override //5
	public List<Review> getReviewList(Search search) throws Exception {
		return sqlSession.selectList("ReviewMapper.getReviewList", search);
	}
	@Override //6
	public List<Review> getCheckReviewList(Search search) throws Exception {
//		search.setSearchCondition("1");
		return sqlSession.selectList("ReviewMapper.getCheckReviewList", search);
	}
	@Override //7
	public List<Review> getMyReviewList(Search search) throws Exception {
//		search.setSearchCondition("1");
		return sqlSession.selectList("ReviewMapper.getMyReviewList", search);
	}
	@Override //8
	public void passCheckCode(Review review) throws Exception {
		sqlSession.update("ReviewMapper.passCheckCode", review);
	}
	@Override //9
	public void failCheckCode(Review review) throws Exception {
		sqlSession.update("ReviewMapper.failCheckCode", review);
	}
	@Override //10
	public void addGood(User user) throws Exception {
		sqlSession.insert("ReviewMapper.addGood", user);
	}
	@Override //11
	public void deleteGood(int goodNo) throws Exception {
		sqlSession.delete("ReviewMapper.deleteGood", goodNo);
	}
	@Override //12
	public int getTotalCount(Search search) throws Exception{
		return sqlSession.selectOne("ReviewMapper.getTotalCount", search);
	}
}

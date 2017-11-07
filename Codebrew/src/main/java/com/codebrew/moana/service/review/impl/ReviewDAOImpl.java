package com.codebrew.moana.service.review.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Good;
import com.codebrew.moana.service.domain.Image;
import com.codebrew.moana.service.domain.Review;
import com.codebrew.moana.service.domain.Video;
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
		System.out.println("reviewDAO :: addReview");
		sqlSession.insert("ReviewMapper.addReview", review);
	}
	
	@Override //2
	public Review getReview(int reviewNo) throws Exception {
		System.out.println("reviewDAO :: getReview");
		return sqlSession.selectOne("ReviewMapper.getReview", reviewNo);
	}
	
	@Override //3
	public void updateReview(Review review) throws Exception {
		System.out.println("reviewDAO :: updateReview");
		sqlSession.update("ReviewMapper.updateReview", review);
	}
	
	@Override //4 : deleteFlag 만 4로 update 시켜준다
	public void deleteReview(int reviewNo) throws Exception {
		System.out.println("reviewDAO :: deleteReview");
		sqlSession.update("ReviewMapper.deleteReview", reviewNo);
	}
	
	@Override //5
	public List<Review> getReviewList(Search search) throws Exception {
		System.out.println("reviewDAO :: getReviewList");
		return sqlSession.selectList("ReviewMapper.getReviewList", search);
	}
	
	@Override //6
	public List<Review> getCheckReviewList(Search search) throws Exception {
		System.out.println("reviewDAO :: getCheckReviewList");
		return sqlSession.selectList("ReviewMapper.getCheckReviewList", search);
	}
	
	@Override //7
	public List<Review> getMyReviewList(Search search, String userId) throws Exception {
		System.out.println("reviewDAO :: getMyReviewList");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("userId", userId);
		return sqlSession.selectList("ReviewMapper.getMyReviewList", map);
	}
	
	@Override //8
	public void passCheckCode(Review review) throws Exception {
		System.out.println("reviewDAO :: passCheckCode");
		sqlSession.update("ReviewMapper.passCheckCode", review);
	}
	
	@Override //9
	public void failCheckCode(Review review) throws Exception {
		System.out.println("reviewDAO :: failCheckCode");
		sqlSession.update("ReviewMapper.failCheckCode", review);
	}
	
	@Override //10
	public void addGood(Good good) throws Exception {
		System.out.println("reviewDAO :: addGood");
		sqlSession.insert("ReviewMapper.addGood", good);
	}
	
	@Override //11
	public void deleteGood(Good good) throws Exception {
		System.out.println("reviewDAO :: deleteGood");
		sqlSession.delete("ReviewMapper.deleteGood", good);
	}
	
	@Override //10-1, 11-1
	public Good checkGood(Good good) throws Exception {
		System.out.println("reviewDAO :: checkGood");
		return sqlSession.selectOne("ReviewMapper.checkGood", good);
	}
	
	@Override //12
	public int getTotalCount(Search search) throws Exception {
		System.out.println("reviewDAO :: getTotalCount");
		return sqlSession.selectOne("ReviewMapper.getTotalCount", search);
	}
	
	@Override //13
	public int getMyReviewTotalCount(Search search, String userId) throws Exception {
		System.out.println("reviewDAO :: getMyReviewTotalCount");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("userId", userId);
		return sqlSession.selectOne("ReviewMapper.getMyReviewTotalCount", map);
	}
	
	@Override //14
	public int getCheckReviewTotalCount(Search search) throws Exception {
		System.out.println("reviewDAO :: getCheckReviewTotalCount");
		return sqlSession.selectOne("ReviewMapper.getCheckReviewTotalCount", search);
	}
	
	@Override //15
	public void uploadReviewImage(Map<String, Object> map) throws Exception {
		System.out.println("reviewDAO :: uploadReviewImage");
		sqlSession.insert("ReviewMapper.uploadReviewImage", map);
	}
	
	@Override //16
	public void uploadReviewHashtag(Map<String, Object> map) throws Exception {
		System.out.println("reviewDAO :: uploadReviewHashtag");
		sqlSession.insert("ReviewMapper.uploadReviewHashtag", map);
	}

	@Override //17
	public void uploadReviewVideo(Map<String, Object> map) throws Exception {
		System.out.println("reviewDAO :: uploadReviewVideo");
		sqlSession.insert("ReviewMapper.uploadReviewVideo", map);
	}
	
	@Override //18
	public List<Image> getReviewImage(int reviewNo) throws Exception {
		System.out.println("reviewDAO :: getReviewImage");
		return sqlSession.selectList("ReviewMapper.getReviewImage", reviewNo);
	}
	
	@Override //19
	public List<Video> getReviewVideo(int reviewNo) throws Exception {
		System.out.println("reviewDAO :: getReviewVideo");
		return sqlSession.selectList("ReviewMapper.getReviewVideo", reviewNo);
	}

	///////////////////////////////////////////////ODSay API////////////////////////////////////////////////////
	
	@Override //20
	public Map<String, Object> getTransportListAtStation(double x, double y, int radius) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	
}

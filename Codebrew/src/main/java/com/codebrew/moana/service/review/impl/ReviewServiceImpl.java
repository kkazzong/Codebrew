package com.codebrew.moana.service.review.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Review;
import com.codebrew.moana.service.domain.User;
import com.codebrew.moana.service.review.ReviewDAO;
import com.codebrew.moana.service.review.ReviewService;

//TTL Method : 11 EA
@Service("reviewServiceImpl")
public class ReviewServiceImpl implements ReviewService {
	
	///Field
	@Autowired
	@Qualifier("reviewDAOImpl")
	ReviewDAO reviewDAO;
	
	public void setReviewDAO(ReviewDAO reviewDAO){
		this.reviewDAO = reviewDAO;
	}

	public ReviewServiceImpl() {
		System.out.println(this.getClass());
	}

	///Service Method
	@Override
	public void addReview(Review review) throws Exception {
		reviewDAO.addReview(review);
	}

	@Override
	public Review getReview(int reviewNo) throws Exception {
		return reviewDAO.getReview(reviewNo);
	}

	@Override
	public void updateReview(Review review) throws Exception {
		reviewDAO.updateReview(review);
	}

	@Override
	public void deleteReview(int reviewNo) throws Exception {
		reviewDAO.deleteReview(reviewNo);
	}

	@Override
	public Map<String, Object> getReviewList(Search search) throws Exception {
		List<Review> list = reviewDAO.getReviewList(search);
		int totalCount = reviewDAO.getTotalCount(search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}

	@Override
	public Map<String, Object> getMyReviewList(Search search, String userId) throws Exception {
		List<Review> list = reviewDAO.getMyReviewList(search);
		int totalCount = reviewDAO.getTotalCount(search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("totalCount", new Integer(totalCount));
		return map;
	}

	@Override
	public Map<String, Object> getCheckReviewList(Search search, String checkCode) throws Exception {
		List<Review> list = reviewDAO.getCheckReviewList(search);
		int totalCount = reviewDAO.getTotalCount(search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("totalCount", new Integer(totalCount));
		return map;
	}

	@Override
	public void passCheckCode(Review review) throws Exception {
		reviewDAO.passCheckCode(review);
	}

	@Override
	public void failCheckCode(Review review) throws Exception {
		reviewDAO.failCheckCode(review);
	}

	@Override
	public void addGood(User user) throws Exception {
		reviewDAO.addGood(user);
	}

	@Override
	public void deleteGood(int goodNo) throws Exception {
		reviewDAO.deleteGood(goodNo);
	}

}

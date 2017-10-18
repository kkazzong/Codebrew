package com.codebrew.moana.service.review;

import java.util.Map;

import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Review;
import com.codebrew.moana.service.domain.User;

//==> 후기관리 CRUD : Service interface
//TTL Method : 11 EA
public interface ReviewService {

	//1
	public void addReview(Review review) throws Exception;
	
	//2
	public Review getReview(int reviewNo) throws Exception;
	
	//3
	public void updateReview(Review review) throws Exception;
	
	//4
	public void deleteReview(int reviewNo) throws Exception;
	
	//5
	public Map<String, Object> getReviewList(Search search) throws Exception;
	
	//6
	public Map<String, Object> getMyReviewList(Search search, String userId) throws Exception;
	
	//7
	public Map<String, Object> getCheckReviewList(Search search, String checkCode) throws Exception;
	
	//8
	public void passCheckCode(Review review) throws Exception;
	
	//9
	public void failCheckCode(Review review) throws Exception;
	
	//10
	public void addGood(User user) throws Exception;
	
	//11
	public void deleteGood(int goodNo) throws Exception;
	
}

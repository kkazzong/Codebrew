package com.codebrew.moana.service.review;

import java.util.List;
import java.util.Map;

import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Review;
import com.codebrew.moana.service.domain.User;

//==> 후기관리 CRUD : DAO interface
//TTL Method : 14 EA
public interface ReviewDAO {

	//1
	public void addReview(Review review) throws Exception;
	
	//2
	public Review getReview(int reviewNo)throws Exception;
	
	//3
	public void updateReview(Review review) throws Exception;
	
	//4
	public void deleteReview(int reviewNo) throws Exception;
	
	//5
	public List<Review> getReviewList(Search search) throws Exception;
	
	//6
	public List<Review> getCheckReviewList(Search search) throws Exception;
	
	//7
	public List<Review> getMyReviewList(Search search) throws Exception;
	
	/*
	 * "1" : 
	 * "2" : 
	 * "4" : 
	 * "11" : 
	 * "22" : 
	 * "44" : 
	 */
	//8
	public void passCheckCode(Review review) throws Exception;
	
	//9
	public void failCheckCode(Review review) throws Exception;
	
	//10
	public void addGood(User user) throws Exception;
	
	//11
	public void deleteGood(int goodNo) throws Exception;
	
	//12
	public int getTotalCount(Search search) throws Exception;
	
	//13
	public void uploadReviewImage(Map<String, Object> map) throws Exception;
	
	//14
	public void uploadReviewHashtag(Map<String, Object> map) throws Exception;
	
}

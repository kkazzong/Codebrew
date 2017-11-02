package com.codebrew.moana.service.review;

import java.util.List;
import java.util.Map;

import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Good;
import com.codebrew.moana.service.domain.Image;
import com.codebrew.moana.service.domain.Review;
import com.codebrew.moana.service.domain.Video;

//==> 후기관리 CRUD : Service interface
//TTL Method : 11 EA
public interface ReviewService {

	//1
	public Review addReview(Review review) throws Exception;
	
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
	public Map<String, Object> getCheckReviewList(Search search) throws Exception;
	
	//8
	public void passCheckCode(Review review) throws Exception;
	
	//9
	public void failCheckCode(Review review) throws Exception;
	
	//10
	public void addGood(Good good) throws Exception;
	
	//11
	public void deleteGood(Good good) throws Exception;
	
	//12
	public Good checkGood(Good good) throws Exception;
	
	//12
	public List<Image> getReviewImage(int reviewNo) throws Exception;
	
	//13
	public List<Video> getReviewVideo(int reviewNo) throws Exception;
	
	//14
	public Map<String, Object> getTransportListAtStation(double x, double y, int radius) throws Exception;
	
}

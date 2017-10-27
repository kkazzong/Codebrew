package com.codebrew.moana.service.review;

import java.util.List;
import java.util.Map;

import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Good;
import com.codebrew.moana.service.domain.Image;
import com.codebrew.moana.service.domain.Review;
import com.codebrew.moana.service.domain.User;
import com.codebrew.moana.service.domain.Video;

//==> 후기관리 CRUD : DAO interface
//TTL Method : 14 EA
public interface ReviewDAO {

	//1
	public void addReview(Review review) throws Exception;
	
	//2
	public Review getReview(int reviewNo)throws Exception;
	
	//3
	public void updateReview(Review review) throws Exception;
	
	//4 deleteFlag만 바꿔준다
	public void deleteReview(int reviewNo) throws Exception;
	
	//5
	public List<Review> getReviewList(Search search) throws Exception;
	
	//6
	public List<Review> getCheckReviewList(Search search) throws Exception;
	
	//7
	public List<Review> getMyReviewList(Search search) throws Exception;
	
	/*
	 * "1" : 심사대기중
	 * "2" : 1->2 통과
	 * "4" : 1->4 반려
	 * "11" : 업데이트후심사중
	 * "22" : 11->22 통과
	 * "44" : 11->44반려
	 */
	//8
	public void passCheckCode(Review review) throws Exception;
	
	//9
	public void failCheckCode(Review review) throws Exception;
	
	//10
	public void addGood(String userId, int reviewNo) throws Exception;
	
	//11
	public void deleteGood(String userId, int reviewNo) throws Exception;
	
	//10-1, 11-1
	public Good checkGood(String userId, int reviewNo) throws Exception;
	
	//12
	public int getTotalCount(Search search) throws Exception;
	
	//13
	public void uploadReviewImage(Map<String, Object> map) throws Exception;
	
	//14
	public void uploadReviewHashtag(Map<String, Object> map) throws Exception;
	
	//15
	public void uploadReviewVideo(Map<String, Object> map) throws Exception;
	
	//15
	public List<Image> getReviewImage(int reviewNo) throws Exception;
	
	//16
	public List<Video> getReviewVideo(int reviewNo) throws Exception;
	
}
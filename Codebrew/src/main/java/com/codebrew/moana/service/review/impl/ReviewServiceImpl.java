package com.codebrew.moana.service.review.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Image;
import com.codebrew.moana.service.domain.Review;
import com.codebrew.moana.service.domain.Video;
import com.codebrew.moana.service.review.ReviewDAO;
import com.codebrew.moana.service.review.ReviewService;

//TTL Method : 1 EA
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
	@Override //1
	public Review addReview(Review review) throws Exception {
		
		System.out.println("Service :: addReview");
		
		reviewDAO.addReview(review);
		
		if(review.getReviewImageList() != null && review.getReviewImageList().size() != 0) { //이미지 올렸을 때
			for(Image reviewImage : review.getReviewImageList()) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("reviewNo", review.getReviewNo()); //reviewNo
				map.put("reviewImage", reviewImage);
				reviewDAO.uploadReviewImage(map);
			}
		}
		if(review.getReviewVideoList() != null && review.getReviewVideoList().size() != 0){
			for(Video reviewVideo : review.getReviewVideoList()){
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("reviewNo", review.getReviewNo());
				map.put("reviewVideo", reviewVideo);
				reviewDAO.uploadReviewVideo(map);
			}
		}
			
		return reviewDAO.getReview(review.getReviewNo());
	}

	@Override //2
	public Review getReview(int reviewNo) throws Exception {
		return reviewDAO.getReview(reviewNo);
	}

	@Override //3
	public void updateReview(Review review) throws Exception {
		reviewDAO.updateReview(review);
	}

	@Override //4
	public void deleteReview(int reviewNo) throws Exception {
		reviewDAO.deleteReview(reviewNo);
	}

	@Override//5
	public Map<String, Object> getReviewList(Search search) throws Exception {
		
		List<Review> list = reviewDAO.getReviewList(search);
		int totalCount = reviewDAO.getTotalCount(search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}

	@Override //6
	public Map<String, Object> getMyReviewList(Search search, String userId) throws Exception {
		
		List<Review> list = reviewDAO.getMyReviewList(search);
		int totalCount = reviewDAO.getTotalCount(search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("totalCount", new Integer(totalCount));
		return map;
	}

	@Override //7
	public Map<String, Object> getCheckReviewList(Search search, String checkCode) throws Exception {
		
		List<Review> list = reviewDAO.getCheckReviewList(search);
		int totalCount = reviewDAO.getTotalCount(search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("totalCount", new Integer(totalCount));
		return map;
	}

	@Override //8
	public void passCheckCode(Review review) throws Exception {
		reviewDAO.passCheckCode(review);
	}

	@Override //9
	public void failCheckCode(Review review) throws Exception {
		reviewDAO.failCheckCode(review);
	}

	@Override //10
	public void addGood(String userId, int reviewNo) throws Exception {
		
		if(reviewDAO.checkGood(userId, reviewNo) == null){
			reviewDAO.addGood(userId, reviewNo);
		}else{
			reviewDAO.deleteGood(userId, reviewNo);
		}
	}

	@Override //11
	public void deleteGood(String userId, int reviewNo) throws Exception {
		reviewDAO.deleteGood(userId, reviewNo);
	}
	
	@Override //12
	public List<Image> getReviewImage(int reviewNo) throws Exception {
		return reviewDAO.getReviewImage(reviewNo);
	}
	
	@Override //14
	public List<Video> getReviewVideo(int reviewNo) throws Exception {
		return reviewDAO.getReviewVideo(reviewNo);
	}

}

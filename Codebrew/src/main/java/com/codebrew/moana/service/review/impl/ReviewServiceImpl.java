package com.codebrew.moana.service.review.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Good;
import com.codebrew.moana.service.domain.Image;
import com.codebrew.moana.service.domain.Review;
import com.codebrew.moana.service.domain.User;
import com.codebrew.moana.service.domain.Video;
import com.codebrew.moana.service.review.ReviewDAO;
import com.codebrew.moana.service.review.ReviewService;
import com.codebrew.moana.service.user.UserDAO;

@Service("reviewServiceImpl")
public class ReviewServiceImpl implements ReviewService {
	
	///Field
	@Autowired
	@Qualifier("reviewDAOImpl")
	private ReviewDAO reviewDAO;
	
	///Field
	@Autowired
	@Qualifier("ODSayAPIDAOImpl")
	private ReviewDAO ODSayAPIDAO;
	
	///Field
	@Autowired
	@Qualifier("userDAOImpl")
	private UserDAO userDAO;
	
	@Value("#{coconutProperties['reviewCoconut']}")
	int reviewCoconut;
	
	public void setReviewDAO(ReviewDAO reviewDAO){
		this.reviewDAO = reviewDAO;
	}
	
	public void setODSayAPIDAO(ReviewDAO ODSayAPIDAO){
		this.ODSayAPIDAO = ODSayAPIDAO;
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
	public Review updateReview(Review review) throws Exception {
		
		System.out.println("Service :: updateReview");
		
		reviewDAO.updateReview(review);
		
		if(review.getReviewImageList() != null && review.getReviewImageList().size() != 0) { //이미지 upload
			for(Image reviewImage : review.getReviewImageList()){
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("reviewNo", review.getReviewNo());
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
		
		List<Review> list = reviewDAO.getMyReviewList(search, userId); //이것만 적용시켜봄
		int totalCount = reviewDAO.getMyReviewTotalCount(search, userId);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("totalCount", new Integer(totalCount)); //미적용
		return map;
	}

	@Override //7
	public Map<String, Object> getCheckReviewList(Search search) throws Exception {
		
		List<Review> list = reviewDAO.getCheckReviewList(search);
		int totalCount = reviewDAO.getCheckReviewTotalCount(search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("totalCount", new Integer(totalCount));
		return map;
	}

	@Override //8
	public void passCheckCode(Review review) throws Exception {
		
		String userId = review.getUserId(); // parameter로 받은 review 작성자의 id로
		User user = userDAO.getUser(userId); // User객체 가져온다.
		int originalCoconutCount = user.getCoconutCount(); // 가져온 User 객체가 원래 가지고 있는 ttl coconutCount에다가
		user.setCoconutCount(originalCoconutCount+reviewCoconut); // review가 통과될 때 coconut을 지급한다.
		userDAO.updateCoconut(user);
		
		reviewDAO.passCheckCode(review);
	}

	@Override //9
	public void failCheckCode(Review review) throws Exception {
		reviewDAO.failCheckCode(review);
	}

	@Override //10
	public void addGood(Good good) throws Exception {
		reviewDAO.addGood(good);
		reviewDAO.updateReviewGoodCount(good);
	}

	@Override //11
	public void deleteGood(Good good) throws Exception {
		reviewDAO.deleteGood(good);
		reviewDAO.updateReviewGoodCount(good);
	}
	
	@Override //12
	public Good checkGood(Good good) throws Exception {
		return reviewDAO.checkGood(good);
	}
	
	@Override //12-1
	public Good getGood(String userId, int reviewNo) throws Exception {
		return reviewDAO.getGood(userId, reviewNo);
	}
	
	@Override //13 만약에 10, 11되면 필요없음 안되면 rest controller에서 수정 : 둘다 됨 혹시 몰라서 남겨둠.
	public void updateReviewGoodCount(Good good) throws Exception {
		reviewDAO.updateReviewGoodCount(good);
	}
	
	@Override //14
	public List<Image> getReviewImage(int reviewNo) throws Exception {
		return reviewDAO.getReviewImage(reviewNo);
	}
	
	@Override //15
	public List<Video> getReviewVideo(int reviewNo) throws Exception {
		return reviewDAO.getReviewVideo(reviewNo);
	}
	
	@Override //16
	public Map<String, Object> getTransportListAtStation(double x, double y, int radius) throws Exception {
		return ODSayAPIDAO.getTransportListAtStation(x, y, radius);
	}

}

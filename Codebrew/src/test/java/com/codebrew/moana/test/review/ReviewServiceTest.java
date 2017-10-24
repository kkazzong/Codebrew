package com.codebrew.moana.test.review;


import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.codebrew.moana.service.domain.Image;
import com.codebrew.moana.service.domain.Reply;
import com.codebrew.moana.service.domain.Review;
import com.codebrew.moana.service.reply.ReplyService;
import com.codebrew.moana.service.review.ReviewService;

import junit.framework.Assert;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration	(locations = {	"classpath:config/context-common.xml",
										"classpath:config/context-aspect.xml",
										"classpath:config/context-mybatis.xml",
										"classpath:config/context-transaction.xml" })

/*
 * Spring Test
 * @RunWith : Meta-data 를 통한 wiring(생성,DI) 할 객체 구현체 지정
 * @ContextConfiguration : Meta-data location 지정
 * @Test : 테스트 실행 소스 지정
 */


public class ReviewServiceTest {

	@Autowired
	@Qualifier("reviewServiceImpl")
	private ReviewService reviewService;
	
	@Autowired
	@Qualifier("replyServiceImpl")
	private ReplyService replyService;
	
	/*
	//@Test
	public void testaddReview() throws Exception{

		Review review = new Review();
		review.setUserId("user02@naver.com");
		review.setFestivalNo(141918);
		review.setReviewTitle("review_title_test1");
		review.setReviewFestivalRating(5);
		review.setReviewDetail("review_detail_test1");
		
		Image image1 = new Image();
		image1.setReviewImage("test1.png");
		Image image2 = new Image();
		image2.setReviewImage("test2.png");
		
		List<Image> imageList = new ArrayList<Image>();
		imageList.add(image1);
		imageList.add(image2);
		
		review.setReviewImageList(imageList);
		
		
		Review returnReview = reviewService.addReview(review);
		
		//DB먼저 확인해볼것 sequence number
		//review = reviewService.getReview(10006);
		
		//check
		Assert.assertEquals(10006, review.getReviewNo()); // DB에 저장되는 prod_no 확인
		Assert.assertEquals("user02@naver.com", review.getUserId());
		Assert.assertEquals("141918", review.getFestivalNo());
		Assert.assertEquals("1", review.getCheckCode());
		Assert.assertEquals("review_title_test1", review.getReviewTitle());
		Assert.assertEquals(5, review.getReviewFestivalRating());
		Assert.assertEquals("review_video_test1", review.getReviewVideo());
		Assert.assertEquals("review_detail_test1", review.getReviewDetail());
		Assert.assertNotNull(returnReview);
	}*/
	
	@Test
	public void testAddReply() throws Exception{
		
		Reply reply = new Reply();
		reply.setReplyDetail("testtest");
		reply.setReplyNo(10001);
		reply.setReplyRegDate("17/10/24 12:49:34");
		reply.setReviewNo(10107);
		reply.setUserId("user02@naver.com");
		
		Reply returnReply = replyService.getReply(10001);
		
		Assert.assertNotNull(returnReply);
		
	}
	
}

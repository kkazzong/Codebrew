package com.codebrew.moana.web.review;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.codebrew.moana.service.review.ReviewService;

//==>후기관리 & 댓글관리 RestController
@RestController
@RequestMapping({"/review/*", "/reply/*"})
public class ReviewRestController {
	
	///Field
	@Autowired
	@Qualifier("reviewServiceImpl")
	private ReviewService reviewService;
	
	public ReviewRestController() {
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	
	
	
}

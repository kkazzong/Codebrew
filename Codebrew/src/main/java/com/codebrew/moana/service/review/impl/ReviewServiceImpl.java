package com.codebrew.moana.service.review.impl;

import org.springframework.stereotype.Service;

import com.codebrew.moana.service.review.ReviewService;

@Service("reviewServiceImpl")
public class ReviewServiceImpl implements ReviewService {

	public ReviewServiceImpl() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass());
	}

}

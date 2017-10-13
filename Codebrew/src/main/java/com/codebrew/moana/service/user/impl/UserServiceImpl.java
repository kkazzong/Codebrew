package com.codebrew.moana.service.user.impl;

import org.springframework.stereotype.Service;

import com.codebrew.moana.service.user.UserService;

@Service("userServiceImpl")
public class UserServiceImpl implements UserService {

	public UserServiceImpl() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass());
	}

}

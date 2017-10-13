package com.codebrew.moana.service.purchase.impl;

import org.springframework.stereotype.Service;

import com.codebrew.moana.service.purchase.PurchaseService;

@Service("purchaseServiceImpl")
public class PurchaseServiceImpl implements PurchaseService {

	public PurchaseServiceImpl() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass());
	}

}

package com.codebrew.moana.service.purchase.impl;

import java.util.List;

import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Purchase;
import com.codebrew.moana.service.domain.QRCode;
import com.codebrew.moana.service.purchase.PurchaseDAO;

public class KakaoAPIDAOImpl implements PurchaseDAO {

	public KakaoAPIDAOImpl() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public Purchase readyPayment(Purchase purchase) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Purchase approvePayment(String pgToken) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int addPurchase(Purchase purchase, String path) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Purchase getPurchase(int purchaseNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Purchase> getPurchaseList(String userId, String purchaseFlag, Search search) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Purchase> getSaleList(Search search) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int cancelPayment(Purchase purchase) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updatePurchaseTranCode(Purchase purchase) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deletePurchase(int purchaseNo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int getTotalCount(String userId, Search search) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public QRCode createQRCode(String path) {
		// TODO Auto-generated method stub
		return null;
	}

}

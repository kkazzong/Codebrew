package com.codebrew.moana.service.purchase;

import java.util.List;
import java.util.Map;

import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Purchase;

public interface PurchaseDAO {
	
	public int addPurchase(Purchase purchase); 
	public Purchase getPurchase(int purchaseNo);
	public List<Purchase> getPurchaseList(String userId, String purchaseFlag, Search search);
	public List<Purchase> getSaleList(Search search);
	public int updatePurchaseTranCode(Purchase purchase);
	public int deletePurchase(int purchaseNo);
	public Purchase readyPayment(Purchase purchase);
	public Purchase approvePayment(String pgToken);
	public void cancelPayment(Purchase purchase);
	public int getTotalCount(String userId, Search search);
	
}

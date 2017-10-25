package com.codebrew.moana.service.purchase;

import java.util.Map;

import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Purchase;

public interface PurchaseService {

	public Purchase readyPayment(Purchase purchase);
	public Purchase approvePayment(String pgToken, String path) throws Exception;
	public int cancelPayment(int purchaseNo);
	public Purchase addPurchase(Purchase purchase, String path) throws Exception;
	public Purchase getPurchase(int purchaseNo);
	public Map<String, Object> getPurchaseList(String userId, String purchaseFlag, Search search);
	public Map<String, Object> getSaleList(Search search);
	public int cancelPurchase(Purchase purchase) throws Exception;
	public int deletePurchase(int purchaseNo);
}

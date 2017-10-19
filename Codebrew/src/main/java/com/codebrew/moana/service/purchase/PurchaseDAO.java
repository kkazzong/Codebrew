package com.codebrew.moana.service.purchase;

import java.util.List;

import javax.servlet.http.HttpSession;

import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Purchase;
import com.codebrew.moana.service.domain.QRCode;

public interface PurchaseDAO {
	
	public Purchase readyPayment(Purchase purchase);
	public Purchase approvePayment(String pgToken);
	public int addPurchase(Purchase purchase, String path) throws Exception; 
	public Purchase getPurchase(int purchaseNo);
	public List<Purchase> getPurchaseList(String userId, String purchaseFlag, Search search);
	public List<Purchase> getSaleList(Search search);
	public int cancelPayment(Purchase purchase);
	public int updatePurchaseTranCode(Purchase purchase) throws Exception;
	public int deletePurchase(int purchaseNo);
	public int getTotalCount(String userId, Search search);
	public QRCode createQRCode(String path);
	
}

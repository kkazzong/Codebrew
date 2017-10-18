package com.codebrew.moana.test.statistics;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.codebrew.moana.service.domain.Festival;
import com.codebrew.moana.service.domain.Party;
import com.codebrew.moana.service.domain.Purchase;
import com.codebrew.moana.service.domain.QRCode;
import com.codebrew.moana.service.domain.Statistics;
import com.codebrew.moana.service.domain.User;
import com.codebrew.moana.service.purchase.PurchaseDAO;
import com.codebrew.moana.service.statistics.StatisticsDAO;

/*
 *	FileName :  UserServiceTest.java
 * �� JUnit4 (Test Framework) �� Spring Framework ���� Test( Unit Test)
 * �� Spring �� JUnit 4�� ���� ���� Ŭ������ ���� ������ ��� ���� �׽�Ʈ �ڵ带 �ۼ� �� �� �ִ�.
 * �� @RunWith : Meta-data �� ���� wiring(����,DI) �� ��ü ����ü ����
 * �� @ContextConfiguration : Meta-data location ����
 * �� @Test : �׽�Ʈ ���� �ҽ� ����
 */
@RunWith(SpringJUnit4ClassRunner.class)

// ==> Meta-Data �� �پ��ϰ� Wiring ����...
@ContextConfiguration(locations = { "classpath:config/context-*.xml" })

// @ContextConfiguration(locations = { "classpath:config/context-common.xml" })
public class StatisticsServiceTest {

	@Autowired
	@Qualifier("statisticsDAOImpl")
	StatisticsDAO statisticsDAO;

	@Test
	public void getDailyTotalSaleAmountStat() throws Exception {
		
		List<Statistics> list = statisticsDAO.getDailyTotalSaleAmountStat();
		
		Assert.assertNotNull(list);
		Assert.assertEquals(4, list.size());
	}
	
	//@Test
	public void getMonthlyTotalSaleAmountStat() throws Exception {
		
		List<Statistics> list = statisticsDAO.getMonthlyTotalSaleAmountStat();

		Assert.assertNotNull(list);
		
	}
	
	//@Test
	public void getQuarterTotalSaleAmountStat() throws Exception {
		
		List<Statistics> list = statisticsDAO.getQuarterTotalSaleAmountStat();
		
		Assert.assertNotNull(list);
		Assert.assertEquals(4, list.size());
	}
}
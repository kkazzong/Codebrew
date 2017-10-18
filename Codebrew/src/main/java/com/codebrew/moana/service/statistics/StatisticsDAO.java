package com.codebrew.moana.service.statistics;

import java.util.List;

import com.codebrew.moana.service.domain.Statistics;

public interface StatisticsDAO {
	public List<Statistics> getDailyTotalSaleAmountStat() throws Exception;
	public List<Statistics> getMonthlyTotalSaleAmountStat() throws Exception;
	public List<Statistics> getQuarterTotalSaleAmountStat() throws Exception;
}

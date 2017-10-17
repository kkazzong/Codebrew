package com.codebrew.moana.service.statistics;

import java.util.List;

import com.codebrew.moana.service.domain.Statistics;

public interface StatisticsDAO {
	public List<Statistics> getDailyTotalSaleAmountStat();
	public List<Statistics> getMonthlyTotalSaleAmountStat();
	public List<Statistics> getQuarterTotalSaleAmountStat();
}

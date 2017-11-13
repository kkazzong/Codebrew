package com.codebrew.moana.service.statistics;

import java.util.List;
import java.util.Map;

import com.codebrew.moana.service.domain.Statistics;

public interface StatisticsDAO {
	public List<Statistics> getDailyTotalSaleAmountStat() throws Exception;
	public List<Statistics> getDailyTotalSaleAmountStat(Statistics statistics) throws Exception;
	public List<Statistics> getMonthlyTotalSaleAmountStat() throws Exception;
	public List<Statistics> getMonthlyTotalSaleAmountStat(Statistics statistics) throws Exception;
	/*public List<Statistics> getMonthlyTotalSaleAmountStat(Map map) throws Exception;*/
	public List<Statistics> getQuarterTotalSaleAmountStat() throws Exception;
	public List<Statistics> getQuarterTotalSaleAmountStat(Statistics statistics) throws Exception;
	public List<Statistics> getFestivalZzim() throws Exception;
	public List<Statistics> getFestivalRating() throws Exception;
	public List<Statistics> getPartyCount() throws Exception;
	public List<Statistics> getTotalCount() throws Exception;
}

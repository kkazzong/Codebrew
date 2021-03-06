package com.codebrew.moana.service.statistics;

import java.util.List;

import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Statistics;

public interface StatisticsService {
	public List<Statistics> getStatistic(String statFlag) throws Exception;
	public List<Statistics> getStatistic(Statistics statistics) throws Exception;
	public List<Statistics> getFestivalZzim() throws Exception;
	public List<Statistics> getFestivalRating() throws Exception;
	public List<Statistics> getPartyCount() throws Exception;
	public List<Statistics> getTotalCount() throws Exception;
}

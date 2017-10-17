package com.codebrew.moana.service.statistics.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.codebrew.moana.service.domain.Statistics;
import com.codebrew.moana.service.statistics.StatisticsDAO;

@Repository("statisticsDAOImpl")
public class StatisticsDAOImpl implements StatisticsDAO{

	@Autowired
	@Qualifier("sqlSessionTemplate")
	SqlSession sqlSession;
	
	public StatisticsDAOImpl() {
		System.out.println(this.getClass());
	}

	@Override
	public List<Statistics> getDailyTotalSaleAmountStat() {
		return sqlSession.selectList("StatisticsMapper.getDailyTotalSaleAmountStat");
	}
	
	@Override
	public List<Statistics> getMonthlyTotalSaleAmountStat() {
		return sqlSession.selectList("StatisticsMapper.getMonthlyTotalSaleAmountStat");
	}
	
	@Override
	public List<Statistics> getQuarterTotalSaleAmountStat() {
		return sqlSession.selectList("StatisticsMapper.getQuarterTotalSaleAmountStat");
	}
}

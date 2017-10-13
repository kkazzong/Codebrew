package com.codebrew.moana.service.statistics.impl;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.codebrew.moana.service.statistics.StatisticsDAO;

@Repository("statisticsDAOImpl")
public class StatisticsDAOImpl implements StatisticsDAO {
	
	@Autowired
	@Qualifier("sqlSessionTemplate")
	SqlSession sqlSession;

	public StatisticsDAOImpl() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass());
	}

}

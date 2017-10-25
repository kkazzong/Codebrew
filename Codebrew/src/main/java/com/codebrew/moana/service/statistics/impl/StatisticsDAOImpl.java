package com.codebrew.moana.service.statistics.impl;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Repository;

import com.codebrew.moana.service.domain.Statistics;
import com.codebrew.moana.service.statistics.StatisticsDAO;

@Repository("statisticsDAOImpl")
public class StatisticsDAOImpl implements StatisticsDAO{

	@Autowired
	@Qualifier("sqlSessionTemplate")
	SqlSession sqlSession;
	
	@Value("#{imageRepositoryProperties['jsonFile']}")
	private String jsonFilePath;
	
	public StatisticsDAOImpl() {
		System.out.println(this.getClass());
	}

	@Override
	public List<Statistics> getDailyTotalSaleAmountStat() throws Exception {
		writeJson(sqlSession.selectList("StatisticsMapper.getDailyTotalSaleAmountStat"));
		return sqlSession.selectList("StatisticsMapper.getDailyTotalSaleAmountStat");
	}
	
	@Override
	public List<Statistics> getDailyTotalSaleAmountStat(Statistics statistics) throws Exception {
		return sqlSession.selectList("StatisticsMapper.getDailyTotalSaleAmountStat2", statistics);
	}
	
	@Override
	public List<Statistics> getMonthlyTotalSaleAmountStat() throws Exception {
		return sqlSession.selectList("StatisticsMapper.getMonthlyTotalSaleAmountStat");
	}
	
	@Override
	public List<Statistics> getMonthlyTotalSaleAmountStat(Statistics statistics) throws Exception {
		return sqlSession.selectList("StatisticsMapper.getMonthlyTotalSaleAmountStat2", statistics);
	}
	
	@Override
	public List<Statistics> getQuarterTotalSaleAmountStat() throws Exception {
		return sqlSession.selectList("StatisticsMapper.getQuarterTotalSaleAmountStat");
	}
	
	@Override
	public List<Statistics> getQuarterTotalSaleAmountStat(Statistics statistics) throws Exception {
		return sqlSession.selectList("StatisticsMapper.getQuarterTotalSaleAmountStat2", statistics);
	}

	
	public  void writeJson(List list) {
		
		System.out.println(jsonFilePath);
		
		JSONObject jsonObject = new JSONObject();
		JSONArray jsonArray = new JSONArray();
		
		Statistics stat = null;
		for(int i = 0; i < list.size(); i++) {
			stat = ((List<Statistics>)list).get(i);
			jsonObject.put("statDate", stat.getStatDate());
			jsonObject.put("totalPrice", stat.getTotalPrice());
			jsonObject.put("totalCount", stat.getTotalCount());
			System.out.println("jsonObject : "+jsonObject.toString());
			jsonArray.add(jsonObject);
			System.out.println("jsonArray : "+jsonArray.toString());
		}
		
		FileWriter writer = null;
		try {
			writer = new FileWriter(new File(jsonFilePath+"\\test.json"));
			writer.write(jsonArray.toJSONString());
			writer.flush();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(writer != null) {
				try {
					writer.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		
	}

	
}

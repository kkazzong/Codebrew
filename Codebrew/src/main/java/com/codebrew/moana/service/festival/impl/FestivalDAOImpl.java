package com.codebrew.moana.service.festival.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Festival;
import com.codebrew.moana.service.domain.Weather;
import com.codebrew.moana.service.domain.Zzim;
import com.codebrew.moana.service.festival.FestivalDAO;

@Repository("festivalDAOImpl")
public class FestivalDAOImpl implements FestivalDAO {

	/// Field
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;

	private Festival festival;

	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	/// Constructor
	public FestivalDAOImpl() {
		System.out.println(this.getClass());
	}
	
	@Override
	public void deleteFestival(Festival festival) throws Exception {
		// TODO Auto-generated method stub
		
		sqlSession.update("FestivalMapper.updateFestival" , festival);
		
	}

	@Override
	public void addFestival(Festival festival) throws Exception {
		// TODO Auto-generated method stub

		sqlSession.insert("FestivalMapper.addFestival", festival);
	}

	@Override
	public int getTotalCount(Search search) throws Exception {
		// TODO Auto-generated method stub

		return sqlSession.selectOne("FestivalMapper.getTotalCount", search);
	}

	@Override
	public Festival getFestivalDB(int festivalNo) throws Exception {
		// TODO Auto-generated method stub

		return sqlSession.selectOne("FestivalMapper.getFestivalDB", festivalNo);
	}

	@Override
	public List<Festival> getFestivalListDB(Search search) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("FestivalMapper.getFestivalListDB", search);
	}

	@Override
	public void addZzim(Zzim zzim) throws Exception {
		// TODO Auto-generated method stub

		sqlSession.insert("ZzimMapper.addZzim", zzim);

	}

	@Override
	public Zzim getZzim(Zzim zzim) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("ZzimMapper.getZzim", zzim);
	}

	@Override
	public void deleteZzim(Zzim zzim) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.delete("ZzimMapper.deleteZzim", zzim);

	}

	@Override
	public void updateFestival(Festival festival) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update("FestivalMapper.updateFestival", festival);
	}

	@Override
	public void appendReadCount(Festival festival) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update("FestivalMapper.appendReadCount", festival);

	}
	
	@Override
	public void writeFestival(Festival festival) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.insert("FestivalMapper.writeFestival", festival);
	}
		

	
	///////////////////////////////////////////////////////////////////////
	@Override
	public Festival getFestival(int festivalNo) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Map<String, Object> getFestivalList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Map<String, Object> searchKeywordList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Weather weather(String festivalLat, String festivalLon) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

}
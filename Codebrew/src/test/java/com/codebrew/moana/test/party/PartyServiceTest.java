package com.codebrew.moana.test.party;

import java.util.List;
import java.util.Map;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Festival;
import com.codebrew.moana.service.domain.Party;
import com.codebrew.moana.service.domain.PartyMember;
import com.codebrew.moana.service.domain.User;
import com.codebrew.moana.service.party.PartyDAO;
import com.codebrew.moana.service.party.PartyService;




/*
 *	FileName :  UserServiceTest.java
 * ㅇ JUnit4 (Test Framework) 과 Spring Framework 통합 Test( Unit Test)
 * ㅇ Spring 은 JUnit 4를 위한 지원 클래스를 통해 스프링 기반 통합 테스트 코드를 작성 할 수 있다.
 * ㅇ @RunWith : Meta-data 를 통한 wiring(생성,DI) 할 객체 구현체 지정
 * ㅇ @ContextConfiguration : Meta-data location 지정
 * ㅇ @Test : 테스트 실행 소스 지정
 */
@RunWith(SpringJUnit4ClassRunner.class)

//==> Meta-Data 를 다양하게 Wiring 하자...
//@ContextConfiguration(locations = { "classpath:config/context-*.xml" })
@ContextConfiguration	(locations = {	"classpath:config/context-common.xml",
																	"classpath:config/context-aspect.xml",
																	"classpath:config/context-mybatis.xml",
																	"classpath:config/context-transaction.xml" })
//@ContextConfiguration(locations = { "classpath:config/context-common.xml" })
public class PartyServiceTest {

	//==>@RunWith,@ContextConfiguration 이용 Wiring, Test 할 instance DI
	@Autowired
	@Qualifier("partyServiceImpl")
	private PartyService partyService;
	
	@Autowired
	@Qualifier("partyDAOImpl")
	private PartyDAO partyDAO;
	
	
	//@Test
	public void testAddParty() throws Exception {
		
		User user = new User();
		user.setUserId("user01@naver.com");
		
		Party party = new Party();
		party.setPartyName("파티등록 테스트");
		party.setUser(user);
		party.setPartyDate("17/10/30");
		party.setPartyTime("17시 50분");
		
		partyDAO.addParty(party);
	}
	//@Test
	public void testGetParty() throws Exception {
		
		Party party = new Party();
		
		party = partyDAO.getParty(10040, "2");
		//party = partyService.getParty(10040, "1");
		//party = partyService.getParty(10006);

		//==> console 확인
		System.out.println("testGetParty() party :: "+party); 
		
		//==> API 확인
		Assert.assertEquals("할로윈파티", party.getPartyName());
		Assert.assertEquals("미드나잇 할로윈 파티 2017 : 몬스터 시티 2017", party.getFestival().getFestivalName());
		Assert.assertEquals("쎄리", party.getUser().getNickname());
		
		//Assert.assertEquals("17/10/25", party.getPartyDate());
	}
	
	
	//@Test
	public void testUpdateParty() throws Exception {
		
		Party party = new Party();
		
		party = partyService.getParty(10000,"2");

		//==> console 확인
		System.out.println("testUpdateParty() party :: "+party);
		
		//==> API 확인
		/*Assert.assertEquals("할로윈파티", party.getPartyName());
		Assert.assertEquals("미드나잇 할로윈 파티 2017 : 몬스터 시티 2017", party.getFestival().getFestivalName());
		//Assert.assertEquals("17/10/26", party.getPartyDate());
		Assert.assertEquals("20시 00분", party.getPartyTime());
		Assert.assertEquals("할로윈데이 같이 즐겨요", party.getPartyDetail());
		Assert.assertEquals(10, party.getPartyMemberLimit());
		Assert.assertEquals("서울특별시 강남구 강남대로 588 렉스관광호텔", party.getPartyPlace());
		Assert.assertEquals("default_party_image.jpg", party.getPartyImage());*/
		
		
		
		/////////////////////////////////////////////////////////////////////
		
		
		Festival festival = new Festival();
		festival.setFestivalNo(2510089);
		party.setPartyName("할로윈 파티");
		party.setFestival(festival);
		party.setPartyDate("17/10/27");
		party.setPartyTime("21시 00분");
		party.setPartyDetail("할로윈 데이 같이 즐겨요");
		party.setPartyMemberLimit(20);
		party.setPartyPlace("서울특별시 서초구 강남대로53길 8 비트아카데미빌딩");
		party.setPartyImage("1507724033981_party1.jpg");
		
		
		partyService.updateParty(party);
		party = partyService.getParty(10000,"2");
		
		//==> API 확인
		Assert.assertEquals("할로윈 파티", party.getPartyName());
		Assert.assertEquals("롯데시티호텔마포 할로윈 나이트 풀파티 2017", party.getFestival().getFestivalName());
		Assert.assertEquals("17/10/27", party.getPartyDate());
		Assert.assertEquals("21시 00분", party.getPartyTime());
		Assert.assertEquals("할로윈 데이 같이 즐겨요", party.getPartyDetail());
		Assert.assertEquals(20, party.getPartyMemberLimit());
		Assert.assertEquals("서울특별시 서초구 강남대로53길 8 비트아카데미빌딩", party.getPartyPlace());
		Assert.assertEquals("1507724033981_party1.jpg", party.getPartyImage());
		
	}
	
	
	//@Test
	public void testDeleteParty() throws Exception {
		
		Party party = new Party();
		
		int partyNo = 10000;
		
		partyService.deleteParty(partyNo);				
		party = partyService.getParty(partyNo,"2");
		
		//==> console 확인
		System.out.println("testDeleteParty() party :: "+party);
		
		//==> API 확인
		Assert.assertEquals("del", party.getDeleteFlag());
		
	}
	
	
	//@Test
	public void testGetPartyListAll() throws Exception{
		 
	 	Search search = new Search();
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	
	 	Map<String,Object> map = partyService.getPartyList(search);
	 	
	 	List<Object> list = (List<Object>)map.get("list");
	 	Assert.assertEquals(2, list.size());
	 	
		//==> console 확인
	 	System.out.println("testGetPartyListAll() list :: "+list);
	 	
	 	Integer totalCount = (Integer)map.get("totalCount");
	 	
	 	//==> console 확인
	 	System.out.println("testGetPartyListAll() totalCount :: "+totalCount);
	 	
	 	System.out.println("=======================================");
	 	
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	search.setSearchCondition("0");
	 	search.setSearchKeyword("");
	 	map = partyService.getPartyList(search);
	 	
	 	list = (List<Object>)map.get("list");
	 	Assert.assertEquals(2, list.size());
	 	
	 	//==> console 확인
	 	System.out.println("testGetPartyListAll() list :: "+list);
	 	
	 	totalCount = (Integer)map.get("totalCount");

	 	//==> console 확인
	 	System.out.println("testGetPartyListAll() totalCount :: "+totalCount);
	 }
	
	
	//@Test
	public void testGetPartyListByPartyCondition() throws Exception{
		 
	 	Search search = new Search();
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	search.setSearchCondition("1");
	 	search.setSearchKeyword("할로윈");
	 	
	 	
	 	Map<String,Object> map = partyService.getPartyList(search);
	 	
	 	List<Object> list = (List<Object>)map.get("list");
	 	Assert.assertEquals(0, list.size());
	 	
		//==> console 확인
	 	System.out.println("testGetPartyListAll() list :: "+list);
	 	
	 	Integer totalCount = (Integer)map.get("totalCount");
	 	
	 	//==> console 확인
	 	System.out.println("testGetPartyListAll() totalCount :: "+totalCount);
	 	
	 	System.out.println("=======================================");
	 	
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	search.setSearchCondition("1");
	 	search.setSearchKeyword(""+System.currentTimeMillis());
	 	map = partyService.getPartyList(search);
	 	
	 	list = (List<Object>)map.get("list");
	 	Assert.assertEquals(0, list.size());
	 	
	 	//==> console 확인
	 	System.out.println("testGetPartyListAll() list :: "+list);
	 	
	 	totalCount = (Integer)map.get("totalCount");

	 	//==> console 확인
	 	System.out.println("testGetPartyListAll() totalCount :: "+totalCount);
	 }
	
	
	//@Test
	public void testGetPartyListByAfterPartyCondition() throws Exception{
		 
	 	Search search = new Search();
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	search.setSearchCondition("2");
	 	search.setSearchKeyword("할로윈");
	 	
	 	
	 	Map<String,Object> map = partyService.getPartyList(search);
	 	
	 	List<Object> list = (List<Object>)map.get("list");
	 	Assert.assertEquals(2, list.size());
	 	
		//==> console 확인
	 	System.out.println("testGetPartyListAll() list :: "+list);
	 	
	 	Integer totalCount = (Integer)map.get("totalCount");
	 	
	 	//==> console 확인
	 	System.out.println("testGetPartyListAll() totalCount :: "+totalCount);
	 	
	 	System.out.println("=======================================");
	 	
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	search.setSearchCondition("2");
	 	search.setSearchKeyword(""+System.currentTimeMillis());
	 	map = partyService.getPartyList(search);
	 	
	 	list = (List<Object>)map.get("list");
	 	Assert.assertEquals(0, list.size());
	 	
	 	//==> console 확인
	 	System.out.println("testGetPartyListAll() list :: "+list);
	 	
	 	totalCount = (Integer)map.get("totalCount");

	 	//==> console 확인
	 	System.out.println("testGetPartyListAll() totalCount :: "+totalCount);
	 }
	
	
	//@Test
	public void testGetPartyListByPastCondition() throws Exception{
		 
	 	Search search = new Search();
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	search.setSearchCondition("3");
	 	search.setSearchKeyword("할로윈");
	 	
	 	
	 	Map<String,Object> map = partyService.getPartyList(search);
	 	
	 	List<Object> list = (List<Object>)map.get("list");
	 	Assert.assertEquals(2, list.size());
	 	
		//==> console 확인
	 	System.out.println("testGetPartyListAll() list :: "+list);
	 	
	 	Integer totalCount = (Integer)map.get("totalCount");
	 	
	 	//==> console 확인
	 	System.out.println("testGetPartyListAll() totalCount :: "+totalCount);
	 	
	 	System.out.println("=======================================");
	 	
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	search.setSearchCondition("3");
	 	search.setSearchKeyword(""+System.currentTimeMillis());
	 	map = partyService.getPartyList(search);
	 	
	 	list = (List<Object>)map.get("list");
	 	Assert.assertEquals(2, list.size());
	 	
	 	//==> console 확인
	 	System.out.println("testGetPartyListAll() list :: "+list);
	 	
	 	totalCount = (Integer)map.get("totalCount");

	 	//==> console 확인
	 	System.out.println("testGetPartyListAll() totalCount :: "+totalCount);
	 }
	
	
	//@Test
	public void testGetPartyListByCurrentCondition() throws Exception{
		 
	 	Search search = new Search();
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	search.setSearchCondition("4");
	 	search.setSearchKeyword("할로윈");
	 	
	 	
	 	Map<String,Object> map = partyService.getPartyList(search);
	 	
	 	List<Object> list = (List<Object>)map.get("list");
	 	Assert.assertEquals(0, list.size());
	 	
		//==> console 확인
	 	System.out.println("testGetPartyListAll() list :: "+list);
	 	
	 	Integer totalCount = (Integer)map.get("totalCount");
	 	
	 	//==> console 확인
	 	System.out.println("testGetPartyListAll() totalCount :: "+totalCount);
	 	
	 	System.out.println("=======================================");
	 	
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	search.setSearchCondition("4");
	 	search.setSearchKeyword(""+System.currentTimeMillis());
	 	map = partyService.getPartyList(search);
	 	
	 	list = (List<Object>)map.get("list");
	 	Assert.assertEquals(0, list.size());
	 	
	 	//==> console 확인
	 	System.out.println("testGetPartyListAll() list :: "+list);
	 	
	 	totalCount = (Integer)map.get("totalCount");

	 	//==> console 확인
	 	System.out.println("testGetPartyListAll() totalCount :: "+totalCount);
	 }
	
	
	//@Test
	public void testJoinParty() throws Exception {
		
		PartyMember partyMember = new PartyMember();
		Party party = new Party();
		User user = new User();
		Search search = new Search();
		
		search.setCurrentPage(1);
	 	search.setPageSize(3);
		
		party.setPartyNo(10000);
		
		user.setUserId("user03@naver.com");
		
		partyMember.setParty(party);
		partyMember.setUser(user);
		partyMember.setRole("guest");
		partyMember.setAge(27);
		partyMember.setGender("m");
		
		partyService.joinParty(partyMember);
		Map<String, Object> map = partyService.getPartyMemberList(10000, search);
		
		List<Object> list = (List<Object>)map.get("list");
		Assert.assertEquals(3, list.size());
		
		//==> console 확인
	 	System.out.println("testGetJoinParty() list :: "+list);
	 	
	}
	
	
	//@Test
	public void testGetPartyMemberList() throws Exception {
		
		Search search = new Search();
	 	//search.setCurrentPage(1);
	 	//search.setPageSize(3);
	 	//search.setSearchKeyword("쎄리");
	 	
		
		Map<String,Object> map = partyService.getPartyMemberList(10000, search);
	
		List<Object> list = (List<Object>)map.get("list");
	 	Assert.assertEquals(3, list.size());
	 	
		//==> console 확인
	 	System.out.println("testGetPartyMemberList() list :: "+list);
	 	
	 	Integer currentMemberCount = (Integer)map.get("currentMemberCount");
	 	
	 	//==> console 확인
	 	System.out.println("testGetPartyMemberList() currentMemberCount :: "+currentMemberCount);
	}
	
	
	//@Test
	public void testCancelParty() throws Exception {
		
		int partyNo = 10000;
		String userId = "user02@naver.com";
		
		Search search = new Search();
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	
		partyService.cancelParty(partyNo, userId);
		Map<String,Object> map = partyService.getPartyMemberList(partyNo, search);
		
		List<Object> list = (List<Object>)map.get("list");
	 	Assert.assertEquals(1, list.size());
		
	}
	
	
	//@Test
	public void testGetGenderRatio() throws Exception {
		
		int partyNo = 10000;
		
		Party party = partyService.getGenderRatio(partyNo);
		
		//==> console 확인
	 	System.out.println("testGetGenderRatio() party :: "+party);
	}
	
	@Test
	public void testGetMyPartyList() throws Exception {
		
		String userId = ("user01@naver.com");
		
		Search search = new Search();
		search.setSearchCondition("");
		search.setSearchKeyword("");
		search.setCurrentPage(1);
		search.setPageSize(3);
		
		Map<String, Object> map = partyService.getMyPartyList(search, userId);
		
		//==> console 확인
	 	System.out.println("testGetMyPartyList() list :: "+map.get("list"));
	 	System.out.println("testGetMyPartyList() totalCount :: "+map.get("totalCount"));
	}
}

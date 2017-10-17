package com.codebrew.moana.test.party;

import java.sql.Date;
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

	//@Test
	public void testGetParty() throws Exception {
		
		Party party = new Party();
		
		party = partyService.getParty(10000);
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
		
		party = partyService.getParty(10000);

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
		party = partyService.getParty(10000);
		
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
		party = partyService.getParty(partyNo);
		
		//==> console 확인
		System.out.println("testDeleteParty() party :: "+party);
		
		//==> API 확인
		Assert.assertEquals("del", party.getDeleteFlag());
		
	}
	
	
	@Test
	public void testGetPartyListAll() throws Exception{
		 
	 	/*Search search = new Search();
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	
	 	Map<String,Object> map = partyService.getPartyList(search);
	 	
	 	List<Object> list = (List<Object>)map.get("list");
	 	Assert.assertEquals(3, list.size());
	 	
		//==> console 확인
	 	System.out.println(list);
	 	
	 	Integer totalCount = (Integer)map.get("totalCount");
	 	System.out.println(totalCount);
	 	
	 	System.out.println("=======================================");
	 	
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	search.setSearchCondition("0");
	 	search.setSearchKeyword("");
	 	map = partyService.getPartyList(search);
	 	
	 	list = (List<Object>)map.get("list");
	 	Assert.assertEquals(3, list.size());
	 	
	 	//==> console 확인
	 	System.out.println(list);*/
	 	
	 	/*totalCount = (Integer)map.get("totalCount");
	 	System.out.println(totalCount);*/
	 }
}

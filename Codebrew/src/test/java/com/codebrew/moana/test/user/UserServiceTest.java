package com.codebrew.moana.test.user;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import org.codehaus.jackson.JsonNode;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.User;
import com.codebrew.moana.service.user.UserService;

import junit.framework.Assert;

/*
 *	FileName :  UserServiceTest.java
 * ㅇ JUnit4 (Test Framework) 과 Spring Framework 통합 Test( Unit Test)
 * ㅇ Spring 은 JUnit 4를 위한 지원 클래스를 통해 스프링 기반 통합 테스트 코드를 작성 할 수 있다.
 * ㅇ @RunWith : Meta-data 를 통한 wiring(생성,DI) 할 객체 구현체 지정
 * ㅇ @ContextConfiguration : Meta-data location 지정
 * ㅇ @Test : 테스트 실행 소스 지정
 */

@RunWith(SpringJUnit4ClassRunner.class)

// ==> Meta-Data 를 다양하게 Wiring 하자...
@ContextConfiguration(locations = { "classpath:config/context-common.xml", "classpath:config/context-aspect.xml",
		"classpath:config/context-mybatis.xml", "classpath:config/context-transaction.xml" })

public class UserServiceTest {

	// ==>@RunWith,@ContextConfiguration 이용 Wiring, Test 할 instance DI
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;

	
	//@Test //회원가입
	public void testAddUser() throws Exception {

		User user = new User();
		user.setUserId("user19@naver.com");
		user.setUserName("임주완");
		user.setPassword("1111");
		//user.setProfileImage("b1234.jpg");
		user.setPhone("01045678394");
		user.setGender("m");
		user.setAge(28);
		//user.setLocationFlag("y");
		user.setNickname("주완");
		// SimpleDateFormat format=new SimpleDateFormat("yyyy/mm/dd");
		// user.setRegDate(format.parse("20171011"));
		user.setCoconutCount(10);

		userService.addUser(user);

		user = userService.getUser("user19@naver.com");

		System.out.println(user);

		Assert.assertEquals("user19@naver.com", user.getUserId());
		Assert.assertEquals("임주완", user.getUserName());
		Assert.assertEquals("1111", user.getPassword());
		Assert.assertEquals("default_profile_image.jpg", user.getProfileImage());
		Assert.assertEquals("u", user.getRole());
		Assert.assertEquals("01045678394", user.getPhone());
		Assert.assertEquals("m", user.getGender());
		// Assert.assertEquals("codebrew@naver.com", user.getBirth());
		Assert.assertEquals(28, user.getAge());
		Assert.assertEquals("n", user.getLocationFlag());
		Assert.assertEquals("주완", user.getNickname());
		Assert.assertEquals(Date.valueOf("2017-10-16"), user.getRegDate());
		Assert.assertEquals(10, user.getCoconutCount());

	}

	//@Test //회원정보 조회-완료
	public void testGetUser() throws Exception {

		User user = new User();
		user = userService.getUser("user02@naver.com");

		System.out.println(user);

		Assert.assertEquals("user02@naver.com", user.getUserId());
		Assert.assertEquals("임가정", user.getUserName());
		Assert.assertEquals("1111", user.getPassword());
		Assert.assertEquals("b1234.jpg", user.getProfileImage());
		Assert.assertEquals("d", user.getRole());
		Assert.assertEquals("01045678394", user.getPhone());
		Assert.assertEquals("f", user.getGender());
		Assert.assertEquals(25, user.getAge());
		Assert.assertEquals("y", user.getLocationFlag());
		Assert.assertEquals("까정", user.getNickname());
		Assert.assertEquals(Date.valueOf("2017-10-12"),user.getRegDate());
		Assert.assertEquals(10, user.getCoconutCount());

		Assert.assertNotNull(userService.getUser("user02@naver.com"));
	
	}
	
	//@Test //탈퇴한 회원은 안불러오기
    public void testGetUserNotInDeleteUser() throws Exception {

			User user = new User();
			user = userService.getUser("user01@naver.com");

			System.out.println(user);
	
			Assert.assertNull("값이 안와야 합니다.",userService.getUser("user01@naver.com"));
	}

	
     //@Test // 회원정보 수정,-완료
	public void testUpdateUser() throws Exception {

		//User user = new User();

		User user = userService.getUser("codebrew@naver.com");
		
        //도메인에 담고
		user.setPassword("1111");
		user.setProfileImage("a1324.jpg");
		user.setPhone("01023022349");
		user.setLocationFlag("y");
		user.setNickname("냉동버섯");
		user.setCoconutCount(13);
        
		//업데이트 시킴
		userService.updateUser(user);
		
		user=userService.getUser("codebrew@naver.com");
		
		
		Assert.assertEquals("1111", user.getPassword());
		Assert.assertEquals("a1324.jpg", user.getProfileImage());
		Assert.assertEquals("01023022349", user.getPhone());
		Assert.assertEquals("y", user.getLocationFlag());
		Assert.assertEquals("냉동버섯", user.getNickname());
		Assert.assertEquals(13, user.getCoconutCount());
		
		Assert.assertNotNull("널값이 들어오면 안됩니다. ", user);

	}
	
	
   // @Test //회원리스트-완료
	public void testGetUserList() throws Exception {
		
		Search search=new Search();//controller없으니깐 인스턴스로..
		search.setCurrentPage(1);//현재페이지
		search.setPageSize(3);//한페이지당 보여지는 게시물 수
		
		
		Map<String,Object>map=userService.getUserList(search);
		
		List<Object> list=(List<Object>)map.get("list");
		Assert.assertEquals(3, list.size());
		
		int totalCount=(Integer)map.get("totalCount");//총게시물수
		
		System.out.println(list);
		
		System.out.println(totalCount);
		
	}
		
	//@Test //userId로 리스트 뽑기 테스트
	public void TestGetUserListByUserId() throws Exception{
		
		Search search=new Search();
		search.setCurrentPage(1);//현재페이지
		search.setPageSize(3);//한페이지당 보여지는 게시물 수
		search.setSearchCondition("1");//1: 회원아이디, 2:닉네임
		search.setSearchKeyword("codebrew@naver.com");
		
		Map<String,Object>map=userService.getUserList(search);
		
		List<Object> list=(List<Object>)map.get("list");
		Assert.assertEquals(1, list.size());
		
		int totalCount=(Integer)map.get("totalCount");//총게시물수
		
		System.out.println(list);
		
		System.out.println(totalCount);
		
	}
	
	//@Test //nickname으로 리스트 뽑기 테스트
    public void TestGetUserListByNickname() throws Exception{
			
			Search search=new Search();
			search.setCurrentPage(1);//현재페이지
			search.setPageSize(3);//한페이지당 보여지는 게시물 수
			search.setSearchCondition("2");//1: 회원아이디, 2:닉네임
			search.setSearchKeyword("냉동버섯");
			
			Map<String,Object>map=userService.getUserList(search);
			
			List<Object> list=(List<Object>)map.get("list");
			Assert.assertEquals(1, list.size());
			
			int totalCount=(Integer)map.get("totalCount");//총게시물수
			
			System.out.println(list);
			
			System.out.println(totalCount);
			
		}	


	//@Test// 회원탈퇴-완료
	public void deleteUser() throws Exception {
		
		User user=new User();
		
		user=userService.getUser("user03@naver.com");
		
		userService.deleteUser(user);
		
		user=userService.getUser("user03@naver.com");
		
		Assert.assertEquals("d", user.getRole());
		
	}

	//@Test// 닉네임 중복체크-완료
	public void TestCheckNickname() throws Exception {
	    // User user=new User();
	     
		
	     boolean result=userService.checkNickname("해동버섯");
	     //리턴값이 result
	     
	     //Assert.assertFalse(userService.checkNickname("해동버섯"));
	     Assert.assertFalse("존재하는 닉네임입니다", userService.checkNickname("해동버섯"));
	
	}

	//@Test// 아이디 중복체크-완료
	public void checkUserId() throws Exception {
	
		boolean result=userService.checkUserId("codebrew@naver.com");
	
		Assert.assertFalse("존재하는 아이디입니다",userService.checkUserId("codebrew@naver.com"));
	}

	//@Test// 아이디찾기-완료
	public void TestFindUserId() throws Exception {
		
	
	   User user=new User();
	   
	   user.setUserName("이주영");
	   user.setPhone("01091242349");
	   

	   user=userService.findUserId(user);
	  
	   
	   Assert.assertEquals("codebrew@naver.com",user.getUserId());
	   //Assert.assertEquals("codebrew@naver.com",userService.findUserId(user));
	   //이렇게 하면 domain.User cannot be cast to java.lang.String
	  //public String findUserId(User user) throws Exception { xxx
	   //<resultMap="userSelectMap"> resultMap으로 받겠다고 지정해놓고 String으로 받아서 생긴 에러였음
	  //User 타입으로 받아서  userId를 꺼냄
	}

	//@Test// 비밀번호찾기, 인증번호-완료
	/*public void TestRandomNumber() throws Exception {
		
		String uuid=userService.randomNumber(5);
		
		System.out.println(uuid);
		
		Assert.assertNotNull("값이 들어왔습니다.", userService.randomNumber(5));
	}
*/
	//@Test //카카오에서 정보 받아오기
	public void TestGetCode()throws Exception{
		
		User user=new User();
		
		user=userService.getCode("D4N5guftedco6F8irx-uun5bd6pKB0xFyzMcGQo8BVUAAAFfUvilDQ");
		
		System.out.println(user);
		
		 Assert.assertEquals("howto_love@naver.com",user.getUserId());
		 Assert.assertEquals("이주영",user.getUserName());
		 Assert.assertEquals(31,user.getAge());
		 Assert.assertEquals("f",user.getGender());
	}
	
	@Test //코코넛 수량 업데이트
	public void TestUpdateCoconut() throws Exception{
		
		User user= new User();
		
		user=userService.getUser("codebrew@naver.com");
		user.setCoconutCount(13);

		userService.updateCoconut(user);
		
		user=userService.getUser("codebrew@naver.com");
		
		Assert.assertEquals(13, user.getCoconutCount());
	}
}
package com.codebrew.moana.test.follow;

import java.util.List;
import java.util.Map;

import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.codebrew.moana.common.Search;
import com.codebrew.moana.service.domain.Follow;
import com.codebrew.moana.service.domain.User;
import com.codebrew.moana.service.follow.FollowService;

import junit.framework.Assert;

@RunWith(SpringJUnit4ClassRunner.class)

@ContextConfiguration(locations = { "classpath:config/context-common.xml", "classpath:config/context-aspect.xml",
		"classpath:config/context-mybatis.xml", "classpath:config/context-transaction.xml" })


public class FollowServiceTest {
	
	@Autowired
	@Qualifier("followServiceImpl")
	private FollowService followService;
	
	
	public void testAddFollow() throws Exception{
		User user=new User();
		user.setUserId("user07@naver.com");
		
		User user1=new User();
		user1.setUserId("user08@naver.com");
		
		
		followService.addFollow(user.getUserId(), user1.getUserId());
		
		Follow follow=followService.getFollow(user.getUserId(), user1.getUserId());
		
		System.out.println(follow);
		

		
	}
	
	
	public void testDeleteFollow() throws Exception{
		User user=new User();
		user.setUserId("user07@naver.com");
		
		User user1=new User();
		user1.setUserId("user08@naver.com");
		
		
		followService.deleteFollow(user.getUserId(), user1.getUserId());
		
		Follow follow=followService.getFollow(user.getUserId(), user1.getUserId());
		
		System.out.println(follow);
		
	}
	
	
	public void testGetFollow() throws Exception{
		
		User user=new User();
		user.setUserId("user07@naver.com");
		
		User user1=new User();
		user1.setUserId("user08@naver.com");
		
		
        Follow follow=followService.getFollow(user.getUserId(), user1.getUserId());
		
		System.out.println(follow);
		
		
	}
	
	
	public void testGetFollowingList() throws Exception{
		
		Search search=new Search();
		
		
		User user=new User();
		user.setUserId("user07@naver.com");
		
		Map<String, Object>map=followService.getFollowingList(search, user.getUserId());
		
		
		List<Object>list=(List<Object>)map.get("list");
		
		Assert.assertEquals(1, list.size());
		
		int totalCount=(Integer)map.get("totalCount");
		
		
		System.out.println(list);
		
		System.out.println(totalCount);
		
	}
	
	
	public void testGetFollowerList() throws Exception{
		
Search search=new Search();
		
		
		User user=new User();
		user.setUserId("user07@naver.com");
		
		Map<String, Object>map=followService.getFollowingList(search, user.getUserId());
		
		
		List<Object>list=(List<Object>)map.get("list");
		
		Assert.assertEquals(1, list.size());
		
		int totalCount=(Integer)map.get("totalCount");
		
		
		System.out.println(list);
		
		System.out.println(totalCount);
		
	}
	
	
	

}

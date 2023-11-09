package com.service;

import java.util.HashMap;
import java.util.concurrent.TimeUnit;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import com.config.RedisConfig;

@Service
public class TestServiceImpl {
	
	@Autowired
	private RedisConfig redis;
	
	public String test(String userID, String auth_key) {
		RedisTemplate<String, Object> redisTemplate = redis.getRedisTemplate();
		
		/* 테스트
		// 데이터 저장
		HashMap<String, Object> dateMap = new HashMap<String, Object>();
		
		dateMap.put("email", "aaa@abc.co.kr");
		dateMap.put("mobile", "12341234");
		redisTemplate.opsForHash().putAll("userInfo", dateMap);
		redisTemplate.opsForValue().set("banana", "yellow", 1, TimeUnit.MINUTES); // 1분 유효시간
		redisTemplate.delete("userInfo"); // key값으로 delete
		
		
		// 데이터 조회
		String email = (String) redisTemplate.opsForHash().get("userInfo", "email");
		String mobile = (String) redisTemplate.opsForHash().get("userInfo", "mobile");
		String banana = (String) redisTemplate.opsForValue().get("banana");
		
		System.out.println(email);
		System.out.println(mobile);
		System.out.println(banana);
		*/
		
		/* 테스트2 - userid값 받아서 메일 인증 키값 저장하기*/
		redisTemplate.opsForValue().set(userID, auth_key, 15, TimeUnit.SECONDS);
		
		return (String) redisTemplate.opsForValue().get(userID);
		
		
	}
}

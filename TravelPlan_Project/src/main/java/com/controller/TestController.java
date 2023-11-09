package com.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.service.TestServiceImpl;

@Controller
public class TestController {

	@Autowired
	TestServiceImpl service;
	
	@GetMapping("/test")
	public String test() {
//		System.out.println(service.test("test", "gleisdlkfj"));
//		System.out.println(service.test("aaa", "asliejgkds"));
		
		service.test("test", "aaaaa");
		return "test";
	}
}

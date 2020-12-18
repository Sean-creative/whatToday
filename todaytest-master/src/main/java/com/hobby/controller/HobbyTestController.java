package com.hobby.controller;

import java.util.Map;

import org.json.simple.JSONArray;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hobby.service.TestService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

/**
 * 취미 추천 테스트 페이지 관리
 * @author jiyeong
 *
 */
@Controller
@Log4j
@RequestMapping("/hobbyTest/*")
@AllArgsConstructor
public class HobbyTestController {
	
	private TestService service;
	
	@GetMapping("/test")
	public void getTest1Result() {
		log.info("###/test");
	}
	
	@ResponseBody
	@RequestMapping(value = "/testResult", produces="application/json")
	public JSONArray testResult(@RequestBody Map<String, String> map) {
		log.info("###/testResult");

		String test1Result = map.get("test1Result");
		String test2Result = map.get("test2Result");
		String test3Result = map.get("test3Result");

		String userResult = test1Result+test2Result+test3Result;
		
		JSONArray getResult = service.getTestResult(userResult);
		System.out.println("결과: " + getResult);
		
		//localhost:8080/regular/list?category=아웃도어%2F여행&subclass=캠핑%2F백패킹
		
		return getResult;
	}
}

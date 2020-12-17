package com.hobby.service;

import java.util.Map;

import org.json.simple.JSONArray;

/**
 * 사용자 취미 테스트 결과를 알려주는 서비스 인터페이스
 * @author jiyeong
 *
 */
public interface TestService {
	public JSONArray getTestResult(String userResult);
}

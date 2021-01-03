package com.hobby.service;

import java.util.HashMap;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Service;

import com.google.gson.JsonObject;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class TestServiceImpl implements TestService{

	@Override
	public JSONArray getTestResult(String userResult) {
		// 나중에 test여러 개 넣어놓고 db에서 가져오기
//		"아웃도어/여행" : ["등산","산책/트래킹","캠핑/백패킹","낚시","기타"],
//		"문화/공연/축제" : ["뮤지컬/오페라", "공연/연극", "전시회", "파티/페스티벌", "기타"],
//		"운동/스포츠" : ["자전거", "배드민턴", "볼링", "헬스/크로스핏", "탁구", "당구/포켓볼", "축구/풋살", "농구", "야구", "스케이트/인라인", "기타"],
//		"음악/악기" : ["노래/보컬", "기타/베이스", "피아노", "랩/힙합/DJ", "클래식", "기타"],
//		"외국/언어" : ["영어", "일본어", "중국어", "프랑스어", "스페인어", "러시아어", "기타"],
//		"게임/오락" : ["다트", "보드게임", "온라인게임", "마술", "바둑", "기타"],
//		"기타" : ["기타"]
		
		switch (userResult) {	
		case "YYY":
			//"캠핑/백패킹,파티/페스티벌,배드민턴"
			return createJsonArr("아웃도어/여행", "낚시", "문화/공연/축제", "파티/페스티벌", "운동/스포츠", "배드민턴");
// 			return "캠핑/백패킹,파티/페스티벌,배드민턴";
		case "YYN":	
			return createJsonArr("아웃도어/여행", "등산", "운동/스포츠", "축구/풋살", "아웃도어/여행", "낚시");
//			return "등산,축구/풋살,낚시";
		case "YNY":
			return createJsonArr("외국/언어", "러시아어", "게임/오락", "보드게임", "음악/악기", "랩/힙합/DJ");
//			return "러시아어,보드게임,랩/힙합/DJ";
		case "YNN":
			return createJsonArr("운동/스포츠", "볼링", "게임/오락", "다트", "외국/언어", "영어");
//			return "볼링,다트,영어";
		case "NYY":
			return createJsonArr("아웃도어/여행", "캠핑/백패킹 ", "운동/스포츠", "자전거", "문화/공연/축제", "전시회");
//			return "낚시,자전거,전시회";
		case "NYN":
			return createJsonArr("아웃도어/여행", "산책/트래킹", "운동/스포츠", "스케이트/인라인", "문화/공연/축제", "공연/연극");
//			return "산책/트래킹,스케이트/인라인,공연/연극";
		case "NNY":
			return createJsonArr("외국/언어", "프랑스어", "게임/오락", "온라인게임", "문화/공연/축제", "뮤지컬/오페라");
//			return "프랑스어,온라인게임,뮤지컬/오페라";
		case "NNN":
			return createJsonArr("음악/악기", "클래식", "운동/스포츠", "헬스/크로스핏", "외국/언어", "중국어");
//			return "클래식,헬스/크로스핏,중국어";
		}
		return null;
	}
	
	public JSONArray createJsonArr(String cat1, String sub1, String cat2, String sub2, String cat3, String sub3 ) {
		JSONObject json1 = new JSONObject();
		JSONObject json2 = new JSONObject();
		JSONObject json3 = new JSONObject();
		
		JSONArray jsonArr = new JSONArray();
		
		json1.put("category", cat1);
		json1.put("subclass", sub1);
		
		json2.put("category", cat2);
		json2.put("subclass", sub2);
		
		json3.put("category", cat3);
		json3.put("subclass", sub3);
		
		jsonArr.add(json1);
		jsonArr.add(json2);
		jsonArr.add(json3);
		
		return jsonArr;
	}
}

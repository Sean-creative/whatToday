package com.hobby.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class FaqVO {
//---------------fap--------//
	//자/주/묻/는/질/문// 
	private Long faqNum;
	//회/원/구/분//
	private Long faqClassification;
	//제/목//
	private String faqTitle;
	
	//자/주/묻/는/질/문 /답//
	private String faqContent;
	
//------------공지사항 ----------//	
	//공지사항 읽어오기
	//공지사항번호 
	private Long ntNum;
	//회원구분
	private Long ntUsrClassification;
	//제목
	private String ntTitle ;
	//날짜 
	private String ntDate;
	
	//---------내용-------//
	private String ntContent;
}
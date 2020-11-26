package com.hobby.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class FaqVO {
	//자/주/묻/는/질/문// 
	private Long faqNum;
	//회/원/구/분//
	private Long faqClassification;
	//제/목//
	private String faqTitle;
	
	//자/주/묻/는/질/문 /답//
	private String faqContent;
		
}
package com.hobby.domain;

import lombok.Data;

@Data
public class FaqVO {
	//자/주/묻/는/질/문// 
	
	private Long faqNum;
	private Long faqClassification;
	private String faqTitle;

	//자/주/묻/는/질/문 /답//
	private String faqContent;
}

package com.hobby.domain;

import lombok.Data;

@Data
public class FaqVO {
	//자주묻는질문 
	private Long faqNum;
	private Long faqClassification;
	private String faqTitle;

	//자주묻는질문 답
	private String faqContent;
}

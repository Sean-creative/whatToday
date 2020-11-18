package com.hobby.domain;

import lombok.Data;

@Data
public class MainVO {
	
	//모임번호 
	private Long cbNum;
	
	//모임명 	
	private String cbName;
	
	//모임유형 
	private String cbType;
	
	//지역 
	private String cbCity;
	
	//정원 
	private Long cbMbNum;
	
	//현재인원 
	private Long cbCurMbNum;
	
	//첨부파일 
	private String cbFile;
}

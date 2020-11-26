package com.hobby.domain;

import lombok.Data;

@Data
public class InquireVO {
	////// 일/대/일/ //////
	//문의번호 
	private Long qsNum;
	//회원번호 
	private Long usrNum;
	//이메일 
	private String qsEmail;
	//이름
	private String qsName;
	//연락처
	private String qsPhone;
	//제목
	private String qsTitle;
	
	
	//////일/대/일/내/용  //////
	//내용 
	private String qsContent;
	//첨부파일 
	private String qsFile;

}
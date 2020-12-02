package com.hobby.domain;

import lombok.Data;

@Data
public class NoticeVO {
	//------------공지사항 ----------//	
		//공지사항번호 
		private Long ntNum;
		//회원구분
		private Long ntUsrClassification;
		//제목
		private String ntTitle ;
		//날짜 
		private String ntDate;
		
		//---------공지사항 내용-------//
		private String ntContent;
}

package com.hobby.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ClubVO {
	
	//CLUB/////////////////////////////////////////////////////////////
	
	//모임번호
	private Long cbNum;
	//모임명
	private String cbName;
	//모임유형
	private String cbType;
	//개설자 번호
	private Long cbLeaderNum;
	//개설자명
	private String cbLeaderName;
	//카테고리/분야
	private String cbCategory;
	//소분류
	private String cbSubcat;
	//지역
	private String cbCity;
	//세부지역
	private String cbDistrict;
	//정원
	private Long cbMbNum;
	//현재인원
	private Long cbCurMbNum;
	//해시태그
	private String cbHashtag;
	//한줄소개
	private String cbIntro;
	//개설일
	private Date cbMakeDate;
	//폐쇄일
	private Date cbShutDate;
	//모임최종상태
	private String cbFinalState;
	//모임상세내용
	private String cbDetailContent;
	//첨부파일
	private String cbFile;
	
	//CLUBBOARD////////////////////////////////////////////////////////
	
	//게시판 번호
	private Long cbBno;
	//작성자
	private String cbBdWriter;
	//제목
	private String cbBdTitle;
	//작성일
	private Date cbBdDate;
	//조회수 
	private Long cbBdView;
	
	//CLUBBOARDCONTENT/////////////////////////////////////////////////
	
	//게시글 내용 
	private String cbBdContent;
	
}

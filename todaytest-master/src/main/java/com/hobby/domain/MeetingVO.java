package com.hobby.domain;

/**
 * 작성자: 김선우
 */
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MeetingVO {

	// 필수값!
	// 모임번호
	private Long cbNum;
	
	// 만남번호
	private Long mtNum;
	
	// 모임명
	private String cbName;

	// 만남명
	private String mtName;
	
	// 만남날짜 및 시간
	private String mtStartDate;
	
	// 만남 종료 시간
	private String mtEndDate;
	
	// 모집 인원
	private Long mtMbNum;
	
	// 현재 인원 수
	private Long mtCurMbNum;
	
	// 만남지역
	private String mtAddress;
	
	// 만남장소
	private String mtPlace;
	
	// 만남 준비물 
	private String mtSupplies;
	
	// 만남 소개
	private String mtIntro;
	
	// 만남 개설일
	private String mtMakeDate;
	
	//만남 최종상태
	private String mtFinalState;
	
	
	// 로그인 유저의 해당 만남에 대한 상태정보
	// DB에는 없는 속성이다.
	private String usrMtState;
}


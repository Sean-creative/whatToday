package com.hobby.domain;
/**
 * 작성자: 김선우
 */
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;


@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ThunderDetailVO {

	// ClubVO의 상세내역을 담고 있는 객체이다.
	// ClubVO와 중복된 내용은 없다.
	// DB 컬럼 수정 완료   -- 2020/11/17
	
	//THUNDERDETAIL 테이블
	
	//모임번호(기본키)
	private long cbNum;
	
	// 모임유형
	private String cbType;
		
	//모임날짜
	private String cbDate;
	
	//모임 신청기간 날짜
	private String cbAppPeriod;
	
	//모임 장소
	private String cbPlace;
	
	//모임 준비물
	private String cbSupplies;
	
}

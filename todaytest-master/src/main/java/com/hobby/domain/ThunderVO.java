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
@Builder
public class ThunderVO {

	// DB 컬럼 수정 완료 -- 2020/11/17
	// DB 속성 -> 총 18개
	
	//CLUB 테이블

	// 필수값!
	// 모임번호
	private Long cbNum;

	// 모임명
	private String cbName;

	// 모임소개
	private String cbIntro;

	// 카테고리-분야
	private String cbCategory;

	// 소분류
	private String cbSubcat;

	// 정원
	private Long cbMbnum;

	// 해시태그
	private String cbHashtag;
	// 지역
	private String cbCity;
	// 세부지역
	private String cbDistrict;

	// 개설자 번호
	private Long cbLeaderNum;

	// 현재인원
	private Long cbCurMbnum;

	// 개설자명
	private String cbLeaderName;
	// 개설일
	private String cbMakeDate;
	// 폐쇄일
	private String cbShutDate;
	// 모임유형
	private String cbType;
	// 모임최종상태
	private String cbFinalState;

	// new
	// 모임상세내용
	private String cbDetailContent;

	// 첨부파일
	private String cbFile;
	
	//썸네일
	private String cbThumbImg;

	// 모임상세테이블
	private ThunderDetailVO thunderDetailVO;

// 	   나중에 builder 쓸 때 참고!
//	 public static ClubVOBuilder builder(int cl_number) {
//         if(cl_number <= 0) {
//             throw new IllegalArgumentException("기본키 부적절");
//         }
//         return clubVOBuilder().cl_number(cl_number);
//     }
}

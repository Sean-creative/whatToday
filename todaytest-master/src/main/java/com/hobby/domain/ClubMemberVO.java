package com.hobby.domain;

/**
 * 작성자: 김선우
 */
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ClubMemberVO {

	// 회원번호
	private Long usrNum;

	// 모임번호
	private Long cbNum;

	// 모임유형
	private String cbType;

	// 모임명
	private String cbName;

	// 회원이름
	private String usrName;	

	// 모임멤버상태결과
	private String cbMbStResult;
	
	// 가입인사
	private String cbMemIntro;
	
	// 가입신청일
	private String cbAppDate;


}

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
public class MeetingMemberVO {

	// 필수값!
	// 모임번호
	private Long cbNum;
	
	// 만남번호
	private Long mtNum;
	
	// 모임명
	private Long usrNum;
		
	// 회원이름
	private String usrName;
	
	// 참석상태
	private String mtAttendState;
	
}

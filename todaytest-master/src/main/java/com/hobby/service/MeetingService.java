package com.hobby.service;
/**
 * 작성자: 김선우
 */
import java.util.List;

import org.springframework.security.core.Authentication;

import com.hobby.domain.ClubMemberVO;
import com.hobby.domain.Criteria;
import com.hobby.domain.MeetingVO;
import com.hobby.domain.ThunderVO;
import com.hobby.domain.UserVO;

public interface MeetingService {
		
	
	public boolean register(MeetingVO meeting);

	
//	public ThunderVO get(long cbNum);
//						
//	//번개모임에 가입하는 메소드
	public boolean attend(MeetingVO meeting, UserVO loginUser, String mtAttendState);
//	
//	//로그인된 유저의 번호로, 지금 참석하려고하는 만남에 가입되어 있는지 상태를 조사
//	//반환값은 mtAttendState
	public String getMtStateByUsrNum(Long usrNum, Long cbNum, Long mtNum);	
	
	//해당 모임에 대한 만남리스트를 가져온다.
	public List<MeetingVO> getMeetingList(Long cbNum);
	
	
	//해당 만남에 대한 정보를 가져온다
	public MeetingVO getMeeting(Long mtNum);	

	public boolean modify(MeetingVO meeting);

	public boolean remove(Long mtNum);
	
	public boolean updateMtCurMbNum(MeetingVO meeting);
	

//	
//	//로그인이 되어있는지 알려주는 메소드
//	public boolean isLogin(Authentication auth);
	
	
	
}

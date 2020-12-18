package com.hobby.mapper;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hobby.domain.MeetingVO;
import com.hobby.domain.UserVO;

public interface MeetingMapper {
		
	public int insert(MeetingVO meeting);	
	
//	public List<ThunderVO> getListWithPaging(Criteria cri);	
	
	//만남에 가입 
	public int insertAttend(@Param("meeting") MeetingVO meeting, @Param("loginUser") UserVO loginUser, @Param("mtAttendState") String mtAttendState);
	
	public int updateAttend(@Param("meeting") MeetingVO meeting, @Param("loginUser") UserVO loginUser, @Param("mtAttendState") String mtAttendState);
	
		
	
	//로그인된 유저의 번호로, 지금 가입하려고하는 모임이 가입되어 있는지 상태를 조사
	//반환값은 mtAttendState
	public String readMtStateByUsrNum(@Param("usrNum") Long usrNum, @Param("cbNum") Long cbNum, @Param("mtNum") Long mtNum);
	
//해당 모임에 대한 만남리스트를 가져온다.
public List<MeetingVO> getMeetingList(Long cbNum);

//해당 만남에 대한 정보를 가져온다
public MeetingVO readMeeting(Long mtNum);			
		
//	public int getTotalCount(Criteria cri);
			
	public int delete(Long mtNum);
	
	public int update(MeetingVO meeting);
	
	public int updateMtOut(@Param("cbNum") Long cbNum, @Param("usrNum") Long usrNum);
	
	
	public int readMtCurMbNum(Long mtNum);
	
	
	
	//모임 클릭 시 조회수 올라감
//	public void clubViews(Long cbNum);
	
}

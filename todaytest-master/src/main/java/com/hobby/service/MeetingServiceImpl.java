package com.hobby.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hobby.domain.MeetingVO;
import com.hobby.domain.UserVO;
import com.hobby.mapper.MeetingMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class MeetingServiceImpl implements MeetingService {

	//Service단에서 log.info가 찍히지 않는다.
	private MeetingMapper mapper;	

	
	@Override
	public boolean register(MeetingVO meeting) {
		System.out.println("register ...." + meeting);		
		
		int result =  mapper.insert(meeting);				
		System.out.println("Service-register..... : " + result);
				
		return result == 1;
	}


	
	
	
//	@Override
//	public List<ThunderVO> getListWithPaging(Criteria cri) {
//
//		return mapper.getListWithPaging(cri);
//	}
//	
//	@Override
//	public ThunderVO get(long cbNum) {
//		log.info("get ...." + cbNum);
//		
//		//모임 클릭 시 조회수 올라감
//		mapper.clubViews(cbNum);
//		return mapper.read(cbNum);
//	}
//
//	
//	@Override
	//해당 모임에 대한 만남리스트를 가져온다.
	public List<MeetingVO> getMeetingList(Long cbNum) {
		System.out.println("MeetingService(getMeetingList) - cbnum: " + cbNum);		
		
		return mapper.getMeetingList(cbNum);
	}





	@Override
	public MeetingVO getMeeting(Long mtNum) {
		System.out.println("MeetingService(getMeeting) - mtNum: " + mtNum);
		
		return mapper.readMeeting(mtNum);
	}

	

	@Override
	public boolean modify(MeetingVO meeting) {
		log.info("MeetingService(modify) - meeting: " + meeting);		
		return mapper.update(meeting) == 1;
	}
	

	@Override
	public boolean remove(Long mtNum) {
		log.info("remove...." + mtNum);
		return mapper.delete(mtNum) == 1;
	}



	@Override
	@Transactional
	public boolean attend(MeetingVO meeting, UserVO loginUser, String mtAttendState) {
		System.out.println("Service-join......" + meeting);
		System.out.println("Service-join......" + loginUser);
		System.out.println("Service-join......" + mtAttendState);		
		
		//우선적으로는 Service.attend 쪽 갔을때만 -> 인원수 변동시켜주자!!!
			    	
	    //신청하기or신청취소하기 버튼을 눌렀으면 여기서 케이스를 나눠서 Mapper 메소드를 실행한다.	
	    //mtAttendState - 참석중, 미참석, Null("")
		
		int result = 0;
		String chagneAttendState = null;
		
		//버튼을 눌렀을 떄 회원의 상태에 따라 달라졌을 것이다.
		if( "".equals(mtAttendState) || mtAttendState == null) {
	    	//null일 때 -> 참석중이 되어야 함
			chagneAttendState = "참석중";
			meeting.setMtCurMbNum(meeting.getMtCurMbNum()+1);
			
			result += mapper.insertAttend(meeting, loginUser, chagneAttendState);			
	    }
		else if(mtAttendState.equals("참석중")) {
			//'참석중'일 때 -> 미참석 되어야 함
			chagneAttendState = "미참석";
			meeting.setMtCurMbNum(meeting.getMtCurMbNum()-1);
			
			result += mapper.updateAttend(meeting, loginUser, chagneAttendState);			
		} 
		else if(mtAttendState.equals("미참석") || mtAttendState.equals("모임탈퇴")) {			
	    	//'미참석'일 때 -> "참석중"
			chagneAttendState = "참석중";
			meeting.setMtCurMbNum(meeting.getMtCurMbNum()+1);
			
			result += mapper.updateAttend(meeting, loginUser, chagneAttendState);			
	    }
	   
	    
		// 멤버상태를 변경해주고 나서는, meeting의 현재인원을 update해준다.		
		result += mapper.update(meeting); 	    		
		System.out.println("result : " + result);
					
		return result == 2;
	}
	
	

	
	
	
	@Override
	public String getMtStateByUsrNum(Long usrNum, Long cbNum, Long mtNum) {
		System.out.println("MeetingServiceImpl - usrNUm : " + usrNum);
		System.out.println("MeetingServiceImpl - cbNum : " + cbNum);
		System.out.println("MeetingServiceImpl - mtNum : " + mtNum);
		
		
		return mapper.readMtStateByUsrNum(usrNum, cbNum, mtNum);
	}





	@Override
	public boolean updateMtCurMbNum(MeetingVO meeting) {

		int mtCurMbNum = mapper.readMtCurMbNum(meeting.getMtNum());
		meeting.setMtCurMbNum((long)mtCurMbNum);
		
		int result = mapper.update(meeting);			
		return result == 1;
	}

	



}

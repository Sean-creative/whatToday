package com.hobby.service;

import org.springframework.stereotype.Service;

import com.hobby.domain.MeetingVO;
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
//	public List<ClubMemberVO> getJoinList(Long cbnum, String cbmbstresult) {		
//		System.out.println("Service-getJoinHashMap......cbnum: " + cbnum);
//		System.out.println("Service-getJoinHashMap......cbmbstresult: " + cbmbstresult);
//		
//		return mapper.getJoinList(cbnum, cbmbstresult);
//	}
//
//	
//	
//	
//	
//
//	@Override
//	public boolean modify(ThunderVO club) {
//		log.info("modify...." + club);		
//		return mapper.update(club) == 1;
//
//	}
//
//	@Override
//	public boolean remove(long cbNum) {
//		log.info("remove...." + cbNum);
//		return mapper.delete(cbNum) == 1;
//	}
//
//	@Override
//	public int getTotal(Criteria cri) {
//		log.info("get total count");
//		return mapper.getTotalCount(cri);
//	}
//
//	@Override
//	public boolean isLogin(Authentication auth) {
//		log.info("is login.....");
//		if (auth == null)
//			return false;
//		return true;
//	}
//
//	
//	
//	
//	@Override
//	@Transactional
//	public boolean join(ThunderVO clubVO, UserVO loginUser, String joinState) {
//		System.out.println("Service-join......" + clubVO);
//		System.out.println("Service-join......" + loginUser);
//		System.out.println("Service-join......" + joinState);		
//		
//		//우선적으로는 Service.join 쪽 갔을때만 -> 인원수 변동시켜주자!!!
//			    	
//	    //신청하기or신청취소하기 버튼을 눌렀으면 여기서 케이스를 나눠서 Mapper 메소드를 실행한다.
//	    //joinState - 모임추방, 모임만료, 모임탈퇴, 가입승인, Null (아직 데이터 넣기 전)
//		
//		int result = 0;
//		String chagneJoinState = null;
//		
//		if( "".equals(joinState)) {
//	    	//null일 때 -> 가입승인 되어야 함
//			chagneJoinState = "가입승인";
//			clubVO.setCbCurMbnum(clubVO.getCbCurMbnum()+1);
//			
//			result += mapper.insertJoin(clubVO, loginUser,chagneJoinState);
//			System.out.println("Service-join...... result : " + result);
//			
//			result += mapper.insertJoinHistory(clubVO, loginUser, chagneJoinState);
//			System.out.println("Service-join...... result : " + result);
//			
//			
//	    }
//		else if(joinState.equals("모임탈퇴")) {
//			//'모임탈퇴'일 때 -> 가입승인 되어야 함
//			chagneJoinState = "가입승인";
//			clubVO.setCbCurMbnum(clubVO.getCbCurMbnum()+1);
//			
//			result += mapper.updateJoin(clubVO, loginUser,chagneJoinState);
//			result += mapper.insertJoinHistory(clubVO, loginUser, chagneJoinState);
//		} 
//		else if(joinState.equals("가입승인")) {			
//	    	//'가입승인'일 때 -> 가입이 취소되어야함
//			chagneJoinState = "모임탈퇴";
//			clubVO.setCbCurMbnum(clubVO.getCbCurMbnum()-1);
//			
//			result += mapper.updateJoin(clubVO, loginUser,chagneJoinState);
//			result += mapper.insertJoinHistory(clubVO, loginUser, chagneJoinState);
//	    } 
//	    else {
//	    	// '모임만료'나 '모임추방'일때는  -> 가입불가 X	   
//	    	log.info("Service-join : 아무것도 안찍힘");
//	    }
//	    
//		// 멤버상태를 변경해주고 나서는, club의 현재인원을 update해준다.
//		// 오류나서, 이거 제외하고 민성이형 주기
//		result += mapper.update(clubVO); 	    
//		log.info("result : " + result);
//		System.out.println("result : " + result);
//					
//		// update가 call-begin-end되있어서 반환값 -1 이라 -> 2-1 =1 나옴
//		return result == 1;
//	}
//
//	@Override
//	public String getCbMemByUsrNum(Long usrNum, Long cbNum) {
//		log.info("getCbMemByUsrNum......" + cbNum);
//		
//		return mapper.readCbMemByUsrNum(usrNum, cbNum);
//	}

	



}
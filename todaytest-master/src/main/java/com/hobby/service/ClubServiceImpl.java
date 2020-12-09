package com.hobby.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import com.hobby.domain.ClubVO;
import com.hobby.domain.Criteria;
import com.hobby.domain.UserVO;
import com.hobby.mapper.ClubMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service //비즈니스 영역을 담당하는 객체임을 표시
@AllArgsConstructor
public class ClubServiceImpl implements ClubService {

	private ClubMapper mapper;
	
	//정기모임 개설 
	@Override
	@Transactional
	public void registerClub(ClubVO club) {
		
		log.info("registerClub....."+ club);
		mapper.clubinsertSelectKey(club);
		mapper.clubinsertJoin(club);
		mapper.clubinsertJoinMember(club);
	}

	//정기모임 목록 
	@Override
	public List<ClubVO> getClubList() {
		
		log.info("getList.......");
		return mapper.getClubList();
	}
    
	//정기모임 목록 (검색조건에 맞는 모임 총 갯수)
	@Override
	public int getTotal(Criteria cri) {
		
		return mapper.getTotalCount(cri);
	}
	
	//정기모임 상세정보
	@Override
	public ClubVO getClub(Long cbNum) {
		
		log.info("getclub......"+ cbNum);
		return mapper.readclub(cbNum);
	}

	//정기모임 게시판 - 목록list (페이징) -- 정기모임 목록 상세검색에 같이 사용
	@Override
	public List<ClubVO> getList(Criteria cri) {
		
		log.info("get List with criteria:" + cri);
		return mapper.getListWithPaging(cri);
	}

	//정기모임 게시판 - 목록list
	@Override
	public List<ClubVO> getList(Long cbNum) {
		
		log.info("getList........");
		return mapper.getList(cbNum);
	}
	
	//정기모임 게시판 - 조회 + 조회수
	@Override
	@Transactional
	public ClubVO get(Long cbBno) {
		
		log.info("get......"+ cbBno);
		mapper.boardViews(cbBno);
		return mapper.read(cbBno);
	}
	
	//정기모임 게시판 - 등록
	@Override
	@Transactional
	public void boardRegister(ClubVO club) {
		
		log.info("boardregister....."+ club);
		mapper.boardInsertSelectKey(club);
		mapper.boardInsertDetail(club);
	}
	
	//정기모임 게시판 - 삭제
	@Override
	public boolean boardRemove(Long cbBno) {
		
		log.info("boardRemove....."+ cbBno);
		return mapper.boardDelete(cbBno) == 1;
	}
	
	//정기모임 게시판 - 수정
	@Override
	@Transactional
	public int boardModify(ClubVO club){
		
		log.info("boardmodify......"+club);
		int cnt = 0;
		cnt += mapper.boardUpdate(club);
		cnt += mapper.boardUpdateContent(club);
		
		if(cnt != 2) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		}
		
		return cnt;
	}
	
	//정기모임 가입 
	@Override
	@Transactional
	public void clubJoin(ClubVO club, UserVO userVO) {
		
		log.info("clubJoin....."+ club);
		mapper.clubJoin(club,userVO);
		mapper.clubJoinMember(club, userVO);
	}

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

	@Override
	public String getCbMemByUsrNum(Long usrNum, Long cbNum) {
		log.info("getCbMemByUsrNum......" + usrNum + "/"+cbNum);
		
		return mapper.readCbMemByUsrNum(usrNum, cbNum);
	}
	
	@Override
	public List<ClubVO> getJoinList(Long cbNum, String cbMbStResult) {		
		System.out.println("Service-getJoinHashMap......cbnum: " + cbNum);
		System.out.println("Service-getJoinHashMap......cbmbstresult: " + cbMbStResult);
		
		return mapper.getJoinList(cbNum, cbMbStResult);
	}

}

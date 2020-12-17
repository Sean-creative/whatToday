package com.hobby.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import com.hobby.domain.ClubMemberVO;
import com.hobby.domain.ClubVO;
import com.hobby.domain.Criteria;
import com.hobby.domain.NoticeCri;
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
		mapper.clubViews(cbNum);
		return mapper.readclub(cbNum);
	}

	//정기모임 목록 상세검색 (페이징)
	@Override
	public List<ClubVO> getList(Criteria cri) {
		
		log.info("get List with criteria:" + cri);
		return mapper.getListWithPaging(cri);
	}

	//정기모임 게시판 - 목록list
//	@Override
//	public List<ClubVO> getList(Long cbNum) {
//		
//		log.info("getList........");
//		return mapper.getList(cbNum);
//	}
	
	//정기모임 게시판 - 목록list (페이징)
	@Override
	public List<ClubVO> boardgetList(NoticeCri cri, Long cbNum) {
		
		log.info("get boardList with page:" + cri);
		return mapper.boardListWithPaging(cri, cbNum);
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
	public boolean join(ClubVO club, UserVO loginUser, String joinState) {
		club = mapper.readclub(club.getCbNum()); 
		System.out.println("Service-join......" + club);
		System.out.println("Service-join......" + loginUser);
		System.out.println("Service-join......" + joinState);		
		
		//우선적으로는 Service.join 쪽 갔을때만 -> 인원수 변동시켜주자!!!
			    	
	    //신청하기or신청취소하기 버튼을 눌렀으면 여기서 케이스를 나눠서 Mapper 메소드를 실행한다.
	    //joinState - 모임추방, 모임만료, 모임탈퇴, 가입승인, Null (아직 데이터 넣기 전)
		
		int result = 0;
		String chagneJoinState = null;
				
			
		//1. joinState가 Null일 때 -> member에는 안들어가고, history에만 들어가야한다.
		if( "".equals(joinState) || joinState == null) {
	    	//null일 때 -> 승인대기 되어야 함
			chagneJoinState = "승인대기";
			System.out.println("chagneJoinState : " + chagneJoinState);
									
			result += mapper.insertJoinHistory(club, loginUser, chagneJoinState);
			System.out.println("Service-join...... result : " + result);						
	    }		
		else if(joinState.equals("모임탈퇴")) {
			//'모임탈퇴'일 때 -> 승인대기 되어야 함
			chagneJoinState = "승인대기";
			System.out.println("chagneJoinState : " + chagneJoinState);			
						
			result += mapper.insertJoinHistory(club, loginUser, chagneJoinState);
		} 
		else if(joinState.equals("가입승인")) {			
	    	//'가입승인'일 때 -> 가입이 취소되어야함
			chagneJoinState = "모임탈퇴";
			System.out.println("chagneJoinState : " + chagneJoinState);
			club.setCbCurMbNum(club.getCbCurMbNum()-1);
			
			result += mapper.updateJoin(club, loginUser,chagneJoinState);
			result += mapper.insertJoinHistory(club, loginUser, chagneJoinState);
	    }
		
			    
		// 멤버상태를 변경해주고 나서는, club의 현재인원을 update해준다.
		result += mapper.update(club); 	    		
		System.out.println("result : " + result);
					
		// update가 call-begin-end되있어서 반환값 -1 이라 -> 2-1 =1 나옴
		return result == 1;
	}

	@Override
	public String getCbMemByUsrNum(Long usrNum, Long cbNum) {
		log.info("getCbMemByUsrNum......" + usrNum + "/"+cbNum);
		
		return mapper.readCbMemByUsrNum(usrNum, cbNum);
	}
	
	@Override
	public List<ClubMemberVO> getJoinList(Long cbNum, String cbMbStResult) {		
		System.out.println("Service-getJoinHashMap......cbnum: " + cbNum);
		System.out.println("Service-getJoinHashMap......cbmbstresult: " + cbMbStResult);
		
		return mapper.getJoinList(cbNum, cbMbStResult);
	}
	
	
	
	
	
	// 정기모임에 가입한 사람 - 지영
	@Override
	public Long getCbMember(Long cbNum, Long usrNum) {
		Long result = mapper.getCbMember(cbNum, usrNum);
		System.out.println("result: " + result);
		return result;
	}
	
	

	//정기모임 게시판 총 갯수 
	@Override
	public int boardgetTotal(NoticeCri cri, Long cbNum) {
		
		log.info("get total board count");
		return mapper.boardgetTotalCount(cri, cbNum);
	}


}

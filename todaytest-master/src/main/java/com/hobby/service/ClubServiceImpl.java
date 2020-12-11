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

	//정기모임 상세정보
	@Override
	public ClubVO getClub(Long cbNum) {
		
		log.info("getclub......"+ cbNum);
		return mapper.readclub(cbNum);
	}

	//정기모임 게시판 - 목록list (페이징)
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

	@Override
	public int getTotal(Criteria cri) {
		
		return mapper.getTotalCount(cri);
	}
}

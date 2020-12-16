package com.hobby.service;

import java.util.List;

import com.hobby.domain.ClubMemberVO;
import com.hobby.domain.ClubVO;
import com.hobby.domain.Criteria;
import com.hobby.domain.NoticeCri;
import com.hobby.domain.UserVO;

public interface ClubService {
	
	//정기모임 개설 
	public void registerClub(ClubVO club);

	//정기모임 목록 
	public List<ClubVO> getClubList();
		
	//정기모임 목록 (검색 추가 및 검색조건에 맞는 모임 총 갯수)
	public int getTotal(Criteria cri);
	
	//정기모임 상세정보
	public ClubVO getClub(Long cbNum);
	
	//정기모임 목록 상세검색 (페이징)
	public List<ClubVO> getList(Criteria cri);
	
	//정기모임 게시판 - 목록list
	//public List<ClubVO> getList(Long cbNum);
	
	//정기모임 게시판 - 목록list (페이징)
	public List<ClubVO> boardgetList(NoticeCri cri, Long cbNum);
	
	//정기모임 게시판 총 갯수 
	public int boardgetTotal(NoticeCri cri, Long cbNum);
	
	//정기모임 게시판 - 조회
	public ClubVO get(Long cbBno);
	
	//정기모임 게시판 - 등록
	public void boardRegister(ClubVO club);

	//정기모임 게시판 - 삭제
	public boolean boardRemove(Long cbBno);
		
	//정기모임 게시판 - 수정
	public int boardModify(ClubVO club);
		
	public String getCbMemByUsrNum(Long usrNum, Long cbNum);

	public List<ClubMemberVO> getJoinList(Long cbNum, String cbMbStResult);

	
	
	
	
	//정기모임 가입 
	public boolean join(ClubVO clubVO, UserVO loginUser, String joinState);
	
}

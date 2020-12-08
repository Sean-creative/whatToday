package com.hobby.service;

import java.util.List;

import com.hobby.domain.ClubVO;
import com.hobby.domain.Criteria;
import com.hobby.domain.UserVO;

public interface ClubService {
	
	//정기모임 개설 
	public void registerClub(ClubVO club);

	//정기모임 목록 
	public List<ClubVO> getClubList();
		
	//정기모임 상세정보
	public ClubVO getClub(Long cbNum);
	
	//정기모임 게시판 - 목록list
	public List<ClubVO> getList(Long cbNum);
	
	//정기모임 게시판 - 목록list (페이징)
	public List<ClubVO> getList(Criteria cri);
	
	//정기모임 게시판 - 조회
	public ClubVO get(Long cbBno);
	
	//정기모임 게시판 - 등록
	public void boardRegister(ClubVO club);

	//정기모임 게시판 - 삭제
	public boolean boardRemove(Long cbBno);
		
	//정기모임 게시판 - 수정
	public int boardModify(ClubVO club);
		
	//정기모임 가입 
	public void clubJoin(ClubVO club, UserVO userVO);
	
	//정기모임 목록 (검색조건에 맞는 모임 갯수찾기)
	public int getTotal(Criteria cri);

}

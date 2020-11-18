package com.hobby.service;

import java.util.List;

import com.hobby.domain.ClubVO;
import com.hobby.domain.Criteria;

public interface ClubService {
	
	//정기모임 개설 
	public void registerClub(ClubVO club);

	//정기모임 목록 
	public List<ClubVO> getClubList();
		
	//정기모임 상세정보
	public ClubVO getClub(Long cbNum);
	
	//정기모임 게시판 - 조회
	public ClubVO get(Long cbBno);	
		
	//정기모임 게시판 - 목록list (페이징)
	public List<ClubVO> getList(Criteria cri);
		
	//정기모임 게시판 - 목록list
	public List<ClubVO> getList(Long cbNum);
		
	//정기모임 게시판 - 조회수
	public int boardViews(Long cbBno);

}

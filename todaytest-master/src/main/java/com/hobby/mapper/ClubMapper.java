package com.hobby.mapper;

import java.util.List;

import com.hobby.domain.ClubVO;
import com.hobby.domain.Criteria;

public interface ClubMapper {
	
	//정기모임 개설
	public void clubinsertSelectKey(ClubVO club);
	
	//정기모임 목록 
	public List<ClubVO> getClubList();
		
	//정기모임 상세정보
	public ClubVO readclub(Long cbNum);
	
	//정기모임 게시판 - 목록list
	public List<ClubVO> getList(Long cbNum);
		
	//정기모임 게시판 - 목록list (페이징)
	public List<ClubVO> getListWithPaging(Criteria cri);
		
	//정기모임 게시판 - 조회
	public ClubVO read(Long cbBno);

	//정기모임 게시판 - 조회수
	public int boardViews(Long cbBno);
	
}

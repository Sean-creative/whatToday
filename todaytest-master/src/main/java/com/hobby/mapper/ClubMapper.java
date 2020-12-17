package com.hobby.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hobby.domain.ClubMemberVO;
import com.hobby.domain.ClubVO;
import com.hobby.domain.Criteria;
import com.hobby.domain.NoticeCri;
import com.hobby.domain.UserVO;

public interface ClubMapper {
	
	//정기모임 개설
	public void clubinsertSelectKey(ClubVO club);
	public void clubinsertJoin(ClubVO club);
	public void clubinsertJoinMember(ClubVO club);
	
	//정기모임 목록 
	public List<ClubVO> getClubList();
	
	//정기모임 목록 (검색 추가 및 검색조건에 맞는 모임 총 갯수)
	public int getTotalCount(Criteria cri);
	
	//정기모임 조회수 
	public void clubViews(Long cbNum);
	
	//정기모임 상세정보
	public ClubVO readclub(Long cbNum);
	
	//정기모임 목록 상세검색 (페이징)
	public List<ClubVO> getListWithPaging(Criteria cri);
	
	//정기모임 게시판 - 목록list
	//public List<ClubVO> getList(Long cbNum);
		
	//정기모임 게시판 - 목록list (페이징)
	public List<ClubVO> boardListWithPaging(@Param("cri") NoticeCri cri, @Param("cbNum") Long cbNum);
	
	//정기모임 게시판 총 갯수 
	public int boardgetTotalCount(@Param("cri") NoticeCri cri, @Param("cbNum") Long cbNum);
		
	//정기모임 게시판 - 조회
	public ClubVO read(Long cbBno);
	
	//정기모임 게시판 - 등록
	public void boardInsertSelectKey(ClubVO club);
	
	//정기모임 게시판 - 등록상세 
	public void boardInsertDetail(ClubVO club);

	//정기모임 게시판 - 삭제
	public int boardDelete(Long cbBno);
	
	//정기모임 게시판 - 수정
	public int boardUpdate(ClubVO club);
	public int boardUpdateContent(ClubVO club);
	
	//정기모임 게시판 - 조회수
	public void boardViews(Long cbBno);
	
	//정기모임 가입 
	public int insertJoin(@Param("club") ClubVO clubVO, @Param("loginUser") UserVO loginUser, @Param("joinState") String joinState);
	
	public int updateJoin(@Param("club") ClubVO clubVO, @Param("loginUser") UserVO loginUser, @Param("joinState") String joinState);
	
	public int insertJoinHistory(@Param("club") ClubVO clubVO, @Param("loginUser") UserVO loginUser, @Param("joinState") String joinState);
	
	public int update(ClubVO club);
	
	
	public String readCbMemByUsrNum(@Param("usrNum") Long usrNum, @Param("cbNum") Long cbNum);
	public List<ClubMemberVO> getJoinList(@Param("cbNum") Long cbNum, @Param("cbMbStResult") String cbMbStResult);
	
	
	// 정기모임에 가입한 사람 - 지영
	public Long getCbMember(@Param("cbNum") Long cbNum, @Param("usrNum") Long usrNum);
	
}

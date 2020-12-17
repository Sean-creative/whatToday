package com.hobby.mapper;

import java.util.List;

import com.hobby.domain.ClubVO;
import com.hobby.domain.NoticeVO;
import com.hobby.domain.UserVO;
/**
 * 작성자 국민성
 */
public interface AdminMapper {
	
	public List<UserVO> getJoinWeek();
	public List<UserVO> getUserList();
	public List<UserVO> getBanLeaveUser();
	public List<ClubVO> getClubList();
	public List<ClubVO> getClubMemberList(Long cbNum);
	public List<ClubVO> getCloseClub();
	//공지사항 제목들 
	public List<NoticeVO> noticeList();
	public UserVO getTodayLoginNum();
	
	//=======공지사항 등록  =======//	
	//공지사항
	public int insertNotice(NoticeVO noticeVO);
	//공지사항 내용 등록
	public int insertNotiCon(NoticeVO noticeVO);
	//=======공지사항 수정 ==========//	
	// 공지사항 수정 
	public int updateNotice(NoticeVO noticeVO);
	//공지사항 내용 수정 
	public int updateNotiCon(NoticeVO noticeVO);
	// 공지사항 삭제
	public int deleteNotice(Long ntNum);
	public int deleteNotiCon(Long ntNum);
	
	public UserVO getUser(String id);
	
	public int insertUserHistory(UserVO userVO);
	public int updateBanUser(UserVO userVO);
	
	public int updateUserAuth(UserVO userVO);
	public int updateClubLeader(ClubVO clubVO);

	public int shutClub(Long cbNum);
}

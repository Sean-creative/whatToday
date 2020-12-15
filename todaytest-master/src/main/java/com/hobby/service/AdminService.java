package com.hobby.service;

import java.util.List;

import com.hobby.domain.ClubVO;
import com.hobby.domain.NoticeVO;
import com.hobby.domain.UserVO;

public interface AdminService {

	public List<UserVO> getJoinWeek();
	
	public List<UserVO> getUserList();
	
	public UserVO getTodayLoginNum();
	
	public UserVO getUser(String id);
	
	public List<UserVO> getBanLeaveUser();
	
	public int updateBanUser(UserVO userVO);
	
	public List<ClubVO> getClubList();
	
	public List<ClubVO> getCloseClub();
	
	public List<ClubVO> getClubMemberList(Long usrNum);
	
	public int insertUserHistory(UserVO userVO);
	
	public int updateClubLeader(ClubVO clubVO);
	
	public int shutClub(Long cbNum);
	
	//======= 공지사항 읽기 =======//
	public List<NoticeVO> noticeList();
	//======= 공지사항 쓰기 =======//
	public int writeNotice(NoticeVO noticeVO);
	//======= 공지사항 삭제 =======//
	public int deleteNotice(Long ntNum);
	//======= 공지사항 수정 =======//	
	public int updateNotice(NoticeVO noticeVO);
	
	
}

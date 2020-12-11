package com.hobby.service;

import java.util.List;

import com.hobby.domain.ClubVO;
import com.hobby.domain.UserVO;

public interface AdminService {

	public List<UserVO> getUserList();
	
	public UserVO getUser(String id);
	
	public List<UserVO> getBanLeaveUser();
	
	public int updateBanUser(UserVO userVO);
	
	public List<ClubVO> getClubList();
	
	public List<ClubVO> getClubMemberList(Long usrNum);
	
	public int insertUserHistory(UserVO userVO);
	
	
	public int updateClubLeader(ClubVO clubVO);
	
	public int shutClub(Long cbNum);
}

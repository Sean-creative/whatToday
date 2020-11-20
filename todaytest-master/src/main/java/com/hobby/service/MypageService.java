package com.hobby.service;

import java.util.List;

import com.hobby.domain.CategoryVO;
import com.hobby.domain.ClubVO;
import com.hobby.domain.UserVO;

public interface MypageService {

	
	public UserVO getUser(String id);
	public ClubVO getClub(ClubVO clubVO);
	public ClubVO getMyClublist(Long cbNum);
	public List<UserVO> getUserList();
	public List<ClubVO> getMyClubList(Long usrNum);
	public List<ClubVO> getWaitClubList(Long usrNum);
	public List<ClubVO> getPrevClubList(Long usrNum);
	public List<ClubVO> getMyCreateClubList(Long usrNum);
	
	public List<CategoryVO> getCategoryList(String catClassificationCode);
	
	
	public int updateUserInfo(UserVO userVO);
	public int updateClubFounderName(UserVO userVO);
	public int updateClubMemberName(UserVO userVO);
	public int updateNameUserHistory(UserVO userVO);
	public int updateMeetingMemberName(UserVO userVO);
	public int updateUserDetail(UserVO userVO);
	public int insertUserHistory(UserVO userVO);

	public boolean isPwdValid(String password);
	public boolean findPwdInDB(String password,String password2);
	
	public int leaveSite(UserVO userVO);
	
	public void updateUserInfoAndName(UserVO userVO);

}

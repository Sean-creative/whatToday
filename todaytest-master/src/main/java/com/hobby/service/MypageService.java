package com.hobby.service;

import java.io.File;
import java.util.List;

import com.hobby.domain.CategoryVO;
import com.hobby.domain.ClubVO;
import com.hobby.domain.RegionVO;
import com.hobby.domain.UserVO;

public interface MypageService {

	
	public UserVO getUser(String id);
	public ClubVO getClub(ClubVO clubVO);
	public ClubVO getJoinClub(Long cbNum);
	
	public List<UserVO> getUserList();
	public List<ClubVO> getMyClubList(Long usrNum);
	public List<ClubVO> getWaitClubList(Long usrNum);
	public List<ClubVO> getPrevClubList(Long usrNum);
	public List<ClubVO> getMyCreateClubList(Long usrNum);
	
	public List<CategoryVO> getCategoryList(String catClassificationCode);
	public List<RegionVO> getCityList();
	public List<RegionVO> getDistrictList(String rgName);
	
	
	public int updateUserInfo(UserVO userVO);
	public int updateClubFounderName(UserVO userVO);
	public int updateClubMemberName(UserVO userVO);
	public int updateNameUserHistory(UserVO userVO);
	public int updateMeetingMemberName(UserVO userVO);
	public int updateUserDetail(UserVO userVO);
	public int insertUserHistory(UserVO userVO);

	public boolean isPwdValid(String password);
	public boolean comparePwdDB(String password,String password2);
	
	public int updateUserAuth(UserVO userVO);
	
	public int updateUserTotalInfo(UserVO userVO);
	public int leaveUser(UserVO userVO);
	
	public String getFolder();
	public boolean checkImageType(File file);


}

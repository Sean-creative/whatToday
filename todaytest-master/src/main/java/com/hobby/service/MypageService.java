package com.hobby.service;

import java.io.File;
import java.util.List;

import com.hobby.domain.CategoryVO;
import com.hobby.domain.ClubVO;
import com.hobby.domain.RegionVO;
import com.hobby.domain.UserVO;

public interface MypageService {

	
	public UserVO getUserN(Long usrNum);
	public UserVO getUser(String id);
	public ClubVO getClub(ClubVO clubVO);
	public ClubVO getJoinClub(Long usrNum);
	public ClubVO findClubMem(Long usrNum, Long cbNum);
	
	public List<UserVO> getUserList();
	public List<ClubVO> getMyClubList(Long usrNum);
	public List<ClubVO> getWaitClubList(Long usrNum);
	public List<ClubVO> getPrevClubList(Long usrNum);
	public List<ClubVO> getLeaderClubList(Long usrNum);
	public List<ClubVO> getClubManageMemList(Long cbNum);
	public List<ClubVO> getLikeClub(Long usrNum);
	
	public List<CategoryVO> getCategoryList(String catClassificationCode);
	public List<RegionVO> getCityList();
	public List<RegionVO> getDistrictList(String rgName);
	
	public int updateUserPwd(UserVO userVO);
	public int updateUserInfo(UserVO userVO);
	public int updateUserDetail(UserVO userVO);
	public int insertUserHistory(UserVO userVO);
	public int insertClubJoinHistory(ClubVO clubVO);
	public int leaveUserClub(UserVO userVO);
	
	public int changeClubMemStatePlus(ClubVO clubVO);
	public int changeClubMemStateMinus(ClubVO clubVO);

	public boolean isPwdValid(String password);
	public boolean comparePwdDB(String password,String password2);
	
	public int updateUserAuth(UserVO userVO);
	
	public int updateUserTotalInfo(UserVO userVO);
	public int leaveUser(UserVO userVO);
	public int shutClub(Long cbNum);
	public int insertClubMember(ClubVO clubVO);
	
	public String getFolder();
	public boolean checkImageType(File file);
	public int updateClubManageMem(ClubVO clubVO);


}

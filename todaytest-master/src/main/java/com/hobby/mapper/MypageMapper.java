package com.hobby.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.hobby.domain.CategoryVO;
import com.hobby.domain.ClubVO;
import com.hobby.domain.RegionVO;
import com.hobby.domain.UserVO;


public interface MypageMapper {
	
	
	public UserVO getUserN(Long usrNum);
	public UserVO getUser(String id);
	public ClubVO getClub(ClubVO clubVO);
	public ClubVO getJoinClub(Long usrNum);
	public ClubVO findClubMem(@Param("usrNum")Long usrNum, @Param("cbNum")Long cbNum);
	
	public List<UserVO> getUserList();
	public List<UserVO> getOldFiles();
	public List<ClubVO> getMyClubList(Long usrNum);
	public List<ClubVO> getWaitClubList(Long usrNum);
	public List<ClubVO> getPrevClubList(Long usrNum);
	public List<ClubVO> getLeaderClubList(Long usrNum);
	public List<ClubVO> getMyCreateTypeClubList(Long usrNum);
	public List<ClubVO> getClubManageMemList(Long cbNum);
	
	public List<ClubVO> getLikeClub(Long usrNum);
	
	public List<RegionVO> getCityList();
	public List<RegionVO> getDistrictList(String rgName);
	
	
	public List<CategoryVO> getCategoryList(String catClassificationCode);
	
	public int insertUserHistory(UserVO userVO);
	public int insertClubJoinHistory(ClubVO clubVO);
	public int insertClubMember(ClubVO clubVO);
	

	public int updateUserPwd(UserVO userVO);
	public int updateUserInfo(UserVO userVO);
	public int updateUserDetail(UserVO userVO);
	public int updateClubManageMem(ClubVO clubVO);
	public int updateUserAuth(UserVO userVO);
	public int updateClubMemNumPlus(ClubVO clubVO);
	public int updateClubMemNumMinus(ClubVO clubVO);
	public int leaveUserClub(UserVO userVO);
	
	public int shutClub(Long cbNum);
	public int leaveClub(UserVO userVO);
	
}

package com.hobby.mapper;

import java.util.List;

import com.hobby.domain.ClubVO;
import com.hobby.domain.UserVO;
/**
 * 작성자 국민성
 */
public interface AdminMapper {
	
	public List<UserVO> getUserList();
	public List<UserVO> getBanLeaveUser();
	public List<ClubVO> getClubList();
	public List<ClubVO> getClubMemberList(Long cbNum);
	
	public UserVO getUser(String id);
	
	public int insertUserHistory(UserVO userVO);
	public int updateBanUser(UserVO userVO);
	
	public int updateUserAuth(UserVO userVO);
	public int updateClubLeader(ClubVO clubVO);

	public int shutClub(Long cbNum);
}

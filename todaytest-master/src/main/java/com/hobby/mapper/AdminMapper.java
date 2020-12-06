package com.hobby.mapper;

import java.util.List;

import com.hobby.domain.ClubVO;
import com.hobby.domain.UserVO;
/**
 * �ۼ��� : ���μ�
 */
public interface AdminMapper {
	
	public List<UserVO> getUserList();
	public List<UserVO> getBanLeaveUser();
	public List<ClubVO> getClubList();
	public List<UserVO> getClubMemberList(Long cbNum);
	
	public UserVO getUser(String id);
	
	public int insertUserHistory(UserVO userVO);
	public int updateBanUser(String id);
	
	public int updateUserAuth(UserVO userVO);
}

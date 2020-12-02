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
	
	public UserVO getUser(String id);
	
	
	public int updateBanUser(Long userNum);
}

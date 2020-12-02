package com.hobby.mapper;

import java.util.List;

import com.hobby.domain.UserVO;
/**
 * 작성자: 국민성
 */
public interface AdminMapper {
	
	public List<UserVO> getUserList();
	public UserVO getUser(String id);
	
	public List<UserVO> getBanLeaveUser();
	
	public int updateBanUser(Long userNum);
}

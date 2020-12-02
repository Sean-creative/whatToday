package com.hobby.service;

import java.util.List;

import com.hobby.domain.UserVO;

public interface AdminService {

	public List<UserVO> getUserList();
	
	public UserVO getUser(String id);
	
	public List<UserVO> getBanLeaveUser();
	
	public int updateBanUser(long usrNum);
}

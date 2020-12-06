package com.hobby.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hobby.domain.ClubVO;
import com.hobby.domain.UserVO;
import com.hobby.mapper.AdminMapper;


import lombok.Setter;

@Service
public class AdminServiceImpl implements AdminService{

	@Setter(onMethod_ = @Autowired)
	AdminMapper mapper;
	
	@Override
	public List<UserVO> getUserList() {
		
		return mapper.getUserList();
	}

	@Override
	public UserVO getUser(String id) {
		
		return mapper.getUser(id);
	}

	@Override
	public int updateBanUser(String id) {
		
		return mapper.updateBanUser(id);
	}

	@Override
	public List<UserVO> getBanLeaveUser() {
		
		return mapper.getBanLeaveUser();
	}

	@Override
	public List<ClubVO> getClubList() {
		
		return mapper.getClubList();
	}

	@Override
	public List<UserVO> getClubMemberList(Long cbNum) {
		
		return mapper.getClubMemberList(cbNum);
	}
	
	@Override
	public int insertUserHistory(UserVO userVO) {
		return mapper.insertUserHistory(userVO);
	}

	@Override
	public int updateUserAuth(UserVO userVO) {
		
		return mapper.updateUserAuth(userVO);
	}

	
}

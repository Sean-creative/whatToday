package com.hobby.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hobby.domain.CategoryVO;
import com.hobby.domain.ClubVO;
import com.hobby.domain.RegionVO;
import com.hobby.domain.UserVO;
import com.hobby.mapper.MypageMapper;

import lombok.Setter;

@Service
public class MypageServiceImpl implements MypageService {

	
	@Setter(onMethod_ = @Autowired)
	private MypageMapper mapper;

	@Override
	public UserVO getUser(String id) {
		// TODO Auto-generated method stub
		return mapper.getUser(id);
	}

	@Override
	public List<UserVO> getUserList() {
		// TODO Auto-generated method stub
		return mapper.getUserList();
	}

	@Override
	public List<ClubVO> getMyClubList(Long usrNum) {
		// TODO Auto-generated method stub
		return mapper.getMyClubList(usrNum);
	}

	@Override
	public List<ClubVO> getWaitClubList(Long usrNum) {
		// TODO Auto-generated method stub
		return mapper.getWaitClubList(usrNum);
	}

	@Override
	public List<ClubVO> getPrevClubList(Long usrNum) {
		// TODO Auto-generated method stub
		return mapper.getPrevClubList(usrNum);
	}



	@Override
	public int updateUserInfo(UserVO userVO) {
		// TODO Auto-generated method stub
		return mapper.updateUserInfo(userVO);
	}

	@Override
	public int updateClubFounderName(UserVO userVO) {
		// TODO Auto-generated method stub
		return mapper.updateClubFounderName(userVO);
	}

	@Override
	public int updateClubMemberName(UserVO userVO) {
		// TODO Auto-generated method stub
		return mapper.updateClubMemberName(userVO);
	}

	@Override
	public boolean isPwdValid(String str1) {
		// TODO Auto-generated method stub
		return (str1.length() != 0 && str1 != null && str1.length() >= 8);
	}
	
	@Override
	public boolean findPwdInDB(String password, String password2) {
		// TODO Auto-generated method stub
		return password.equals(password2);
	}

	@Override
	public int insertUserHistory(UserVO userVO) {
		// TODO Auto-generated method stub
		return mapper.insertUserHistory(userVO);
	}

	@Override
	public int updateNameUserHistory(UserVO userVO) {
		// TODO Auto-generated method stub
		return mapper.updateNameUserHistory(userVO);
	}

	@Override
	public List<ClubVO> getMyCreateClubList(Long usrNum) {
		// TODO Auto-generated method stub
		return mapper.getMyCreateClubList(usrNum);
	}

	@Override
	public ClubVO getClub(ClubVO clubVO) {
		// TODO Auto-generated method stub
		return mapper.getClub(clubVO);
	}

	@Override
	public int updateMeetingMemberName(UserVO userVO) {
		// TODO Auto-generated method stub
		return mapper.updateMeetingMemberName(userVO);
	}

	@Override
	public List<CategoryVO> getCategoryList(String catClassificationCode) {
		// TODO Auto-generated method stub
		return mapper.getCategoryList(catClassificationCode);
	}

	@Override
	public int updateUserDetail(UserVO userVO) {
		// TODO Auto-generated method stub
		return mapper.updateUserDetail(userVO);
	}

	@Override
	public int leaveSite(UserVO userVO) {
		// TODO Auto-generated method stub
		return mapper.leaveSite(userVO);
	}

	@Override
	public ClubVO getJoinClub(Long cbNum) {
		// TODO Auto-generated method stub
		return mapper.getJoinClub(cbNum);
	}


	@Override
	public List<RegionVO> getCityList() {
		// TODO Auto-generated method stub
		return mapper.getCityList();
	}

	@Override
	public List<RegionVO> getDistrictList(String rgName) {
		// TODO Auto-generated method stub
		return mapper.getDistrictList(rgName);
	}


}

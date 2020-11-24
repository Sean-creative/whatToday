package com.hobby.service;


import java.util.ArrayList;
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
		UserVO userVO;
		try{
			userVO = mapper.getUser(id);
		}
		catch(Exception e){
			userVO = new UserVO();
		}
		
		return userVO;
	}

	@Override
	public List<UserVO> getUserList() {
		// TODO Auto-generated method stub
		List<UserVO> userList;
		try{
		userList = mapper.getUserList();
		}
		catch(Exception e) {
			userList = new ArrayList();
		}
		return userList;
	}

	@Override
	public List<ClubVO> getMyClubList(Long usrNum) {
		// TODO Auto-generated method stub
		List<ClubVO> clubList;
		try{
			clubList = mapper.getMyClubList(usrNum);
		}
		catch(Exception e){
			clubList = new ArrayList();
		}
		return clubList;
	}

	@Override
	public List<ClubVO> getWaitClubList(Long usrNum) {
		// TODO Auto-generated method stub
		List<ClubVO> clubList;
		try {
			clubList = mapper.getWaitClubList(usrNum);
		}
		catch(Exception e) {
			clubList = new ArrayList();
		}
		return clubList;
	}

	@Override
	public List<ClubVO> getPrevClubList(Long usrNum) {
		// TODO Auto-generated method stub
		
		List<ClubVO> clubList;
		try {
			clubList = mapper.getPrevClubList(usrNum);
		}
		catch(Exception e) {
			clubList = new ArrayList();
		}
		return clubList;
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
	public boolean comparePwdDB(String password, String password2) {
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
		List<ClubVO> clubList;
		try {
			clubList = mapper.getMyCreateClubList(usrNum);
		}
		catch(Exception e) {
			clubList = new ArrayList();
		}
		return clubList;
	}

	@Override
	public ClubVO getClub(ClubVO clubVO) {
		// TODO Auto-generated method stub
		
		ClubVO club;
		try {
			club = mapper.getClub(clubVO);
		}
		catch(Exception e) {
			club = new ClubVO();
		}
		return club;
	}

	@Override
	public int updateMeetingMemberName(UserVO userVO) {
		// TODO Auto-generated method stub
		
		return mapper.updateMeetingMemberName(userVO);
	}

	@Override
	public List<CategoryVO> getCategoryList(String catClassificationCode) {
		// TODO Auto-generated method stub
		List<CategoryVO> categoryList;
		try {
			categoryList = mapper.getCategoryList(catClassificationCode);
		}
		catch(Exception e) {
			categoryList = new ArrayList();
		}
		return categoryList;
	}

	@Override
	public int updateUserDetail(UserVO userVO) {
		// TODO Auto-generated method stub
		return mapper.updateUserDetail(userVO);
	}

	@Override
	public int updateUserAuth(UserVO userVO) {
		// TODO Auto-generated method stub
		return mapper.updateUserAuth(userVO);
	}

	@Override
	public ClubVO getJoinClub(Long cbNum) {
		// TODO Auto-generated method stub
		ClubVO club;
		try {
			club = mapper.getJoinClub(cbNum);
		}
		catch(Exception e) {
			club = new ClubVO();
		}
		return club;
	}


	@Override
	public List<RegionVO> getCityList() {
		// TODO Auto-generated method stub
		List<RegionVO> cityList;
		try {
			cityList = mapper.getCityList();
		}
		catch(Exception e) {
			cityList = new ArrayList();
		}
		return cityList;
	}

	@Override
	public List<RegionVO> getDistrictList(String rgName) {
		// TODO Auto-generated method stub
		List<RegionVO> districtList;
		try {
			districtList = mapper.getDistrictList(rgName);
		}
		catch(Exception e) {
			districtList = new ArrayList();
		}
		return districtList;
	}

	@Override
	@Transactional
	public int updateUserTotalInfo(UserVO userVO) {
		// TODO Auto-generated method stub
		int cnt = 0;
		
		cnt += mapper.updateUserInfo(userVO);
		cnt += mapper.updateUserDetail(userVO);
		
		return cnt;
	}

	@Override
	@Transactional
	public int leaveUser(UserVO userVO) {
		// TODO Auto-generated method stub
		int cnt = 0;
		cnt += mapper.updateUserInfo(userVO);
		cnt += mapper.insertUserHistory(userVO);
		cnt += mapper.updateUserAuth(userVO);
		return cnt;
	}


}

package com.hobby.service;


import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

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
	
	@Setter(onMethod_=@Autowired)
	private PasswordEncoder pwencoder;

	@Override
	public UserVO getUser(String id) {
		return mapper.getUser(id);
	}

	@Override
	public List<UserVO> getUserList() {
		return mapper.getUserList();
	}

	@Override
	public List<ClubVO> getMyClubList(Long usrNum) {
		return mapper.getMyClubList(usrNum);
	}

	@Override
	public List<ClubVO> getWaitClubList(Long usrNum) {
		return mapper.getWaitClubList(usrNum);
	}

	@Override
	public List<ClubVO> getPrevClubList(Long usrNum) {
		return mapper.getPrevClubList(usrNum);
	}

	@Override
	public int updateUserInfo(UserVO userVO) {
		return mapper.updateUserInfo(userVO);
	}


	@Override
	public boolean isPwdValid(String str1) {
		return (str1.length() != 0 && str1 != null && str1.length() >= 8);
	}
	
	@Override
	public boolean comparePwdDB(String password, String password2) {
		return pwencoder.matches(password, password2);
	}

	@Override
	public int insertUserHistory(UserVO userVO) {
		return mapper.insertUserHistory(userVO);
	}



	@Override
	public List<ClubVO> getLeaderClubList(Long usrNum) {
		return mapper.getLeaderClubList(usrNum);

	}

	@Override
	public ClubVO getClub(ClubVO clubVO) {
		return mapper.getClub(clubVO);
	}



	@Override
	public List<CategoryVO> getCategoryList(String catClassificationCode) {
		return mapper.getCategoryList(catClassificationCode);
	}

	@Override
	public int updateUserDetail(UserVO userVO) {
		return mapper.updateUserDetail(userVO);
	}

	@Override
	public int updateUserAuth(UserVO userVO) {
		return mapper.updateUserAuth(userVO);
	}

	@Override
	public ClubVO getJoinClub(Long cbNum) {
		return mapper.getJoinClub(cbNum);
	}


	@Override
	public List<RegionVO> getCityList() {
		return mapper.getCityList();
	}

	@Override
	public List<RegionVO> getDistrictList(String rgName) {
		return mapper.getDistrictList(rgName);	
		
	}

	@Override
	@Transactional
	public int updateUserTotalInfo(UserVO userVO) {
		int cnt = 0;
		
		cnt += mapper.updateUserInfo(userVO);
		cnt += mapper.updateUserDetail(userVO);
		if(cnt != 2) {
			//2가 아니라면 강제롤백
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		}
		return cnt;
	}

	@Override
	@Transactional
	public int leaveUser(UserVO userVO) {
		int cnt = 0;
		cnt += mapper.updateUserInfo(userVO);
		cnt += mapper.insertUserHistory(userVO);
		cnt += mapper.updateUserAuth(userVO);
		if(cnt != 3) {
			//3이아니라면 강제 롤백
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		}
		
		return cnt;
	}

	@Override
	public String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		
		return str.replace("-", File.separator);
	}

	@Override
	public boolean checkImageType(File file) {
		
		try {
			String contentType = Files.probeContentType(file.toPath());
			
			return contentType.startsWith("image");
		}catch (IOException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	@Override
	public List<ClubVO> getClubManageMemList(Long cbNum) {
		
		return mapper.getClubManageMemList(cbNum);
	}

	@Transactional
	@Override
	public int changeClubMemStatePlus(ClubVO clubVO) {

		int cnt = 0;
		cnt += mapper.updateClubManageMem(clubVO);
		cnt += mapper.updateClubMemNumPlus(clubVO);
		
		if(cnt == 0) {
			//0이면 강제 롤백
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		}
		
		return cnt;
	}
	@Transactional
	@Override
	public int changeClubMemStateMinus(ClubVO clubVO) {
		
		int cnt = 0;
		cnt += mapper.updateClubManageMem(clubVO);
		cnt += mapper.updateClubMemNumMinus(clubVO);
		
		if(cnt == 0) {
			//0이면 강제 롤백
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		}
		
		return cnt;
	}
	
	@Override
	public int updateClubManageMem(ClubVO clubVO) {
		return mapper.updateClubManageMem(clubVO);
	}

	@Override
	public int shutClub(Long cbNum) {
		
		return mapper.shutClub(cbNum);
	}

	@Override
	public int insertClubJoinHistory(ClubVO clubVO) {
				return mapper.insertClubJoinHistory(clubVO);
	}

	@Override
	public int insertClubMember(ClubVO clubVO) {
		System.out.println("++++++++++++"+clubVO);
		System.out.println("++++++++++++"+clubVO.getUsrNum()+clubVO.getCbNum());
		Long usrNum = clubVO.getUsrNum();
		Long cbNum = clubVO.getCbNum();

		if(findClubMem(usrNum, cbNum) == null) {
			
			return mapper.insertClubMember(clubVO);
			
		}else
			return 1;
		
		
		
	}

	@Override
	public int updateUserPwd(UserVO userVO) {
		
		String updatePwd = userVO.getUsrPwd();
		userVO.setUsrPwd(pwencoder.encode(updatePwd));
		
		return mapper.updateUserPwd(userVO);
	}

	@Override
	public ClubVO findClubMem(Long usrNum, Long cbNum) {
		
		return mapper.findClubMem(usrNum,cbNum);
	}

	@Override
	public UserVO getUserN(Long usrNum) {
		return mapper.getUserN(usrNum);
	}

	@Override
	public int leaveUserClub(UserVO userVO) {

		return mapper.leaveUserClub(userVO);
	}

	@Override
	public List<ClubVO> getLikeClub(Long usrNum) {
		return mapper.getLikeClub(usrNum);
	}




}

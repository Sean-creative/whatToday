package com.hobby.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import com.hobby.domain.ClubVO;
import com.hobby.domain.NoticeVO;
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

	@Transactional
	@Override
	public int updateBanUser(UserVO userVO) {
		
		int cnt = 0;
		
		cnt += mapper.updateUserAuth(userVO);
		cnt += mapper.updateBanUser(userVO);
		
		if(cnt != 2) {
			//2가 아니라면 강제롤백
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		}
		return cnt;
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
	public List<ClubVO> getClubMemberList(Long cbNum) {
		
		return mapper.getClubMemberList(cbNum);
	}
	
	@Override
	public int insertUserHistory(UserVO userVO) {
		return mapper.insertUserHistory(userVO);
	}


	@Override
	public int updateClubLeader(ClubVO clubVO) {
		
		return mapper.updateClubLeader(clubVO);
	}

	@Override
	public int shutClub(Long cbNum) {
		return mapper.shutClub(cbNum);
	}

	@Override
	public List<ClubVO> getCloseClub() {
		return mapper.getCloseClub();
	}

	@Override
	public List<NoticeVO> noticeList() {
		return mapper.noticeList();
	}
	
	@Transactional
	@Override
	public int writeNotice(NoticeVO noticeVO) {
		int cnt = 0;
		cnt += mapper.insertNotice(noticeVO);
		cnt += mapper.insertNotiCon(noticeVO);
		if(cnt != 2) {
			//2가 아니라면 강제롤백
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		}
		return cnt;
	}

	@Override 
	@Transactional 
	public int updateNotice(NoticeVO notice) { 
		int cnt = 0;
      
		cnt += mapper.updateNotice(notice);
		cnt += mapper.updateNotiCon(notice);
		
		if(cnt != 2) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			}
		return cnt;
      }

	@Override
	@Transactional 
	public int deleteNotice(Long ntNum) {
		
		int cnt = 0;
	      
		cnt += mapper.deleteNotiCon(ntNum);
		cnt += mapper.deleteNotice(ntNum);
		
		if(cnt != 2) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			}
		return cnt;
	}

	@Override
	public List<UserVO> getJoinWeek() {
		return mapper.getJoinWeek();
	}

	@Override
	public UserVO getTodayLoginNum() {
		return mapper.getTodayLoginNum();
	}
	
}

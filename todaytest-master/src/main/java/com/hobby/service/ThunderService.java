package com.hobby.service;
/**
 * 작성자: 김선우
 */
import java.util.List;

import org.springframework.security.core.Authentication;

import com.hobby.domain.ClubMemberVO;
import com.hobby.domain.Criteria;
import com.hobby.domain.ThunderVO;
import com.hobby.domain.UserVO;

public interface ThunderService {
	
	
	public List<ThunderVO> getList();
	
	public ThunderVO get(long cbNum);
	
	public boolean register(ThunderVO clubVO, UserVO loginUser, String joinState);
						
	//번개모임에 가입하는 메소드
	public boolean join(ThunderVO clubVO, UserVO loginUser, String joinState);
	
	//로그인된 유저의 번호로, 지금 가입하려고하는 모임이 가입되어 있는지 상태를 조사
	//반환값은 cbmbstresult
	public String getCbMemByUsrNum(Long usrNum, Long cbNum);
	
	public List<ThunderVO> getList(Criteria cri);
	
	public int getTotal(Criteria cri);
		
	
	public List<ClubMemberVO> getJoinList(Long cbnum, String cbmbstresult);
	
	
	
	public boolean modify(ThunderVO clubVO);
	
	public boolean remove(long cbNum);
	
	
	//로그인이 되어있는지 알려주는 메소드
	public boolean isLogin(Authentication auth);
	
}

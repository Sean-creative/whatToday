package com.hobby.service;
/**
 * 작성자: 김선우
 */
import java.util.List;

import org.springframework.security.core.Authentication;

import com.hobby.domain.ThunderVO;
import com.hobby.domain.Criteria;

public interface ThunderService {
	
	
	public List<ThunderVO> getList();
	
	public ThunderVO get(long cbNum);
	
	public void register(ThunderVO clubVO);
						
	public List<ThunderVO> getList(Criteria cri);
	
	public int getTotal(Criteria cri);
	
	
	
	public boolean modify(ThunderVO clubVO);
	
	public boolean remove(long cbNum);
	
	
	//로그인이 되어있는지 알려주는 메소드
	public boolean isLogin(Authentication auth);
	
}

package com.hobby.service;

import java.util.List;

import com.hobby.domain.ClubVO;

public interface MainService {
	public List<ClubVO> getListRegular();
	public List<ClubVO> getListThunder();
	
	//정기모임 검색
	public List<ClubVO> getListKeyRegular(String keyword);
	
	//번개모임 검색
	public List<ClubVO> getListKeyThunder(String keyword);
}



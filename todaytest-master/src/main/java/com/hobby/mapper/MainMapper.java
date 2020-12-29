package com.hobby.mapper;

import java.util.List;

import com.hobby.domain.ClubVO;

public interface MainMapper {

	/////메/////인//////	
	public List<ClubVO> getListRegular();
	public List<ClubVO> getListThunder();
	

	public List<ClubVO> getListKeyRegular(String keyword);
	
	public List<ClubVO> getListKeyThunder(String keyword);
}

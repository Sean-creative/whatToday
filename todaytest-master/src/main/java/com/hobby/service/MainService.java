package com.hobby.service;

import java.util.List;

import com.hobby.domain.MainVO;
import com.hobby.domain.ThunderVO;

public interface MainService {
	public List<MainVO> getListRegular();
	public List<MainVO> getListThunder();
	
//검색
//	public List<ThunderVO> getListWithKeyword(String subCat);
}



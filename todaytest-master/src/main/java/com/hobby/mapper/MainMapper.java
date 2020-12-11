package com.hobby.mapper;

import java.util.List;

import com.hobby.domain.MainVO;
import com.hobby.domain.ThunderVO;

public interface MainMapper {

	/////메/////인//////	
	public List<MainVO> getListRegular();
	public List<MainVO> getListThunder();
	
//	public List<ThunderVO>getListWithKeyword(String subCat);
}

package com.hobby.service;

import java.util.List;

import com.hobby.domain.MainVO;

public interface MainService {
	public List<MainVO> getListRegular();
	public List<MainVO> getListThunder();
}

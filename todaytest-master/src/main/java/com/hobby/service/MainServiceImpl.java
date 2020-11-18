package com.hobby.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hobby.domain.MainVO;
import com.hobby.mapper.MainMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class MainServiceImpl implements MainService{
	
	@Setter(onMethod_ = @Autowired)
	private MainMapper mapper;
	
	
	@Override
	public List<MainVO> getListRegular() {
		log.info("getLsit.........");
		return mapper.getListRegular();
	}
	
	@Override
	public List<MainVO> getListThunder() {
		log.info("getLsitThunder.........");
		return mapper.getListThunder();
	}
	
}

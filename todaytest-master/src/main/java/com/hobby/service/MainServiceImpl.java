package com.hobby.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hobby.domain.ClubVO;
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
	
	
	/* 메인에 뿌려주는 정기 리스트 */
	@Override
	public List<ClubVO> getListRegular() {
		log.info("getLsit.........");
		return mapper.getListRegular();
	}
	
	
	
	/* 메인에 뿌려주는 번개 리스트 */
	@Override
	public List<ClubVO> getListThunder() {
		log.info("getLsitThunder.........");
		return mapper.getListThunder();
	}



	@Override
	public List<ClubVO> getListKeyRegular(String keyword) {
		 
		return mapper.getListKeyRegular(keyword);
	}



	@Override
	public List<ClubVO> getListKeyThunder(String keyword) {

		return mapper.getListKeyThunder(keyword);
	}

}

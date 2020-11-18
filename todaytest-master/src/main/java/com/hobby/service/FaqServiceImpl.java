package com.hobby.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hobby.domain.FaqVO;
import com.hobby.domain.InquireVO;
import com.hobby.domain.MainVO;
import com.hobby.mapper.FaqMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class FaqServiceImpl implements FaqService{
	
	@Setter(onMethod_ = @Autowired)
	private FaqMapper mapper;

	@Override
	public List<FaqVO> faqList() {
		log.info("faqlist...........");
		return mapper.faqList();
	}

	@Override
	public List<FaqVO> faqContent() {
		log.info("faqcontent......");
		return mapper.faqContent();
	}

	
	
	@Override
	public void register2(InquireVO inquire) {
		log.info("register......" + inquire);
		mapper.insertSelectKey2(inquire);
		mapper.insertqs(inquire);
	}

	



}

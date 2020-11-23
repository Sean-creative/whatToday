package com.hobby.mapper;

import java.util.List;

import com.hobby.domain.FaqVO;
import com.hobby.domain.InquireVO;
import com.hobby.domain.MainVO;

public interface FaqMapper {

	////f////a////q//////
	//faq질문들 
	public List<FaqVO> faqList();
	// faq 대답
	public List<FaqVO> faqContent();
	
	
	//////문//////의//////
	//문의
	public void insertSelectKey2(InquireVO inquire);
	//문의내용 
	public void insertqs(InquireVO inquire);
	
	
	

}

package com.hobby.service;

import java.util.List;


import com.hobby.domain.FaqVO;
import com.hobby.domain.InquireVO;
import com.hobby.domain.MainVO;

public interface FaqService {
	
	//faq질문 
	public List<FaqVO> faqList();
	//faq대답 
	public List<FaqVO> faqContent();
	
	//일대일문의 
	public void register2(InquireVO inquire);

	//일대일문의 내용 
	//public void registerqs(InquireVO inquire);
	
	
	
	
}

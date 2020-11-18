package com.hobby.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


import com.hobby.domain.InquireVO;
import com.hobby.service.FaqService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/cs/*")
@AllArgsConstructor
public class FaqController {
	
	private FaqService service;

// 자주묻는 질문 	
	@GetMapping("/faq")
	public void faq(Model model) {
		log.info("faq");
		model.addAttribute("faq", service.faqList());
		log.info("servcie.faqList: \n\n"+ service.faqList());
		System.out.println(model);
		model.addAttribute("faqContent", service.faqContent());
		log.info("servcie.faqContent: \n\n"+ service.faqContent());
	}
	
	@GetMapping("/inquire")
	public void register2() {
		log.info("register.....!!!!!\n\n\n" );
	}
	
	@PostMapping("/faq")
	public String register2(InquireVO inquire, RedirectAttributes rttr) {
		log.info("register2: " + inquire);
		service.register2(inquire);
		rttr.addFlashAttribute("result", inquire.getQsNum());
		
		return "redirect:/cs/faq";
	}

	
}

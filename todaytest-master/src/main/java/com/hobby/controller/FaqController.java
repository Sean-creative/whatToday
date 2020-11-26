package com.hobby.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hobby.domain.InquireVO;
import com.hobby.domain.UserVO;
import com.hobby.security.domain.CustomUser;
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
		//자주묻는 질문을 faq라는 이름으로 화면에 보낸다. 
		model.addAttribute("faq", service.faqList());
		log.info("servcie.faqList: \n\n"+ service.faqList());
		System.out.println("model###"+model);
		//자주묻는 질문 내용을 faqcontent라는 이름으로 화면에 보내준다. 
		model.addAttribute("faqContent", service.faqContent());
		log.info("servcie.faqContent: \n\n"+ service.faqContent());
	}
	  
//	///문의사항////
	@GetMapping("/inquire")
	public String inquireRegister(Authentication auth,Model model) {
		
		if(auth == null) {
			return "redirect:/login/login";
		}
		
		log.info("register.....!!!!!\n\n\n" );
		
		//회원정보를 가져온다 .로그인해야 일대일문의 쓸 수 있다. 
		CustomUser customUser = (CustomUser)auth.getPrincipal();
		UserVO userVO = customUser.getUser();
		
		log.info("##/add/## 회원번호 \n\\n\\n"+ userVO.getUsrNum());
		//회원정보를 통해 회원이름과 회원번호를 화면에 보내준다. 
		model.addAttribute("usrName",userVO.getUsrName());
		model.addAttribute("usrNum",userVO.getUsrNum());
		
		return "/cs/inquire";	
	}
	
	@PostMapping("/faq")
	public String inquireRegister(InquireVO inquire, RedirectAttributes rttr) {
		log.info("register2: ㅣㅣn\n\n\n" + inquire);
		service.register2(inquire);
		rttr.addFlashAttribute("result", inquire.getQsNum());
		
		return "redirect:/cs/faq";
	}
	
	
}
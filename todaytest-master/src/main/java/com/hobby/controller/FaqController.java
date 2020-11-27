package com.hobby.controller;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

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
	
	//메일 
	@Autowired
	private JavaMailSender mailSender;

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
	
	@RequestMapping(value="/mailRequest")
	public String inquireRegister(HttpServletRequest request) {
		 log.info("mailRequest####");  
		String setfrom = request.getParameter("qsEmail");  //사용자 메일 주소         
		String tomail  = "whattodayhobby@gmail.com";     //운영자 메일 주소 
	    String title   = request.getParameter("qsTitle");      // 제목
	    String content = request.getParameter("qsContent");    // 내용
	   
	    try {
	      MimeMessage message = mailSender.createMimeMessage();
	      MimeMessageHelper messageHelper 
	                        = new MimeMessageHelper(message, true, "UTF-8");
	 
	      messageHelper.setFrom(setfrom);  // 보내는사람 생략하거나 하면 정상작동을 안함
	      messageHelper.setTo(tomail);     // 받는사람 이메일
	      messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
	      messageHelper.setText(content);  // 메일 내용
	     
	      mailSender.send(message);
	    } catch(Exception e){
	      System.out.println(e);
	    }
	    return "redirect:/cs/faq";
	}
	
	// 자주묻는 질문 	
	@GetMapping("/notice")
	public void noticeRead(Model model) {
		
		log.info("notice");
		
		//공지사항을 notice라는 이름으로 화면에 보낸다. 
		model.addAttribute("noticeList", service.noticeList());
		log.info("servcie.noticeList: \n\n"+ service.noticeList());
		
		System.out.println("model###"+model);
		
		//자주묻는 질문 내용을 noticecontent라는 이름으로 화면에 보내준다. 
		model.addAttribute("noticeContent", service.noticeContent());
		log.info("servcie.noticeContent: \n\n"+ service.noticeContent());
	}
	
}
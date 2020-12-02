package com.hobby.controller;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;
@Log4j
@Controller
public class MailController {

	@Autowired
	private JavaMailSender mailSender;
	
	@RequestMapping(value = "/sendMail")
	public void emailCertify() throws Exception {
		
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

		messageHelper.setFrom("whattodayhobby@gmail.com", "오늘뭐하지"); // 보내는사람 생략하거나 하면 정상작동을 안함
		messageHelper.setTo("dnwntjs1531@naver.com"); // 받는사람 이메일
		messageHelper.setSubject("메일전송 test"); // 메일제목은 생략이 가능하다
		messageHelper.setText("내용 test"); // 메일 내용

		mailSender.send(message);
		
	}
	
}



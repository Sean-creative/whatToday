package com.hobby.controller;

import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

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
 
 
  // mailForm
  @RequestMapping(value = "/login/mailForm")
  public String mailForm() {
   
    return "/login/mailForm";
  }  
 
  // mailSending 코드
  @RequestMapping(value = "/mail/mailSending")
  public String mailSending(HttpServletRequest request) {
	log.info("##/mail/mailSending");
    String setfrom = "dnwntjs1531@gmail.com";         
    String tomail  = request.getParameter("tomail");     // 받는 사람 이메일
    String title   = request.getParameter("title");      // 제목
    String content = request.getParameter("content");    // 내용

    try {
      MimeMessage message = mailSender.createMimeMessage();
      message.setSubject(title);
      message.setText(content);
      message.setRecipients(MimeMessage.RecipientType.TO, InternetAddress.parse(tomail));

      
//      MimeMessageHelper messageHelper 
//                        = new MimeMessageHelper(message, true, "UTF-8");
//      messageHelper.setFrom(setfrom);  // 보내는사람 생략하거나 하면 정상작동을 안함
//      messageHelper.setTo(tomail);     // 받는사람 이메일
//      messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
//      messageHelper.setText(content);  // 메일 내용
     
      mailSender.send(message);
    } catch(Exception e){
      System.out.println("##Exception:" + e);
    }
    return "redirect:/login/login";
  }
} 

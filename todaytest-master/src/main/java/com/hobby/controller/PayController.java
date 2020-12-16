package com.hobby.controller;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hobby.security.domain.CustomUser;
import com.hobby.service.LoginService;
import com.hobby.service.PayService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

/**
 * 포인트 결제를 위한 페이지 관리
 * @author jiyeong
 *
 */
@Controller
@Log4j
@RequestMapping("/pay/*")
@AllArgsConstructor
public class PayController {
	
	private PayService service;
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/pointPayment")
	public void pointPayment() {
		log.info("##/pointPayment");
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/pointPayment222")
	public void pointPayment222() {
		log.info("##/pointPaymentTEST!!!!!!!!!!!!");
	}
	
	@ResponseBody
	@RequestMapping(value = "/complete", produces="text/plain")
	public void getPoint(@RequestBody String money) {
		// 결제한 포인트 가져오기
		log.info("##/getPoint");
		System.out.println("paidPoint: " + money );
		
		CustomUser customUser = (CustomUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		Long usrNum = customUser.getUser().getUsrNum();
		
		System.out.println("usrNum: " + usrNum);
		service.pointInsert(usrNum, Long.parseLong(money));
		System.out.println("dd");
		
	}
	
}

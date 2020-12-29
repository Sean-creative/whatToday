package com.hobby.controller;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hobby.security.domain.CustomUser;
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
	@GetMapping("/kakaoPayPayment")
	public void pointPayment(@RequestParam("usrNum") Long usrNum, Model model) {
		log.info("##/pointPayment");
		
		Long userPoint = service.getUserPoint(usrNum);
		
		model.addAttribute("userPoint", userPoint);
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/kakaoPayPayment222")
	public void pointPayment222() {
		log.info("##/kakaoPayPayment222TEST!!!!!!!!!!!!");
	}
	
	@ResponseBody
	@RequestMapping(value = "/complete", produces="text/plain")
	public void getPoint(@RequestBody String money) {
		// 카카오페이로 충전한 포인트 가져와서 db에 충전
		log.info("##/getPoint");
		System.out.println("paidPoint: " + money );
		
		CustomUser customUser = (CustomUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		Long usrNum = customUser.getUser().getUsrNum();
		Long curUsrPoint = customUser.getUser().getUsrPoint();
		Long sum = Long.parseLong(money) + curUsrPoint;
		System.out.println("@@@@sum: " + sum);
		service.pointInsert(usrNum, sum);
	}
	
	// 포인트 결제 요청
	@RequestMapping(value = "/pointPayment")
	public void pointPay() {

		
//		model.addAttribute("payAmount", amount);
//		return "/pay/pointPayment";

	}
	
	@ResponseBody
	@RequestMapping(value = "/point", produces="text/plain")
	public void payPoint(@RequestBody String amount) {
		// ### 포인트 결 제 창 ###
		log.info("##payPoint");
		System.out.println("amount: " + amount);
		CustomUser customUser = (CustomUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		Long usrNum = customUser.getUser().getUsrNum();	
		System.out.println("@@usrNum: " + usrNum);
		// 현재포인트 - amount 해서 다시 db update
		Long currentUserPoint = service.getUserPoint(usrNum);
		Long updatePoint = currentUserPoint -  Long.parseLong(amount);
		System.out.println("updatePoint: " +  updatePoint);
		service.pointInsert(usrNum, updatePoint);
	}
	
	// 사용자가 포인트가 얼마있는지 확인
	@ResponseBody
	@RequestMapping(value = "/check/userpoint", produces="text/plain")
	public String getUserPoint(@RequestBody String usrNum) {
		log.info("##userPoint");
		
		Long userPoint = service.getUserPoint(Long.parseLong(usrNum));
		System.out.println("userPoint: " + userPoint);
		
	
		return userPoint+"";
	}
}

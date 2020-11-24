package com.hobby.controller;
/**
 * 회원가입 / 로그인 / 아이디/비밀번호 찾기 페이지 관리
 * @author jiyeong
 */
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hobby.domain.UserVO;
import com.hobby.service.AccountService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/login/*")
@AllArgsConstructor
public class AccountController {
	
	private AccountService service;
	
	@GetMapping("/login")
	public void login() {
		log.info("##/login");
	}
	
	@GetMapping("/register")
	public void register() {
		log.info("##/register");
	}
	
	@PostMapping("/registerAction")
	public String register(UserVO user) {
		// 회원가입이 성공되면 로그인 페이지로 넘어간다.
		log.info("##/registerAction: " + user);
		service.register(user);
		
		return "redirect:/login/login";
	}
	
	@ResponseBody
	@RequestMapping(value = "/idDuplicateCheck", produces="text/plane")
	public String id_check(@RequestBody String paramData) {
		// 아이디 중복  검사
		String id = service.idDuplicateCheck(paramData);
		
		return id == null ? "-1" : id;
	}
	
	@ResponseBody
	@RequestMapping(value = "/phoneDuplicateCheck", produces="text/plane")
	public String phone_check(@RequestBody String paramData) {
		// 핸드폰 번호 중복 검사
		String phone = service.phoneDuplicateCheck(paramData);
		
		return phone == null ? "-1" : phone;
	}
	
//
//	@GetMapping("/loginSuccess")
//	public void loginSuccess(Authentication auth, Model model) {
//		log.info("##/loginSuccess");
//		CustomUser customUser = (CustomUser) auth.getPrincipal();
//		String usrName = customUser.getUser().getUsrName();
//		model.addAttribute("usrName", usrName);
//	}
	
	@GetMapping("/find")
	public void find() {
		log.info("##/find");
	}
	
	@ResponseBody
	@RequestMapping(value = "/find_id", produces="text/plane")
	public String find_id(@RequestBody Map<String, String> map) {
		// 아이디 찾기
		log.info("##/find_id");
		
		String name = map.get("name");
		String phone = map.get("phone");
		
	    String id = service.findUserId(name, phone);
	    
	    log.info("##find ID:  " + id);
		return id == null ? "-1" : id;
	}
	
	@ResponseBody
	@RequestMapping(value = "/find_pwd", produces="text/plane")
	public String find_pwd(@RequestBody String paramData) {
		// 비밀번호 찾기
		log.info("##/find_pwd");

	    String pwd = service.findUserPwd(paramData);
		log.info("##find pwd:  " + pwd);

		return pwd == null ? "-1" : pwd;
	}
	

}

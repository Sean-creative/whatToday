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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hobby.domain.UserVO;
import com.hobby.service.LoginService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/login/*")
@AllArgsConstructor
public class LoginController {
	
	private LoginService service;
	
	//1 . 로그인 화면 요청
	@GetMapping("/login")
	public void login() {
		log.info("##/login");
	}
	
	// 2. 회원가입 화면 요청
	@GetMapping("/register")
	public void register() {
		log.info("##/register");
	}
	
	// 3-0-1. 아이디 중복  검사
	@ResponseBody
	@RequestMapping(value = "/idDuplicateCheck", produces="text/plain")
	public String id_check(@RequestBody String inputValue) {
		String id = service.idDuplicateCheck(inputValue);
		// 입력한 아이디와 같은게 있으면 해당 아이디를 반환한다.
		return id == null ? null : id;
	}
	
	// 3-0-2. 핸드폰 번호 중복  검사
	@ResponseBody
	@RequestMapping(value = "/phoneDuplicateCheck", produces="text/plain")
	public String phone_check(@RequestBody String inputValue) {
		String phone = service.phoneDuplicateCheck(inputValue);
		// 입력한 핸드폰 번호와 같은게 있으면 해당 핸드폰 번호를 반환한다.
		return phone == null ? null : phone;
	}
	
	// 3. 회원가입 처리
	@PostMapping("/registerAction")
	public String registerAction(UserVO user, RedirectAttributes rtts) {
		
		log.info("##/registerAction: " + user);
		
		// DB에 회원정보가 정상적으로 입력되었는가
		// 회원가입 정보 - 5개 테이블에 입력 됨   
		// 회원가입이 성공되면 로그인 페이지로 넘어간다.
		// 1차 리뷰 : boolean으로 
		if(service.register(user) == 5) {
			// alert로 회원가입 성공 여부 알림
			rtts.addFlashAttribute("registerSuccessMsg", user.getUsrName());
			return "redirect:/login/login";
		// 회원가입이 안되면 다시 회원가입 페이지로 이동
		}else {
			rtts.addFlashAttribute("registerFailMsg", "회원정보를 다시 입력해주세요.");
			return "redirect:/login/register";
		}
	}
	
//	@GetMapping("/loginSuccess")
//	public void loginSuccess(Authentication auth, Model model) {
//		log.info("##/loginSuccess");
//		CustomUser customUser = (CustomUser) auth.getPrincipal();
//		String usrName = customUser.getUser().getUsrName();
//		model.addAttribute("usrName", usrName);
//	}
	
	// 4. 아이디/비밀 번호 찾기 화면 요청
	@GetMapping("/find")
	public void find() {
		log.info("##/find");
	}
	
	// 4-1. 아이디 찾기
	@ResponseBody
	@RequestMapping(value = "/find_id", produces="text/plane")
	public String find_id(@RequestBody Map<String, String> map) {
		log.info("##/find_id");
		
		String inputName = map.get("name");
		String inputPhone = map.get("phone");
		
	    String id = service.findUserId(inputName, inputPhone);
	    
	    // 사용자가 입력한 이름과 핸드폰번호로 사용자의 아이디를 찾는데 
	    // 사용자의 아이디가 있으면 사용자의 아이디를 반환한다.
	    // 1차 리뷰 : 리턴을 빈문자열로 
	    log.info("##/find ID:  " + id);
		return id == null ? null : id;
	}

	// 4-2. 비밀번호 찾기
	@ResponseBody
	@RequestMapping(value = "/find_pwd", produces="text/plane")
	public String find_pwd(@RequestBody String inputEmail) {
		
		log.info("##/find_pwd");

		String result = "";
	    String pwd = service.findUserPwd(inputEmail);
		log.info("##/find pwd:  " + pwd);
		
		// 사용자가 입력한 이메일(아이디)로 사용자의 비밀번호를 찾는다.		
		// 1. 비밀번호가 있으면
		if(pwd!=null) {
			//1-1. 비밀번호를 입력한 사용자 이메일로 보낸다.
			if(service.sendPassword(inputEmail, pwd)){
				// 1차리뷰: result enum 처리 어떤가???
				result = "1";
			}// 1-2. 메일 보내기에 실패하면 "-1"를 반환한다.
			else {
				result = "-1";
			}
		}
		// 2. 비밀번호가 없으면 "0"을 반환한다.
		else {
			return "0";
		}
		return result;
	}
	
}

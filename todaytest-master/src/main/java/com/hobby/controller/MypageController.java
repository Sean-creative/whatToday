package com.hobby.controller;


import java.security.Principal;
/**
 * 작성자 : 국민성
 */
import java.util.List;




import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;


import com.hobby.domain.CategoryVO;
import com.hobby.domain.ClubVO;
import com.hobby.domain.UserVO;
import com.hobby.security.domain.CustomUser;
import com.hobby.service.MypageService;


import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/account/*")
@SessionAttributes("userVO")
@AllArgsConstructor
@Log4j
public class MypageController {

	@Setter(onMethod_ = @Autowired)
	private MypageService service;

	
	//메인페이지
	@GetMapping("/main")
	public String main(Model model,Authentication auth) {
		
		String url = "/account/main";
		//0. 만일 로그인이 되어 있지 않은데 주소로 이곳을 접속하려고하면, login page로 redirect시켜버림
		log.info("##/main");		
		if(auth == null) {
			url =  "redirect:/login/login";
		}
		//기본적인 사용자의 정보를 보여줌 : 회원 ID/이름/전화번호  현재가입모임/가입대기모임/이전에가입한모임
		//1. 회원 정보를 가져온다 -> 로그인을 하면 생기는 Authentication 통하여 회원정보를 가져옴
		CustomUser customUser = (CustomUser) auth.getPrincipal();
		Long usrNum = customUser.getUser().getUsrNum();
		//1.1 가져온 회원 정보를 view에 쏴줌
		model.addAttribute("userVO",service.getUser(customUser.getUser().getUsrId()));
		
		//2. 회원정보를 통해서 현재가입모임/가입대기모임/이전에가입한모임을 가져오고 view에 쏴줌
		model.addAttribute("myClub",service.getMyClubList(usrNum));
		model.addAttribute("waitClub",service.getWaitClubList(usrNum));
		model.addAttribute("prevClub",service.getPrevClubList(usrNum));
		
		return url;
	} 
	
	//회원정보수정하게되면 비밀번호를 재입력받는 페이지
	//auth_leave 페이지랑 통합하는 방법을 생각해볼것
	@GetMapping("/auth_edit") 
	public String auth_edit(Authentication auth) {
		
		String url = "/account/auth_edit";
		//0. 만일 로그인이 되어 있지 않은데 주소로 이곳을 접속하려고하면, login page로 redirect시켜버림
		log.info("##/auth_edit");		
		if(auth == null) {
			url = "redirect:/login/login";
		}

		return url;
	}
	
	//비밀번호 유효성 검사
	@PostMapping("/authAction")
	public String authAction(Authentication auth, @RequestParam("password")String password, Model model) {
		String url = "redirect:/account/auth_edit";
		
		//0. 만일 로그인이 되어 있지 않은데 주소로 이곳을 접속하려고하면, login page로 redirect시켜버림
		//postmapping이라 필요한지는 모르겠는데 일단 넣어둠
		log.info("##/authAction");		
		if(auth == null) {
			url = "redirect:/login/login";
		}

		//1. DB에 있는 비밀번호와 사용자가 입력한 비밀번호를 비교하기위해 회원 정보를 가져온다.
		CustomUser customUser = (CustomUser) auth.getPrincipal();
		UserVO userVO = service.getUser(customUser.getUser().getUsrId());
		System.out.println(userVO);
		
		//2. 비밀번호 유효성검사, DB와 비교해서 맞는지 Check하고 수정페이지로 보냄
		if(service.isPwdValid(password) && 
				service.findPwdInDB(password, userVO.getUsrPwd())) {
			url = "forward:/account/edit";
		}

		return url;
	}
	
	//회원정보 수정페이지
	@PostMapping("/edit")
	public String edit(Authentication auth, Model model){
		
		String url = "/account/edit";
		
		//0. 만일 로그인이 되어 있지 않은데 주소로 이곳을 접속하려고하면, login page로 redirect시켜버림
		//postmapping이라 필요한지는 모르겠는데 일단 넣어둠
		log.info("##/edit");		
		if(auth == null) {
			url = "redirect:/login/login";
		}
		
		//1. view에 뿌려줄 회원정보를 가져옴
		CustomUser customUser = (CustomUser) auth.getPrincipal();
		UserVO userVO = service.getUser(customUser.getUser().getUsrId());
		System.out.println(userVO);
		
		//2. 회원정보를 담아서 줌
		model.addAttribute("userVO",userVO);
		
		return url;
	}
	
	//edit에서 전해준것들 유효성 검사, 업데이트
	//주말중에 들어오는 정보들 유효성검사를 추가할것
	@PostMapping("/editAction")
	public String editAction(Authentication auth, Model model, UserVO userVO) {
		
		String url = "redirect:/account/main";
		//0. 만일 로그인이 되어 있지 않은데 주소로 이곳을 접속하려고하면, login page로 redirect시켜버림
		//postmapping이라 필요한지는 모르겠는데 일단 넣어둠
		log.info("##/editAction");		
		if(auth == null) {
			url = "redirect:/login/login";
		}
		//1. edit에서 UserVO의 정보들을 보낸것을 통하여 업데이트가 필요한 테이블들을 업데이트
		service.updateUserInfoAndName(userVO);
		
		return url;
		}
	
	//비밀번호 변경 페이지
	@GetMapping("/password")
	public String password(Authentication auth) {
		String url = "/account/password";
		
		//0. 만일 로그인이 되어 있지 않은데 주소로 이곳을 접속하려고하면, login page로 redirect시켜버림
		log.info("##/password");		
		if(auth == null) {
			url = "redirect:/login/login";
		}
		return url;
	}
	
	//비밀번호 변경 유효성검사
	@PostMapping("/passwordAction")
	public String passwordAction(Authentication auth,
			@RequestParam("newPassword") String newPassword,
			@RequestParam("currentPassword") String currentPassword) {

		String url = "/account/passwordAction";
		//0. 만일 로그인이 되어 있지 않은데 주소로 이곳을 접속하려고하면, login page로 redirect시켜버림
		//postmapping이라 필요한지는 모르겠는데 일단 넣어둠
		log.info("##/editAction");		
		if(auth == null) {
			url = "redirect:/login/login";
		}
		//1. DB에 있는 비밀번호와 사용자가 입력한 비밀번호를 비교하기위해 회원 정보를 가져온다.
		CustomUser customUser = (CustomUser) auth.getPrincipal();
		UserVO userVO = service.getUser(customUser.getUser().getUsrId());
		
		//2. 비밀번호 유효성검사, DB와 비교해서 맞는지 Check
		//2-1 맞으면 유저정보에 비밀번호를 업데이트하고 마이페이지 메인으로 보냄
		if(service.isPwdValid(newPassword) &&
				service.isPwdValid(currentPassword)
				&& service.findPwdInDB(currentPassword, userVO.getUsrPwd())) {
			userVO.setUsrPwd(newPassword);
			service.updateUserInfo(userVO);
			
			url = "redirect:/account/main";
		}
		//2-2 만일 유효성검사에 실패하면 password변경페이지로 보내버림
			url = "redirect:/account/password";
			
		return url;
	}
	
	//회원탈퇴 비밀번호 입력페이지
	@GetMapping("/auth_leave") 
	public String auth_leave(Authentication auth) {
		
		String url = "/account/auth_leave";	
		//0. 만일 로그인이 되어 있지 않은데 주소로 이곳을 접속하려고하면, login page로 redirect시켜버림
		log.info("##/password");		
		if(auth == null) {
			url = "redirect:/login/login";
		}
		return url;
	}
	
	//탈퇴하면 유저 상태를 사이트탈퇴로 바꾸고 main이나 login 페이지로 이동하게
	@PostMapping("/leaveAction")
	public String leaveAction(Authentication auth, @RequestParam("password")String password, 
			 Model model) {
		CustomUser customUser = (CustomUser) auth.getPrincipal();
		UserVO userVO = service.getUser(customUser.getUser().getUsrId());
		String url = "/account/auth_leave";
		
		if(service.isPwdValid(password) && 
				service.findPwdInDB(password, userVO.getUsrPwd())) {
			userVO.setUsrState("사이트탈퇴");
			service.updateUserInfo(userVO);
			service.insertUserHistory(userVO);
			service.leaveSite(userVO);
			url = "redirect:/login/logout";
		}

		return url;
	}
	
	//모임관리 메인페이지
	//모임 수정버튼누르면 -> 모임페이지에서 수정하도록
	//모임 탈퇴누르면 -> 탈퇴하도록 구현해야함
	//아직 버튼 이동경로 몰라서 안함
	@PostMapping("/myclub/main")
	public void myclubMain(Authentication auth, Model model) {
		CustomUser customUser = (CustomUser) auth.getPrincipal();
		UserVO userVO = service.getUser(customUser.getUser().getUsrId());
		model.addAttribute("clubVO",service.getMyCreateClubList(userVO.getUsrNum()));
	
	}
	
	//ajax로 내가 만든 모임을 가져옴
	@RequestMapping(value = "/myclub/club/{cbLeaderNum}",
			produces = { MediaType.TEXT_XML_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<List<ClubVO>>getMyCreateClubList(@PathVariable("cbLeaderNum") Long cbLeaderNum,
			Authentication auth) {
		log.info("get...........: " + cbLeaderNum);
		CustomUser customUser = (CustomUser) auth.getPrincipal();
		UserVO userVO = service.getUser(customUser.getUser().getUsrId());
		return new ResponseEntity<>(service.getMyCreateClubList(userVO.getUsrNum()),HttpStatus.OK);
	}
	
	
	//ajax로 내가 가입한 클럽 리스트 db 가져옴
	@RequestMapping(value = "/myclub/club/{cbNum}",
			produces = { MediaType.TEXT_XML_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<ClubVO>getMyClublist(@PathVariable("cbNum") Long cbNum,
			Authentication auth) {
		log.info("get...........: " + cbNum);
		CustomUser customUser = (CustomUser) auth.getPrincipal();
		UserVO userVO = service.getUser(customUser.getUser().getUsrId());
		return new ResponseEntity<>(service.getMyClublist(cbNum),HttpStatus.OK);
	}
	
	//ajax로 카테고리 db 가져옴
	@RequestMapping(value = "/categorylist/{catClassificationCode}",
			produces = { MediaType.TEXT_XML_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<List<CategoryVO>>getCategorylist(@PathVariable("catClassificationCode") String catClassificationCode,
			Principal principal) {
		log.info("get...........: " + catClassificationCode);
		
		return new ResponseEntity<>(service.getCategoryList(catClassificationCode),HttpStatus.OK);
	}

}
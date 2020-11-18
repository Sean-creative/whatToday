package com.hobby.controller;


import java.security.Principal;
/**
 * 작성자 : 국민성
 */
import java.util.List;

import javax.servlet.http.HttpSession;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

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

	
	@RequestMapping("list")
	public void list(Model model,SessionStatus sessionStatus,HttpSession session) {
		
		model.addAttribute("list", service.getUserList());

	}
	
	
	@RequestMapping("/main")
	public void main(Model model,Authentication auth) {
		
		log.info("##/main");
		CustomUser customUser = (CustomUser) auth.getPrincipal();
		Long usrNum = customUser.getUser().getUsrNum();
		model.addAttribute("userVO",service.getUser(customUser.getUser().getUsrId()));
		model.addAttribute("myClub",service.getMyClubList(usrNum));
		model.addAttribute("waitClub",service.getWaitClubList(usrNum));
		model.addAttribute("prevClub",service.getPrevClubList(usrNum));
		
	} 
	
	@RequestMapping("/auth_edit") 
	public void auth_edit(Principal principal) {
		
	}
	
	@PostMapping("/authAction")
	public String authAction(Authentication auth, @RequestParam("password")String password, Model model) {
		
		String url = "redirect:/account/auth_edit";
		
		CustomUser customUser = (CustomUser) auth.getPrincipal();
		UserVO userVO = service.getUser(customUser.getUser().getUsrId());
		System.out.println(userVO);
		if(service.isPwdValid(password) && 
				service.findPwdInDB(password, userVO.getUsrPwd())) {
			url = "forward:/account/edit";
		}

		return url;
	}
	@RequestMapping(value = "/{catClassificationCode}",
			produces = { MediaType.TEXT_XML_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<List<CategoryVO>>getCategorylist(@PathVariable("catClassificationCode") String catClassificationCode,
			Principal principal) {
		log.info("get...........: " + catClassificationCode);
		
		return new ResponseEntity<>(service.getCategoryList(catClassificationCode),HttpStatus.OK);
	}
	
	
	@PostMapping("/edit")
	public void edit(Authentication auth, Model model){
		CustomUser customUser = (CustomUser) auth.getPrincipal();
		UserVO userVO = service.getUser(customUser.getUser().getUsrId());
		System.out.println(userVO);
		model.addAttribute("userVO",userVO);
	}
	
	@PostMapping("/editAction")
	public String editAction(Authentication auth, Model model, UserVO updateUser) {
		
		CustomUser customUser = (CustomUser) auth.getPrincipal();
		UserVO userVO = service.getUser(customUser.getUser().getUsrId());
		
		

		service.updateClubFounderName(updateUser);
		service.updateUserInfo(updateUser);
		service.updateClubMemberUpdate(updateUser);
		service.updateNameUserHistory(updateUser);
		service.updateMeetingMemberName(updateUser);
		service.updateUserDetail(updateUser);
		
		return "redirect:/account/main";
		}
	@RequestMapping("/password")
	public void password(Authentication auth) {
		log.info("##/password");
		
	}
	@PostMapping("/passwordAction")
	public String passwordAction(Authentication auth,
			@RequestParam("newPassword") String newPassword,@RequestParam("currentPassword") String currentPassword) {
		log.info("##/passwordAction");
		String url = "/account/password";
		CustomUser customUser = (CustomUser) auth.getPrincipal();
		String usrId = customUser.getUser().getUsrId();
		UserVO userVO = service.getUser(usrId);
		if(service.isPwdValid(newPassword) &&
				service.isPwdValid(currentPassword)
				&& service.findPwdInDB(currentPassword, userVO.getUsrPwd())) {
			userVO.setUsrPwd(newPassword);
			service.updateUserInfo(userVO);
			
			url = "/account/main";
		}	
		
		return url;
	}
	
	@RequestMapping("/auth_leave") 
	public void auth_leave(Authentication auth) {
	}
	
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
			url = "redirect:/login/login";
		}

		return url;
	}
	@PostMapping("/myclub/main")
	public void myclubMain(Authentication auth, Model model) {
		CustomUser customUser = (CustomUser) auth.getPrincipal();
		UserVO userVO = service.getUser(customUser.getUser().getUsrId());
		model.addAttribute("clubVO",service.getMyCreateClubList(userVO.getUsrNum()));
	
	}
	@RequestMapping(value = "/myclub/{cbLeaderNum}",
			produces = { MediaType.TEXT_XML_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<List<ClubVO>>getlist(@PathVariable("cbLeaderNum") Long cbLeaderNum,
			Authentication auth) {
		log.info("get...........: " + cbLeaderNum);
		CustomUser customUser = (CustomUser) auth.getPrincipal();
		UserVO userVO = service.getUser(customUser.getUser().getUsrId());
		return new ResponseEntity<>(service.getMyCreateClubList(userVO.getUsrNum()),HttpStatus.OK);
	}
	
//	@PostMapping("/myclub/regularEdit")
//	public void regularEdit(ClubVO clubVO, Model model) {
//
//	}
//	@PostMapping("/myclub/thunderEdit")
//	public void thunderEdit(ClubVO clubVO, Model model) {
//
//	}
}
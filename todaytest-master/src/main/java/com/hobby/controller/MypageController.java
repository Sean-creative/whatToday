package com.hobby.controller;



import java.util.List;

import javax.servlet.http.HttpSession;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.hobby.domain.CategoryVO;
import com.hobby.domain.ClubVO;
import com.hobby.domain.UserVO;
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
	public void main(UserVO userVO, Model model,HttpSession session,String usrId) {
		
		System.out.println("@@@@@@@@@@@@@@@@@@@@@@@\n\n\n\n\n\n"+usrId+"\n\n\n\n\n");

		Long usrNum = service.getUser(usrId).getUsrNum();
		model.addAttribute("userVO",service.getUser(userVO.getUsrId()));

		model.addAttribute("myClub",service.getMyClubList(usrNum));
		model.addAttribute("waitClub",service.getWaitClubList(usrNum));
		model.addAttribute("prevClub",service.getPrevClubList(usrNum));
	} 
	
	@RequestMapping("/auth_edit") 
	public void auth_edit(@SessionAttribute("userVO") UserVO userVO) {
	}
	
	@PostMapping("/authAction")
	public String authAction(@SessionAttribute("userVO")UserVO userVO, @RequestParam("password")String password, Model model) {
		
		String url = "redirect:/account/auth_edit";
		
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
			@SessionAttribute("userVO")UserVO userVO) {
		log.info("get...........: " + catClassificationCode);
		
		return new ResponseEntity<>(service.getCategoryList(catClassificationCode),HttpStatus.OK);
	}
	
	
	@PostMapping("/edit")
	public void edit(@SessionAttribute("userVO")UserVO userVO){
		
	}
	
	@PostMapping("/editAction")
	public String editAction(UserVO userVO, Model model) {

		System.out.println(userVO);
		System.out.println(userVO.getUsrCategory1());
		System.out.println(userVO.getUsrCategory2());
		
		service.updateClubFounderName(userVO);
		service.updateUserInfo(userVO);
		service.updateClubMemberUpdate(userVO);
		service.updateNameUserHistory(userVO);
		service.updateMeetingMemberName(userVO);
		service.updateUserDetail(userVO);

		
		model.addAttribute("id",userVO.getUsrId());
		
		return "/account/main";
		}
	@RequestMapping("/password")
	public void password(@SessionAttribute("userVO")UserVO userVO) {

	}
	@PostMapping("/passwordAction")
	public String passwordAction(@SessionAttribute("userVO")UserVO userVO,
			@RequestParam("newPassword") String newPassword,@RequestParam("currentPassword") String currentPassword) {
		
		String url = "/account/password";
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
	public void auth_leave(@SessionAttribute("userVO") UserVO userVO, Model model) {
	}
	
	@PostMapping("/leaveAction")
	public String leaveAction(@SessionAttribute("userVO")UserVO userVO, @RequestParam("password")String password, 
			SessionStatus sessionStatusion, Model model) {
		
		String url = "/account/auth_leave";
		
		if(service.isPwdValid(password) && 
				service.findPwdInDB(password, userVO.getUsrPwd())) {
			userVO.setUsrState("�궗�씠�듃�깉�눜");
			service.updateUserInfo(userVO);
			service.insertUserHistory(userVO);
			sessionStatusion.setComplete();
			url = "redirect:/account/list";
		}

		return url;
	}
	@PostMapping("/myclub/main")
	public void myclubMain(@SessionAttribute("userVO")UserVO userVO, Model model) {
		
		model.addAttribute("clubVO",service.getMyCreateClubList(userVO.getUsrNum()));
	
	}
	@RequestMapping(value = "/myclub/{cbLeaderNum}",
			produces = { MediaType.TEXT_XML_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<List<ClubVO>>getlist(@PathVariable("cbLeaderNum") Long cbLeaderNum,
			@SessionAttribute("userVO")UserVO userVO) {
		log.info("get...........: " + cbLeaderNum);
		
		return new ResponseEntity<>(service.getMyCreateClubList(userVO.getUsrNum()),HttpStatus.OK);
	}
	
	@PostMapping("/myclub/regularEdit")
	public void regularEdit(ClubVO clubVO, Model model) {

	}
	@PostMapping("/myclub/thunderEdit")
	public void thunderEdit(ClubVO clubVO, Model model) {

	}
}
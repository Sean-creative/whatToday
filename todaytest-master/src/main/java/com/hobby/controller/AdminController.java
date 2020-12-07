package com.hobby.controller;

import java.util.List;

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
import org.springframework.web.bind.annotation.RequestMethod;

import com.hobby.domain.ClubVO;
import com.hobby.domain.UserVO;
import com.hobby.service.AdminService;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/admin/*")
@AllArgsConstructor
@Log4j
public class AdminController {
	
	
	@Setter(onMethod_ = @Autowired)
	private AdminService service;
	
	
	@GetMapping("/usermanage")
	public void register() {
		log.info("usermanage");

	}

	@GetMapping("/banAction")
	public String banAction(String usrId) {
		
		service.updateBanUser(usrId);
		service.insertUserHistory(service.getUser(usrId));
		service.updateUserAuth(service.getUser(usrId));
		return "redirect:/admin/usermanage";
	}
	
	@GetMapping("/banLeaveUser")
	public void banLeaveUser(Model model) {
		
		model.addAttribute("userVO",service.getBanLeaveUser());
		
	}
	
	@GetMapping("/clubmanage")
	public void clubmanage(Model model) {
		model.addAttribute("clubVO",service.getClubList());
	}

	
	@RequestMapping(value = "/usermanage/userlist.json", produces = { MediaType.TEXT_XML_VALUE,
			MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<List<UserVO>> getUserList() {
	
	return new ResponseEntity<>(service.getUserList(),HttpStatus.OK);
	}
	@RequestMapping(method = {RequestMethod.PUT,RequestMethod.PATCH},
			value = "/usermanage/updateBanUser", consumes = "application/json",
			produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> updateBanUser(
			@RequestBody UserVO userVO) {
		
		System.out.println(userVO);
	
	return service.updateBanUser(userVO.getUsrId()) == 1
			? new ResponseEntity<>("success",HttpStatus.OK)
					:new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);	
	}
	
	@RequestMapping(method = {RequestMethod.PUT,RequestMethod.PATCH},
			value = "/clubmanage/updateClubLeader", consumes = "application/json",
			produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> updateClubLeader(
			@RequestBody ClubVO clubVO) {
		System.out.println(clubVO);
	
	return service.updateClubLeader(clubVO) == 1
			? new ResponseEntity<>("success",HttpStatus.OK)
					:new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);	
	}
	
	@RequestMapping(method = {RequestMethod.PUT,RequestMethod.PATCH},
			value = "/clubmanage/shutClub", consumes = "application/json",
			produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> shutClub(
			@RequestBody ClubVO clubVO) {
		
		System.out.println(clubVO);
	
	return service.shutClub(clubVO.getCbNum()) == 1
			? new ResponseEntity<>("success",HttpStatus.OK)
					:new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);	
	}
	
	@RequestMapping(value = "/clubmanage/clublist.json", produces = { MediaType.TEXT_XML_VALUE,
			MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<List<ClubVO>> getClubList() {	
	return new ResponseEntity<>(service.getClubList(),HttpStatus.OK);
	}
	
	@RequestMapping(value = "/clubmanage/clubmemberlist/{cbNum}.json", produces = { MediaType.TEXT_XML_VALUE,
			MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<List<UserVO>> getClubMemberList(@PathVariable("cbNum") Long cbNum) {
	
	return new ResponseEntity<>(service.getClubMemberList(cbNum),HttpStatus.OK);
	}
	
	@PostMapping(value="/usermanage/insertUserHistory",
	consumes="application/json",
	produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> insertUserHistory(@RequestBody UserVO userVO){
		
		return service.insertUserHistory(userVO) == 1
				? new ResponseEntity<>("success", HttpStatus.OK)
						: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	

}

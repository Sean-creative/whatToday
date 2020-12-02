package com.hobby.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;


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
	public void register(Model model) {
		log.info("usermanage");
		
		model.addAttribute("userVO",service.getUserList());
		
	}

	@GetMapping("/banAction")
	public String banAction(Long usrNum) {
		
		service.updateBanUser(usrNum);
		
		return "redirect:/admin/usermanage";
	}
	
	@GetMapping("/banLeaveUser")
		public void banLeaveUser(Model model) {
		
			model.addAttribute("userVO",service.getBanLeaveUser());
			
		}

	
	@RequestMapping(value = "/usermanage/userlist", produces = { MediaType.TEXT_XML_VALUE,
			MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<List<UserVO>> getUserList() {
	
	return new ResponseEntity<>(service.getUserList(),HttpStatus.OK);
	}
}

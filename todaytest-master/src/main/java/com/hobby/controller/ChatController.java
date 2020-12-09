package com.hobby.controller;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.hobby.security.domain.CustomUser;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
public class ChatController {
	@RequestMapping(value = "/chat", method = RequestMethod.GET)
	public void chat(Model model) {
		log.info("##/chat");
	
	}
	

	@RequestMapping(value = "/chat22", method = RequestMethod.GET)
	@PreAuthorize("isAuthenticated()")
	public void chat22(Model model) {
		log.info("##/chat22");
	
		CustomUser customUser = (CustomUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String name = customUser.getUser().getUsrName();
		
		log.info("username:chat22" + name);
		model.addAttribute("usrName", name);
	}
}
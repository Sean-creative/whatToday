package com.hobby.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hobby.service.MainService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/index/*")
@AllArgsConstructor
public class MainController {
	
	private MainService service;
	
	@GetMapping("/main")
	public void main(Model model) {
		log.info("main");
		model.addAttribute("main", service.getListRegular());
		model.addAttribute("main2", service.getListThunder());
	}
}

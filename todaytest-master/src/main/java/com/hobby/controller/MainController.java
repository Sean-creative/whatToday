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
	//모델을통해서 뷰에 데이터 전달하기 
	public void mainList(Model model) {
		log.info("main");
		//service.getListRegular(정기모임리스트)를main이라는 이름을 통해 뷰에 보내준다.
		model.addAttribute("main", service.getListRegular());
		//service.getListThunder(번개모임리스트)를 main2라는 이름을 통해서 뷰에 보내준다.
		model.addAttribute("main2", service.getListThunder());
	}
}
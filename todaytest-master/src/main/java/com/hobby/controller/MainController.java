package com.hobby.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hobby.domain.Criteria;
import com.hobby.domain.PageDTO;
import com.hobby.service.ClubService;
import com.hobby.service.MainService;
import com.hobby.service.ThunderService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/index/*")
@AllArgsConstructor
public class MainController {
	
	private MainService service;
	private ThunderService thunderService;
	private ClubService clubService;
	
	@GetMapping("/main")
	//모델을통해서 뷰에 데이터 전달하기 
	public void mainList(Model model) {
		log.info("main");
		//service.getListRegular(정기모임리스트)를main이라는 이름을 통해 뷰에 보내준다.
		model.addAttribute("main", service.getListRegular());
		//service.getListThunder(번개모임리스트)를 main2라는 이름을 통해서 뷰에 보내준다.
		model.addAttribute("main2", service.getListThunder());
	}
	
	//번개 검색결과 보여주기 
	@GetMapping("/searchlist")
	public void list( Criteria cri, Model model) {
		cri.setAmount(12);
		
		//번개 
		log.info("/list - GET");
		log.info("list - cri : " + cri);
		
		model.addAttribute("list", thunderService.getListWithPaging(cri));
		
		log.info("list : " + thunderService.getListWithPaging(cri));
		
		//정기 		
		log.info("clublist");
	    log.info("list - cri : " + cri);
	     // cri에 들어있는 조건 대로, club 정보를 가져온다.
	    model.addAttribute("clublist", clubService.getList(cri));   
	    log.info("list : " + clubService.getList(cri));
	}
	
	
	
}
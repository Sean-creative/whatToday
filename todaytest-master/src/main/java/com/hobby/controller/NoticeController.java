package com.hobby.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import com.hobby.service.NoticeService;
@Controller
@Log4j
@RequestMapping("/cs/*")
@AllArgsConstructor
public class NoticeController {
	
	private NoticeService service;
	
	
	
	
}

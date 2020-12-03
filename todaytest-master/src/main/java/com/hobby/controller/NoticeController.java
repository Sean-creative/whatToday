package com.hobby.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hobby.domain.NoticeVO;
import com.hobby.service.NoticeService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/admin/*")
@AllArgsConstructor
public class NoticeController {
	
	private NoticeService service;
	
	@GetMapping("/register")
	public void registerNotice() {
		log.info("registerNoticeGetMapping.....!!!!!\n\n\n" );
	}
	
	@PostMapping("/register")
	public String registerNotice(NoticeVO notice, RedirectAttributes rttr) {
		
		log.info("registerPostMapping....!!!!!\\n\\n\\n" +notice);
		
		service.registerNotice(notice);
		
		rttr.addFlashAttribute("result",notice.getNtNum());
		
		return "redirect:/cs/faq";
	}
	
	@PostMapping("/modify")
	public String modify(@RequestParam("ntNum")Long ntNum, RedirectAttributes rttr) {
		log.info("modify"+ntNum);
		
		if(service.updateNotice(ntNum)) {
			rttr.addFlashAttribute("result","success");
		}
		return "redirect:/cs;/faq";
	}
//	
//	@PostMapping("/remove")
//	public String remove(@RequestParam("ntNum")Long ntNum, RedirectAttributes rttr) {
//		log.info("remove"+ntNum);
//		if (service.deleteNotice(ntNum)) {
//			rttr.addFlashAttribute("result","success");
//		}
//		return "redirect:/cs/faq";
//	}
	
	
}

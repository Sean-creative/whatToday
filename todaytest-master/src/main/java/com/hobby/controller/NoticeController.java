package com.hobby.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hobby.domain.NoticeCri;
import com.hobby.domain.NoticeDTO;
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
		
		return "redirect:/admin/notice";
	}
	
	// 공지사항 + 페이징처리 
	@GetMapping("/notice")
	public void noticeRead(NoticeCri cri, Model model) {
			
		log.info("###paging:"+cri);
		model.addAttribute("noticeList",service.noticeList(cri));
		model.addAttribute("pageMaker", new NoticeDTO(cri,123));
	}
		
	@GetMapping("/noticepage")
	public void noticePage(@RequestParam("ntNum") Long ntNum, Model model) {
			
		model.addAttribute("noticePage",service.noticeContent(ntNum));
		model.addAttribute("ntNum",ntNum);
		log.info("#####noticePage");
	}
	
	
	//공지사항 수정 
	@GetMapping("/modify")
	public void get(@RequestParam("ntNum") Long ntNum, Model model) {
		log.info("#####modifyGetMapping....");
		model.addAttribute("notice",service.getNotice(ntNum));
		System.out.println("service.getNotice(ntNum)"+service.getNotice(ntNum));
		System.out.println("service.noticeContent(ntNum)"+service.noticeContent(ntNum));
		model.addAttribute("noticeContent",service.noticeContent(ntNum));

	}
	
	@PostMapping("/modify")
	public String modify(NoticeVO notice, RedirectAttributes rttr) {
		
		log.info("######modifyPostMapping....!!!!!\\\\n\\\\n\\\\n"+notice);
		
		if(service.updateNotice(notice) == 2) {
			rttr.addFlashAttribute("result","success");
		}
		return "redirect:/admin/notice";
	}
	
	@PostMapping("/remove")
	public String remove(@RequestParam("ntNum")Long ntNum, RedirectAttributes rttr) {
		log.info("remove"+ntNum);
		if (service.deleteNotice(ntNum)) {
			rttr.addFlashAttribute("result","success");
		}
		return "redirect:/admin/notice";
	}
	
	
}

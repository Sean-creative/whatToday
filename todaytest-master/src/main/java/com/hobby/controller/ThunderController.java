package com.hobby.controller;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hobby.domain.ThunderVO;
import com.hobby.domain.Criteria;
import com.hobby.domain.PageDTO;
import com.hobby.domain.UserVO;
import com.hobby.service.ThunderService;
import com.hobby.service.UserService;

import lombok.AllArgsConstructor;	
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/thunder/*")
@AllArgsConstructor
public class ThunderController {

	private ThunderService service;
	private UserService userService;

	@RequestMapping(value = "/index", method = { RequestMethod.GET, RequestMethod.POST })
	public void index() {
		log.info("INDEX!!!!!!");
	}

	
	@GetMapping({"/info", "/modify"})
	public void info(@RequestParam("cbNum") Long cbNum, @ModelAttribute("cri") Criteria cri, Model model) {
		
		//url에 pk값이 붙는게 싫지만, 우선 해결방법은 못찾음
				//REDIRECT로 받아서 POST로 받는 방법은?
				log.info("/info or modify");
				log.info(" cri : \n\n" + cri);
				
				log.info("cbNum : " + cbNum);
				
				// A. list에서의 이동
				// A.1 list에서 해당 DIV를 클릭했을 때 이동이 되면서, 파마리터 형식으로 cl_number이 붙는다.
				ThunderVO clubVO = service.get(cbNum);
				log.info("clubVO : " + clubVO);
						
				//A.2 파라미터로 넘어온 값인, cbNum를 통해서 작성의 정보를 가져온다.
				UserVO userVO = userService.get((long) clubVO.getCbLeaderNum());
				log.info("userVO : " + userVO);
				
				
				//A.3 작성자의 정보를  view단에 뿌려준다.
				model.addAttribute("userVO", userVO);
								
//				clubVO.setCl_current_number(11);
				model.addAttribute("clubVO", clubVO);
	}
	
	
	@PostMapping("/modify")
	public String modify(ThunderVO Club, @ModelAttribute("cri") Criteria cri,  RedirectAttributes rttr) {
		log.info("modify : " + Club);
		
		if(service.modify(Club)) {
			rttr.addFlashAttribute("result", "success");
				}
		
//		rttr.addAttribute("pageNum", cri.getPageNum());
//		rttr.addAttribute("amount", cri.getAmount());
//		rttr.addAttribute("type", cri.getType());
//		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/thunder/list" + cri.getListLink();
	}
	
	@PostMapping("/remove")
	public String remove(@RequestParam("cbNum") Long cbNum, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		log.info("remove...." + cbNum);
		
		if(service.remove(cbNum)) {
			rttr.addFlashAttribute("result", "success");
		}
		
//		rttr.addAttribute("pageNum", cri.getPageNum());
//		rttr.addAttribute("amount", cri.getAmount());
//		rttr.addAttribute("type", cri.getType());
//		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/thunder/list"+ cri.getListLink();
	}
	
	
	

	@PostMapping("/add")
	public String add(ThunderVO clubVO, RedirectAttributes rttr) {
		
		log.info("add : " + clubVO);
		
		service.register(clubVO);
		log.info("add : \n\n\n" + clubVO.getCbNum() + "\n\n\n");
				
		rttr.addAttribute("cbNum", clubVO.getCbNum());
		return "redirect:/thunder/list";
	}

	
	@GetMapping("/add")
	public void add() {
		log.info("add GetMapping!!");
	}

	
	@GetMapping("/list")
	public void list( Criteria cri, Model model) {
		log.info("list : " + cri);
		model.addAttribute("list", service.getList(cri));

		int total = service.getTotal(cri);
		log.info("total: " + total);
		
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
}

package com.hobby.controller;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hobby.domain.Criteria;
import com.hobby.domain.PageDTO;
import com.hobby.domain.ThunderVO;
import com.hobby.domain.UserVO;
import com.hobby.security.domain.CustomUser;
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
	public void info(Authentication auth, @RequestParam("cbNum") Long cbNum, @ModelAttribute("cri") Criteria cri, Model model) {
		
		CustomUser customUser = (CustomUser) auth.getPrincipal();
	      UserVO userVO2 = customUser.getUser();	      
	      log.info("##/add 회원번호" + userVO2.getUsrNum());
	      //B. 로그인한 사람의 번호도 뿌려줘서, jsp단에서 로그인 되어있는 사람들에게만 modify 버튼 보여주기 -- 개선사항
	      	model.addAttribute("usrNum", userVO2.getUsrNum());
	      
	      
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
	public String add(Authentication auth, ThunderVO clubVO, RedirectAttributes rttr) {

		CustomUser customUser = (CustomUser) auth.getPrincipal();
	    Long usrNum = customUser.getUser().getUsrNum();
	    log.info("POST-add 회원번호" + usrNum);
	    clubVO.setCbLeaderNum(usrNum);
	    clubVO.setCbLeaderName(customUser.getUser().getUsrName());
	      
		log.info("add : " + clubVO);
		
		service.register(clubVO);
		log.info("add : \n\n\n" + clubVO.getCbNum() + "\n\n\n");
				
		rttr.addAttribute("cbNum", clubVO.getCbNum());
		return "redirect:/thunder/list";
	}

	
	
	@GetMapping("/add")
	//로그인 안한상태에서, 개설 누르면 그냥 튕김 -- 수정 사항 -> 튕기지 않고, 경고문으로 해결하도록
	public void add(Authentication auth, Model model) {
		log.info("add GetMapping!!");
		
		  CustomUser customUser = (CustomUser) auth.getPrincipal();
	      UserVO userVO = customUser.getUser();	      
	      log.info("##/add 회원번호" + userVO.getUsrNum());
	      model.addAttribute("usrNum", userVO.getUsrNum());
	      
	}

	
	@GetMapping("/list")
	public void list( Criteria cri, Model model) {
		log.info("list : " + cri);
		model.addAttribute("list", service.getList(cri));

		int total = service.getTotal(cri);
		log.info("total: " + total);
		
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	
	//push 해봄 11/18 13:00
	//push 해봄2  11/18 14:09

}

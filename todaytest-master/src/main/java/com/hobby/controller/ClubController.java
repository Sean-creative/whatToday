package com.hobby.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hobby.domain.ClubVO;
import com.hobby.domain.Criteria;
import com.hobby.domain.PageDTO;
import com.hobby.domain.UserVO;
import com.hobby.security.domain.CustomUser;
import com.hobby.service.ClubService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/regular/*")
@AllArgsConstructor
public class ClubController {

   private ClubService service;
   
   //정기모임 개설 
   @PostMapping("/add")
   public String registerClub(Authentication auth, ClubVO club, RedirectAttributes rttr) {
	   //개설(등록)작업이 완료되면 목록화면으로 이동 및 새로 개설된 모임의 모임번호를 같이 전달하기 위해 Redirect Attributes를 파라미터로 지정   
	   
	   club.setCbName(club.getCbName().replaceAll("^(\\s|\\.)*|(\\s|\\.)*$", "")); //유효성검사
	   
	   service.registerClub(club);
	   
	   //일회성으로 데이터를 전달하는 용도 (전달된 값은 url뒤에 붙지 않는다.)
	   rttr.addFlashAttribute("result", club.getCbNum()); 
	   
	   log.info("registerClub: " + club);
	   log.info("##개설된 모임번호는:" + club.getCbNum());
	   
	   return "redirect:/regular/list";
   }
   
   @GetMapping("/add")
   public String registerClub(Authentication auth, Model model) {
	   
	   //로그인이 되어있지 않으면 로그인페이지로 이동
	   if(auth == null) {
		   return "redirect:/login/login";
	   }
	   
	   log.info("register: ");
	   
	   //로그인을 하면 Authentication을 통해 회원 정보를 가져온다. 
	   CustomUser customUser = (CustomUser) auth.getPrincipal();
	   UserVO userVO = customUser.getUser();
	   
	   //파라미터 model을 통해 회원번호와 회원이름을 결과에 담아 전달 한다.
	   model.addAttribute("usrName", userVO.getUsrName());
	   model.addAttribute("usrNum", userVO.getUsrNum());
	   
	   log.info("##/add 회원번호는 :" + userVO.getUsrNum());
	   log.info("##/add 회원이름는 :" + userVO.getUsrName());
	   
	   return "/regular/add";
   }
   
   //정기모임 목록 
   @GetMapping("/list")
   public void clublist(Model model) {
	   
      log.info("clublist");
      
      //파라미터 model을 통해 clubserviceImpl 객체의 getClubList 결과를 담아 전달 한다.   
      model.addAttribute("clublist", service.getClubList());
   }
   
   //정기모임 상세정보
   @GetMapping("/info")
   public void getClub(@RequestParam("cbNum") Long cbNum, Model model) {
      
      log.info("/info");
      //화면쪽으로 해당 모임번호의 정보를 전달하기위해 model에 담는다.
      model.addAttribute("club", service.getClub(cbNum));
   }
   
   //정기모임 게시판 - 목록list (페이징)
//   @GetMapping("/board")
//   public void list(Criteria cri, Model model) {
//      
//      log.info("list :" + cri);
//      
//      //model.addAttribute("club", service.getClub(cbNum));
//      //model.addAttribute("cbNum", cbNum);
//      model.addAttribute("list", service.getList(cri));
//      model.addAttribute("pageMaker", new PageDTO(cri, 123));
//   }
   
   //정기모임 게시판 - 목록list 
   @GetMapping("/board")
   public void list(Model model, @RequestParam("cbNum") Long cbNum) {
	   
	   log.info("list");
	   //파라미터 model을 통해 cbNum과 clubserviceImpl 객체의 getList 결과를 담아 전달 한다.  
	   model.addAttribute("cbNum", cbNum);
	   model.addAttribute("list", service.getList(cbNum));
   }
   
   //정기모임 게시판 - 조회
   @GetMapping({"/boardget","/boardupdate"})
   public void get(@RequestParam("cbBno") Long cbBno, @RequestParam("cbNum") Long cbNum, Model model) {
	   
	   log.info("/get or boardupdate");
	   //화면쪽으로 해당 게시물번호의 정보를 전달하기위해 model에 담는다.
	   model.addAttribute("cbNum", cbNum);
	   model.addAttribute("club", service.get(cbBno));  
   }
   
   //정기모임 게시판 - 등록 
   @PostMapping("/boardadd")
   public String boardRegister(ClubVO club, RedirectAttributes rttr) {
	
	   log.info("###boardregister: " + club);
	   
	   service.boardRegister(club);
		   
	   rttr.addFlashAttribute("result", club.getCbBno());
	   
	   return "redirect:/regular/board?cbNum="+club.getCbNum();
   }
   
   @GetMapping("/boardadd")
   public void boardRegister(Model model, @RequestParam("cbNum") Long cbNum) {
	   
	   log.info("#boardRegister");
	   //파라미터 model을 통해 cbNum과 clubserviceImpl 객체의 getList 결과를 담아 전달 한다.  
	   model.addAttribute("cbNum", cbNum);
	   model.addAttribute("boardRegister", service.getList(cbNum));
   }
   
   //정기모임 게시판 - 삭제
   @PostMapping("/boarddelete")
   public String boardRemove(ClubVO club, @RequestParam("cbBno") Long cbBno,  RedirectAttributes rttr) {
	   
	   log.info("boardremove : " + cbBno);
	   
	   if(service.boardRemove(cbBno)) {
		   
		   rttr.addFlashAttribute("result", "success");
	   }
	   return "redirect:/regular/board?cbNum="+club.getCbNum();
   }
   
   //정기모임 게시판 - 수정
   @PostMapping("/boardupdate")
   public String boardModify(ClubVO club, RedirectAttributes rttr) {
	
	   log.info("boardmodify: " + club);
	   
	   if(service.boardModify(club) == 2) {
		   
		   rttr.addFlashAttribute("result", "success");
	   }
	   return "redirect:/regular/board?cbNum="+club.getCbNum();
   }
}
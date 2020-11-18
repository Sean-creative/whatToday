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
   
   //정기모임 게시판 - 목록list
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
   
   @GetMapping("/board")
   public void list(Model model, @RequestParam("cbNum") Long cbNum) {
      
      log.info("list");
      model.addAttribute("cbNum", cbNum);
      model.addAttribute("list", service.getList(cbNum));
   }
   
   //정기모임 게시판 - 조회
   @GetMapping("/boardget")
   public void get(@RequestParam("cbBno") Long cbBno, Model model) {
      
      log.info("/get");
      model.addAttribute("board", service.get(cbBno));
   }
   
   //정기모임 목록 
   @GetMapping("/list")
   public void clublist(Model model) {
      
      log.info("clublist");
      
      model.addAttribute("clublist", service.getClubList());
   }
   
   //정기모임 개설 
   @PostMapping("/add")
   public String registerClub(Authentication auth, ClubVO club, RedirectAttributes rttr) {
      
//      CustomUser customUser = (CustomUser) auth.getPrincipal();
//      Long cbLeaderNum = customUser.getUser().getUsrNum();
      // cbLeaderNum = usrNum
      log.info("registerClub: " + club);
      
      service.registerClub(club);
      
      rttr.addFlashAttribute("result", club.getCbNum());
      
      return "redirect:/regular/list";
   }
   
   @GetMapping("/add")
   public void registerClub(Authentication auth, Model model) {
      
      log.info("register: ");
      CustomUser customUser = (CustomUser) auth.getPrincipal();
      UserVO userVO = customUser.getUser();
      
      log.info("##/add 회원번호" + userVO.getUsrNum());
      
      model.addAttribute("usrName", userVO.getUsrName());
      model.addAttribute("usrNum", userVO.getUsrNum());
   }
   
   //정기모임 상세정보
   @GetMapping("/info")
   public void getClub(@RequestParam("cbNum") Long cbNum, Model model) {
      
      log.info("/info");
      
      model.addAttribute("club", service.getClub(cbNum));
   }
}
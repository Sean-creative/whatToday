package com.hobby.controller;
import java.util.List;
import java.util.Map;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hobby.domain.ClubMemberVO;
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

	
	// info와 modify를 분리하면서 생각할 것.
	// 1. info -- 접근은 되지만 신청하기, 수정하기 버튼이 눌러지면 안되고, 사용자가 url에 검색을 했더라도 접근이 되면 안된다. -- ThunderVO, UserVO, Criteria 사용
	// 2. modify -- 개설자번호랑 사용자 번호가 일치하지 않으면 접근자체를 막아야하고, 사용자가 url에 검색을 했더라도 접근이 되면 안된다. -- TunderVO,Criteria 사용
	
	@GetMapping("/info")
	public String info(Authentication auth,@RequestParam("cbNum") Long cbNum, @ModelAttribute("cri") Criteria cri, Model model) {

		//로그인 체크를 해서, 로그인이 안되어 있으면 로그인 페이지로 보낸다.
		// @수정사항 -- 로그인이 안되어있으면, auth가 null이되고, auth.getPrincipal()에서 에러가 뜨면서 500번 에러 페이지가 뜸,
		// @ -- 현재는 info에 접근자체가 안되지만, 로그인 된 유저의 번호를 가져오는 것을, 로그인이 안되있어도 에러가 안뜨는 솔루션을 찾아야 할 듯
		if (!service.isLogin(auth)) 
			return "redirect:/login/login";		
				
		
		log.info("/info(GET) - ");
		// 들어온 파라미터 값 확인
		log.info("/info- cri : " + cri);
		log.info("/info- cbNum : " + cbNum);
		
		       		
		//유저정보를 가져와서, 개설자 번호와 현재 로그인된 사람의 Key가 일치하는지 봐야함 
		//--info에서는 jsp단에서 해결하기 위해 로그인한 유저의 번호만 전송한다.
		CustomUser customUser = (CustomUser) auth.getPrincipal();
	    UserVO loginUser = customUser.getUser();
	    
	    // 로그인한 사람의 번호도 뿌려줘서, jsp단에서 로그인 되어있는 사람들에게만 modify 버튼 보여주기 (신청하기도 해야함 - 개선사항)
	    model.addAttribute("usrNum", loginUser.getUsrNum());
	    log.info("/info - 로그인 한 유저의 Num : " + loginUser.getUsrNum());
	      	      	      													
				// A. view 단에 뿌려줘야 하는 것들 
				// A.1 list에서 특정 모임을 클릭했을 때 모임의 상세페이지로 이동이 되면서, 파마리터 형식으로 cl_number(cbNum)이 붙는다.	    	
				ThunderVO clubVO = service.get(cbNum);
				
				
				log.info("/info- clubVO : " + clubVO);
						
				//A.2 파라미터로 넘어온 값인, cbNum를 통해서 개설자의 정보를 가져온다.
				UserVO userVO = userService.get((long) clubVO.getCbLeaderNum());
			
				log.info("/info- userVO : " + userVO);				
				
				//A.3 개설자와 모임에 대한 정보를  view단에 뿌려준다.
				model.addAttribute("userVO", userVO);								
				model.addAttribute("clubVO", clubVO);
																			    			    			    
				//info로 넘어가는 데이터 - 1.로그인한 유저의 번호, 2.club의 정보, 3.해당 club 개설자의 정보  4, criteria
				
				
				
//				//카카오 맵을 이용한 길 찾기 시작!!
//				WebDriver driver = null;
//				String text = null;
//				
//				
//				
//				try {
//					// drvier 설정 - 저는 d드라이브 work 폴더에 있습니다.
//					System.setProperty("webdriver.chrome.driver", "e:\\work\\chromedriver.exe");
//					
//					ChromeOptions options = new ChromeOptions();
//					
////					options.addArguments("--headless");
//					options.addArguments("--disable-extensions");
//					options.addArguments("--disable-gpu");
//					options.addArguments("--window-size=1920x1080");
//					
//					
//					// Chrome 드라이버 인스턴스 설정
//					driver = new ChromeDriver(options);		
//					
//					String location = clubVO.getThunderDetailVO().getCbLocation();
//					log.info(location);
//					
//					
//					//1. 사용자의 위치를 어떻게 가져올 것인가?
//					//리스트일 때 받아올 수있고
//					
//					
//					// 카카오맵 길찾기 URL로 접속
//					driver.get("https://map.kakao.com/link/to/모임장소,"+location+"/from/본인위치,37.537623499999995,127.1580072");									
////					driver.get("https://map.kakao.com/?map_type=TYPE_MAP&target=traffic&option=2&rt=534912%2C1121729%2C523953%2C1084098&rt1=%EB%B3%B8%EC%9D%B8%EC%9C%84%EC%B9%98&rt2=%EB%AA%A8%EC%9E%84%EC%9E%A5%EC%86%8C&rtIds=%2C&rtTypes=%2C");
//
//					driver.findElement(By.className("transit")).sendKeys(Keys.ENTER);
//					
//										
//					// 대기 설정 -- 이것을 해줘야지 element를 찾을 때 오류가 안남(로딩때매 그런듯)
//					driver.manage().timeouts().implicitlyWait(1, TimeUnit.SECONDS);
//
//					
////					element = driver.findElement(By.xpath("//*[@id=\"info.flagsearch\"]/div[6]/ul/li/div[1]/div/div[1]/p/span[1]"));			
//					WebElement element = driver.findElement(By.xpath("/html/body/div[5]/div[2]/div[2]/div[5]/div[5]/ul/li[1]/div[1]/span[1]"));
//																			
//					System.out.println(element.getText());	
//					text = element.getText();
//
//				} catch (Throwable e) {
//					e.printStackTrace();
//				} finally {
////					driver.close();
//				}
//			
//				
//				model.addAttribute("text", text);		
				
				
				
				
				
				
				
				
				
				String joinState = service.getCbMemByUsrNum(loginUser.getUsrNum(), clubVO.getCbNum());
				log.info("/info(GET) - joinState : " + joinState);
				//joinState - 모임추방, 모임만료, 모임탈퇴, 가입승인, Null (아직 데이터 넣기 전)
				
				model.addAttribute("joinState", joinState);
				
					
				List<ClubMemberVO> joinList = service.getJoinList(clubVO.getCbNum(), "가입승인");			            
				for (ClubMemberVO club : joinList) {
					log.info("/info(GET) - joinList : " + club);				
				}
				
				
				model.addAttribute("joinList", joinList);
								
				return "/thunder/info";				 				 					 			
	}
	
	
	
	
	@GetMapping("/modify")
	public String modify(Authentication auth, @RequestParam("cbNum") Long cbNum, @ModelAttribute("cri") Criteria cri, Model model) {
		//로그인 체크를 해서, 로그인이 안되어 있으면 로그인 페이지로 보낸다.
				if (!service.isLogin(auth)) 
					return "redirect:/login/login";		
				                    							 	    					
				log.info("/modify - GET");
				// 들어온 파라미터 값 확인
				log.info("/modify - cri : " + cri);
				log.info("/modify - cbNum : " + cbNum);							
							
		//유저정보를 가져와서, 개설자 번호와 현재 로그인된 사람의 Key가 일치하는지 봐야한다.
		CustomUser customUser = (CustomUser) auth.getPrincipal();
	    UserVO loginUser = customUser.getUser();	      
	    log.info("/modify - 로그인 한 유저의 Num : " + loginUser.getUsrNum());	    	    	    	    	 
	    
	      	      	      													    
	    // A. view 단에 뿌려줘야 하는 것들 
		// A.1 list에서 특정 모임을 클릭했을 때 모임의 상세페이지로 이동이 되면서, 파마리터 형식으로 cl_number(cbNum)이 붙는다.
		ThunderVO clubVO = service.get(cbNum);		
		log.info("/modify- clubVO : " + clubVO);
				
		//A.2 파라미터로 넘어온 값인, cbNum를 통해서 개설자의 정보를 가져온다.
		UserVO userVO = userService.get((long) clubVO.getCbLeaderNum());
		
		
		log.info("/modify- clubUserNum : " + userVO.getUsrNum());				
		
		//A.3 해당 모임에 대한 정보를  view단에 뿌려준다. userVO.getUsrNum()									
		model.addAttribute("clubVO", clubVO);
					
		// 로그인한 유저와 개설자의 번호가 일치하지 않으면 list로 돌려보낸다. (사용자가 url로 장난 쳤을 떄 방지)
		if (loginUser.getUsrNum() != userVO.getUsrNum())
			return "redirect:/thunder/list";		
														
							
		//modify로 넘어가는 데이터 - 1.club의 정보,  2. criteria
					return "/thunder/modify"; 					 				
	}
	
	
	
	
	@PostMapping("/join")
	// join 할때도 cri가 유지되어 있어야 하나???
	public String join(Authentication auth, String joinState, @RequestParam("cbNum") Long cbNum, @ModelAttribute("cri") Criteria cri,  RedirectAttributes rttr) {
		//로그인 체크를 해서, 로그인이 안되어 있으면 로그인 페이지로 보낸다.
		if (!service.isLogin(auth)) 
			return "redirect:/login/login";
		
		log.info("/join(POST) - cri : " + cbNum);
		log.info("/join(POST) - cri : " + cri);
		log.info("/join(POST) - joinState : " + joinState);
				
		ThunderVO clubVO = service.get(cbNum);				
		log.info("/join - ThunderVO : " + clubVO);													
		
		CustomUser customUser = (CustomUser) auth.getPrincipal();
	    UserVO loginUser = customUser.getUser();	    
	    log.info("/join(POST) -loginUser : " + loginUser);
	    		
	    //join메서드에 주어야 하는 것 -> 1.loginUser 2.clubVO 3.joinState
		if(service.join(clubVO, loginUser, joinState)) { // 모달창으로 신청되었는지 알려줘야함!!
		rttr.addFlashAttribute("result", "처리되었습니다."); } 
		else {
		rttr.addFlashAttribute("result", "처리되지 않았습니다."); }
		 
		
		
		rttr.addAttribute("cbNum", cbNum);
		//조건문(cri) 다가지고 info로 돌아간다!
		return "redirect:/thunder/info" + cri.getListLink(); 
	}
	
	
	
	
	
	
	
	
	@PostMapping("/modify")
	public String modify(ThunderVO Club, @ModelAttribute("cri") Criteria cri,  RedirectAttributes rttr) {
		log.info("/modify - POST");		
		
		log.info("modify - club " + Club);
			
		if(service.modify(Club)) {
			// 모달창으로 수정이되거나 삭제되면 버튼이 구현되면, 사용할 메세지
			rttr.addFlashAttribute("result", "모임 정보가 수정되었습니다..");
				}
		else {
			rttr.addFlashAttribute("result", "모임 정보가 수정되지 않았습니다.");
		}

		
		return "redirect:/thunder/list" + cri.getListLink(); 
	}
	
	@PostMapping("/remove")
	public String remove(@RequestParam("cbNum") Long cbNum, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		log.info("/remove - POST");
		log.info("remove - cbNum : " + cbNum);
		
		if(service.remove(cbNum)) {
			// 모달창으로 수정이되거나 삭제되면 버튼이 구현되면, 사용할 메세지
			rttr.addFlashAttribute("result", "모임 정보가 삭제되었습니다.");
		} else {
			rttr.addFlashAttribute("result", "모임 정보가 삭제되지 않았습니다.");
		}
		
//		원래는 이렇게 써야하는데, 아래처럼  '+cri.getListLink()' 해주면 가독성이 좋아진다.
//		rttr.addAttribute("pageNum", cri.getPageNum());
//		rttr.addAttribute("amount", cri.getAmount());
//		rttr.addAttribute("type" , cri.getType());
//		rttr.addAttribute("keyword", cri.getKeyword());
		// PR 테스트!
		return "redirect:/thunder/list"+ cri.getListLink();
	}
			

	
	@PostMapping("/add") 
	public String add(Authentication auth, ThunderVO clubVO, RedirectAttributes rttr) {
		log.info("/add - POST");
									
		CustomUser customUser = (CustomUser) auth.getPrincipal();
	    Long usrNum = customUser.getUser().getUsrNum();
	    log.info("add - usrNum : POST-add 회원번호" + usrNum);

	    //현재 로그인 되어있는 유저의 번호와 이름으로 club을 만든다.
	    clubVO.setCbLeaderNum(usrNum);
	    clubVO.setCbLeaderName(customUser.getUser().getUsrName());
	    clubVO.setCbType("번개모임");
		clubVO.setCbCurMbnum((long) 1);
		clubVO.setCbFinalState("진행중");

	    log.info("add - clubVO : " + clubVO);
	    
	    
		
		if(service.register(clubVO, customUser.getUser(), "가입승인")) { // 모달창으로 수정이되거나 삭제되면 버튼이 구현되면, 사용할 메세지
		rttr.addFlashAttribute("result", "모임 정보가 등록되었습니다."); 
		}
	
		else {
		rttr.addFlashAttribute("result", "모임 정보가 등록되지 않았습니다."); 
		}
		 
	    	    	      				 					
		return "redirect:/thunder/list";
	}
	

	
	
	@GetMapping("/add")
	//@로그인 안한상태에서, 개설 누르면 로그인으로 바로 보내는데, 모달창이나 경고문으로 띄워주고 보내도록 수정하기
	public String add(Authentication auth, Model model) {
		log.info("/add - GET");
		
		
		//로그인 체크를 해서, 로그인이 안되어 있으면 로그인 페이지로 보낸다.
		if (service.isLogin(auth)) 
			return "/thunder/add";                    							 	    
		else 
			return "redirect:/login/login";
	}

	
	@GetMapping("/list")
	public void list( Criteria cri, Model model) {
		log.info("/list - GET");
		
		log.info("list - cri : " + cri);
		// cri에 들어있는 조건 대로, club 정보를 가져온다.
		model.addAttribute("list", service.getList(cri));
		
		log.info("list : " + service.getList(cri));

		// cri에 들어있는 조건 대로, 가져올 수 있는 club의 개수를 체크한다.
		int total = service.getTotal(cri); 
		log.info("list - total : " + total);
		
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
}

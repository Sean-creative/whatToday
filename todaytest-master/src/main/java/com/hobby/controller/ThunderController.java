package com.hobby.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hobby.domain.ClubMemberVO;
import com.hobby.domain.Criteria;
import com.hobby.domain.MeetingVO;
import com.hobby.domain.PageDTO;
import com.hobby.domain.ThunderVO;
import com.hobby.domain.UserVO;
import com.hobby.security.domain.CustomUser;
import com.hobby.service.ThunderService;
import com.hobby.service.UserService;
import com.hobby.utils.UploadFileUtils;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/thunder/*")
@AllArgsConstructor
public class ThunderController {


	private ThunderService service;	
	private UserService userService;

	//	servlet-context.xml에서 설정했던 uploadPath를 추가
	@Resource(name = "uploadPath")
	private String uploadPath;

	// info와 modify를 분리하면서 생각할 것.
	// 1. info -- 접근은 되지만 신청하기, 수정하기 버튼이 눌러지면 안되고, 사용자가 url에 검색을 했더라도 접근이 되면 안된다. --
	// ThunderVO, UserVO, Criteria 사용
	// 2. modify -- 개설자번호랑 사용자 번호가 일치하지 않으면 접근자체를 막아야하고, 사용자가 url에 검색을 했더라도 접근이 되면
	// 안된다. -- TunderVO,Criteria 사용

	@GetMapping("/info")
	public String info(Authentication auth, @RequestParam("cbNum") Long cbNum, @ModelAttribute("cri") Criteria cri, Model model) {

		// 로그인 체크를 해서, 로그인이 안되어 있으면 로그인 페이지로 보낸다.
		// @수정사항 -- 로그인이 안되어있으면, auth가 null이되고, auth.getPrincipal()에서 에러가 뜨면서 500번 에러
		// 페이지가 뜸,
		// @ -- 현재는 info에 접근자체가 안되지만, 로그인 된 유저의 번호를 가져오는 것을, 로그인이 안되있어도 에러가 안뜨는 솔루션을 찾아야
		// 할 듯
		if (!service.isLogin(auth))
			return "redirect:/login/login";

		// 들어온 파라미터 값 확인
		log.info("/info(GET) - cri : " + cri);
		log.info("/info(GET) - cbNum : " + cbNum);

		// 유저정보를 가져와서, 개설자 번호와 현재 로그인된 사람의 Key가 일치하는지 봐야함
		// --info에서는 jsp단에서 해결하기 위해 로그인한 유저의 번호만 전송한다.
		CustomUser customUser = (CustomUser) auth.getPrincipal();
		UserVO loginUser = customUser.getUser();

		// 로그인한 사람의 번호도 뿌려줘서, jsp단에서 로그인 되어있는 사람들에게만 modify 버튼 보여주기 (신청하기도 해야함 - 개선사항)
		model.addAttribute("usrNum", loginUser.getUsrNum());
		log.info("/info(GET) - 로그인 한 유저의 Num : " + loginUser.getUsrNum());

		// A. view 단에 뿌려줘야 하는 것들
		// A.1 list에서 특정 모임을 클릭했을 때 모임의 상세페이지로 이동이 되면서, 파마리터 형식으로 cl_number(cbNum)이 붙는다.
		ThunderVO clubVO = service.get(cbNum);
		log.info("/info(GET)- clubVO : " + clubVO);

		// A.2 파라미터로 넘어온 값인, cbNum를 통해서 개설자의 정보를 가져온다.
		UserVO userVO = userService.get((long) clubVO.getCbLeaderNum());
		log.info("/info(GET) - userVO : " + userVO);

		// A.3 개설자와 모임에 대한 정보를 view단에 뿌려준다.
		model.addAttribute("userVO", userVO);
		model.addAttribute("clubVO", clubVO);

		// info로 넘어가는 데이터 - 1.로그인한 유저의 번호, 2.club의 정보, 3.해당 club 개설자의 정보 4, criteria


		String joinState = service.getCbMemByUsrNum(loginUser.getUsrNum(), clubVO.getCbNum());
		log.info("/info(GET) - joinState : " + joinState);
		// joinState - 모임추방, 모임만료, 모임탈퇴, 가입승인, Null (아직 데이터 넣기 전)

		model.addAttribute("joinState", joinState);

		List<ClubMemberVO> joinList = service.getJoinList(clubVO.getCbNum(), "가입승인");
		for (ClubMemberVO club : joinList) {
			log.info("/info(GET) - joinList : " + club);
		}

		model.addAttribute("joinList", joinList);
		
		
		int likecheck = service.readLike(loginUser.getUsrNum(), clubVO.getCbNum());
		log.info("/info(GET) - likecheck : " + likecheck);
		model.addAttribute("likecheck", likecheck);
		

		return "/thunder/info";
	}
	
	@RequestMapping("/clickLike")
    @ResponseBody
    public Map<String,Object> clickLike(@RequestParam Map<String,Object> commandMap){
		log.info("/clickLike(POST) - commandMap : " + commandMap);
		
		
		log.info("usrNum " + commandMap.get("usrNum"));
        log.info("cbNum " + commandMap.get("cbNum"));
    
        Long usrNum = Long.parseLong((String)commandMap.get("usrNum")) ;
        Long cbNum = Long.parseLong((String)commandMap.get("cbNum")) ;
        
     
        int resultCode = 1;
        int likecheck = 1;               
        Map<String,Object> resultMap = new HashMap<>();
     
  
        try {
            int check = service.readLike(usrNum, cbNum);            
            log.info("/clickLike(POST) - check : " + check);
            if(check == -1) {
                //처음 좋아요 누른것 likecheck=1, 좋아요 빨간색이 되야됨
                service.insertLikeBtn(usrNum, cbNum); //좋아요 테이블 인서트                
                resultCode = 1;
            }
            else if(check == 0) {
                //좋아요 처음은 아니고 취소했다가 다시 눌렀을때 likecheck=1, 좋아요 빨간색 되야됨                
                service.updateLikeCheck(usrNum, cbNum,check); //좋아요 테이블 업데이트
                resultCode = 1;
            }
            else {
                //좋아요 취소한거 likecheck=0, 빈하트 되야됨
                likecheck = 0;                
                service.updateLikeCheck(usrNum, cbNum,check);                
                resultCode = 0;
            }                        // 
            resultMap.put("likecheck", likecheck);
        } catch (Exception e) {
        	log.info("요거 여태 문제였다고??? ");
            log.info(e.getMessage());
            resultCode = -1;
        }
        
        resultMap.put("resultCode", resultCode);
        //resultCode가 1이면 빨간하트 0이면 빈하트
        return resultMap;
    }






	@GetMapping("/modify")
	public String modify(Authentication auth, @RequestParam("cbNum") Long cbNum, @ModelAttribute("cri") Criteria cri, Model model) {
		// 로그인 체크를 해서, 로그인이 안되어 있으면 로그인 페이지로 보낸다.
		if (!service.isLogin(auth))
			return "redirect:/login/login";

		// 들어온 파라미터 값 확인
		log.info("/modify(GET) - cri : " + cri);
		log.info("/modify(GET) - cbNum : " + cbNum);

		// 유저정보를 가져와서, 개설자 번호와 현재 로그인된 사람의 Key가 일치하는지 봐야한다.
		CustomUser customUser = (CustomUser) auth.getPrincipal();
		UserVO loginUser = customUser.getUser();
		log.info("/modify(GET) - 로그인 한 유저의 Num : " + loginUser.getUsrNum());

		// A. view 단에 뿌려줘야 하는 것들
		// A.1 list에서 특정 모임을 클릭했을 때 모임의 상세페이지로 이동이 되면서, 파마리터 형식으로 cl_number(cbNum)이 붙는다.
		ThunderVO clubVO = service.get(cbNum);
		log.info("/modify(GET)- clubVO : " + clubVO);

		// A.2 파라미터로 넘어온 값인, cbNum를 통해서 개설자의 정보를 가져온다.
		UserVO userVO = userService.get((long) clubVO.getCbLeaderNum());

		log.info("/modify(GET) - clubUserNum : " + userVO.getUsrNum());

		// A.3 해당 모임에 대한 정보를 view단에 뿌려준다. userVO.getUsrNum()
		model.addAttribute("clubVO", clubVO);

		// 로그인한 유저와 개설자의 번호가 일치하지 않으면 list로 돌려보낸다. (사용자가 url로 장난 쳤을 떄 방지)
		if (loginUser.getUsrNum() != userVO.getUsrNum())
			return "redirect:/thunder/list";

		// modify로 넘어가는 데이터 - 1.club의 정보, 2. criteria
		return "/thunder/modify";
	}





	@PostMapping("/modify")
	public String modify(ThunderVO Club, @ModelAttribute("cri") Criteria cri, MultipartFile file, RedirectAttributes rttr) throws Exception {

		log.info("modify(POST) - club " + Club);
		log.info("modify(POST) - file " + file);
		log.info("modify(POST) - file.getOriginalFilename() " + file.getOriginalFilename());

		// 파일용 인풋박스에 등록된 파일의 정보를 가져오고, UploadFileUtils.java를 통해 폴더를 생성한 후 원본 파일과 썸네일을
		// 저장한 뒤,
		// 이 경로를 데이터 베이스에 전하기 위해 ThunderVO에 입력(set)

		String imgUploadPath = uploadPath + File.separator + "imgUpload"; // 이미지를 업로드할 폴더를 설정 = /uploadPath/imgUpload
		String ymdPath = UploadFileUtils.calcPath(imgUploadPath); // 위의 폴더를 기준으로 연월일 폴더를 생성
		String fileName = null; // 기본 경로와 별개로 작성되는 경로 + 파일이름

		if (file.getOriginalFilename() != null && file.getOriginalFilename() != "") {
			// 파일 인풋박스에 첨부된 파일이 있다면

			fileName = UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath);

			// file에 원본 파일 경로 + 파일명 저장
			Club.setCbFile(File.separator + "imgUpload" + ymdPath + File.separator + fileName);
			// Thumbimg에 썸네일 파일 경로 + 썸네일 파일명 저장
			Club.setCbThumbImg(File.separator + "imgUpload" + ymdPath + File.separator + "s" + File.separator + "s_" + fileName);

		}
		// 첨부된 파일이 없으면 기존의것 그대로 가면 됨!!

		if (service.modify(Club)) {
			// 모달창으로 수정이되거나 삭제되면 버튼이 구현되면, 사용할 메세지
			rttr.addFlashAttribute("result", "모임 정보가 수정되었습니다..");
		} else {
			rttr.addFlashAttribute("result", "모임 정보가 수정되지 않았습니다.");
		}

		return "redirect:/thunder/list" + cri.getListLink();
	}




	@PostMapping("/join")
	// join 할때도 cri가 유지되어 있어야 하나???
	public String join(Authentication auth, String joinState, @RequestParam("cbNum") Long cbNum, @ModelAttribute("cri") Criteria cri,
			RedirectAttributes rttr) {
		// 로그인 체크를 해서, 로그인이 안되어 있으면 로그인 페이지로 보낸다.
		if (!service.isLogin(auth))
			return "redirect:/login/login";

		log.info("/join(POST) - cri : " + cbNum);
		log.info("/join(POST) - cri : " + cri);
		log.info("/join(POST) - joinState : " + joinState);

		ThunderVO clubVO = service.get(cbNum);
		log.info("/join(POST) - ThunderVO : " + clubVO);

		CustomUser customUser = (CustomUser) auth.getPrincipal();
		UserVO loginUser = customUser.getUser();
		log.info("/join(POST) -loginUser : " + loginUser);

		// join메서드에 주어야 하는 것 -> 1.loginUser 2.clubVO 3.joinState
		if (service.join(clubVO, loginUser, joinState)) { // 모달창으로 신청되었는지 알려줘야함!!
			rttr.addFlashAttribute("result", "처리되었습니다.");
		} else {
			rttr.addFlashAttribute("result", "처리되지 않았습니다.");
		}

		rttr.addAttribute("cbNum", cbNum);
		// 조건문(cri) 다가지고 info로 돌아간다!
		return "redirect:/thunder/info" + cri.getListLink();
	}



	@PostMapping("/remove")
	public String remove(@RequestParam("cbNum") Long cbNum, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		log.info("/remove(POST) - cbNum : " + cbNum);

		if (service.remove(cbNum)) {
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
		return "redirect:/thunder/list" + cri.getListLink();
	}





	@PostMapping("/add")
	// 메서드의 매개변수에 MultipartFile file이 추가
	public String add(Authentication auth, ThunderVO clubVO, MultipartFile file, RedirectAttributes rttr) throws Exception {
		log.info("/add(POST) - file : " + file);

		// 파일용 인풋박스에 등록된 파일의 정보를 가져오고, UploadFileUtils.java를 통해 폴더를 생성한 후 원본 파일과 썸네일을
		// 저장한 뒤,
		// 이 경로를 데이터 베이스에 전하기 위해 ThunderVO에 입력(set)

		String imgUploadPath = uploadPath + File.separator + "imgUpload"; // 이미지를 업로드할 폴더를 설정 = /uploadPath/imgUpload
		String ymdPath = UploadFileUtils.calcPath(imgUploadPath); // 위의 폴더를 기준으로 연월일 폴더를 생성
		String fileName = null; // 기본 경로와 별개로 작성되는 경로 + 파일이름

		if (file.getOriginalFilename() != null && file.getOriginalFilename() != "") {
			// 파일 인풋박스에 첨부된 파일이 없다면(=첨부된 파일이 이름이 없다면)

			fileName = UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath);

			// file에 원본 파일 경로 + 파일명 저장
			clubVO.setCbFile(File.separator + "imgUpload" + ymdPath + File.separator + fileName);
			// Thumbimg에 썸네일 파일 경로 + 썸네일 파일명 저장
			clubVO.setCbThumbImg(File.separator + "imgUpload" + ymdPath + File.separator + "s" + File.separator + "s_" + fileName);

		} else { // 첨부된 파일이 없으면
			fileName = File.separator + "img" + File.separator + "none.png";
			// 미리 준비된 none.png파일을 대신 출력함

			// file에 원본 파일 경로 + 파일명 저장
			clubVO.setCbFile(fileName);
			// Thumbimg에 썸네일 파일 경로 + 썸네일 파일명 저장
			clubVO.setCbThumbImg(fileName);
		}

		CustomUser customUser = (CustomUser) auth.getPrincipal();
		Long usrNum = customUser.getUser().getUsrNum();
		log.info("/add(POST) - usrNum : POST-add 회원번호" + usrNum);

		// 현재 로그인 되어있는 유저의 번호와 이름으로 club을 만든다.
		clubVO.setCbLeaderNum(usrNum);
		clubVO.setCbLeaderName(customUser.getUser().getUsrName());
		clubVO.setCbType("번개모임");
		clubVO.setCbCurMbnum((long) 1);
		clubVO.setCbFinalState("진행중");

		log.info("/add(POST) - clubVO : " + clubVO);

		if (service.register(clubVO, customUser.getUser(), "가입승인")) { // 모달창으로 수정이되거나 삭제되면 버튼이 구현되면, 사용할 메세지
			rttr.addFlashAttribute("result", "모임 정보가 등록되었습니다.");
		}

		else {
			rttr.addFlashAttribute("result", "모임 정보가 등록되지 않았습니다.");
		}

		return "redirect:/thunder/list";
	}

	@GetMapping("/add")
	// @로그인 안한상태에서, 개설 누르면 로그인으로 바로 보내는데, 모달창이나 경고문으로 띄워주고 보내도록 수정하기
	public String add(Authentication auth, Model model) {
		log.info("/add(GET)");

		// 로그인 체크를 해서, 로그인이 안되어 있으면 로그인 페이지로 보낸다.
		if (service.isLogin(auth))
			return "/thunder/add";
		else
			return "redirect:/login/login";
	}


	@GetMapping("/list")
	// String userLatitudeStr, String userLongitudeStr
	public String list(Criteria cri, Model model) {
		log.info("list(GET) - cri : " + cri);
		log.info("list(GET) - userlatitude : " + cri.getUserLatitude());
		log.info("list(GET) - userlongitude : " + cri.getUserLongitude());

		// GPS 정보가 없으면 gps.jsp 가서 정보를 가져온다.
		if (cri.getUserLatitude() == null || cri.getUserLongitude() == null) {
			log.info("list(GET) - gps(GET)으로 forward ");
			return "redirect:/thunder/gps" + cri.getListLink();			
		}

		// cri에 들어있는 조건 대로, club 정보를 가져온다.		
		List<ThunderVO> thunderList = service.getListWithPaging(cri);
		model.addAttribute("list", thunderList);
		log.info("list(GET) - thunderList : " + thunderList);
		//List에서 처음 하나만 꺼내서 확인한다. (Log.info 도배 방지)

		if(thunderList.size() != 0) {
			log.info("list(GET) - firstOne : " + thunderList.get(0));
		}

		// cri에 들어있는 조건 대로, 가져올 수 있는 club의 개수를 체크한다.
		int total = service.getTotal(cri);
		log.info("list(GET) - total : " + total);

		model.addAttribute("pageMaker", new PageDTO(cri, total));

		return "/thunder/list";
	}

	@GetMapping("/gps")
	//gps.jsp 가서 위도경도만 반환받고 바로 list로 다시 돌아감
	public void gps(Criteria cri, Model model) {		
		log.info("gps(GET) - cri : " + cri);		
		model.addAttribute("cri", cri);		
	}

	// ##### 번개모임 채팅창 (지영) #####
	@PreAuthorize("isAuthenticated()")
	@RequestMapping(value = "/chat", method = RequestMethod.GET)
	public String chat(@RequestParam("cbNum") Long cbNum, Model model, RedirectAttributes rtts) {
		log.info("##/chat");
		CustomUser customUser = (CustomUser)SecurityContextHolder.getContext().getAuthentication().getPrincipal();

		UserVO userVO = customUser.getUser();
		Long usrNum = userVO.getUsrNum();
		String usrName = userVO.getUsrName();
		
		// 모임에 가입한 사람만 채팅창에 들어 갈수 있음
		String joinState = service.getCbMemByUsrNum(usrNum, cbNum);
		if(!joinState.equals("가입승인")) {
			rtts.addFlashAttribute("msg", "모임에 가입한 사람만 입장할 수 있습니다.");
			return "redirect:/thunder/list";
		}else {		
			ThunderVO clubVO = service.get(cbNum);

			model.addAttribute("userVO", userVO);
			model.addAttribute("usrNum", usrNum);
			model.addAttribute("usrName", usrName);
			model.addAttribute("clubVO", clubVO);

			return "/thunder/chat";
		}

	}


}

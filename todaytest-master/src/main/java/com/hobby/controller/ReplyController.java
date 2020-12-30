package com.hobby.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.hobby.domain.ReplyVO;
import com.hobby.domain.UserVO;
import com.hobby.security.domain.CustomUser;
import com.hobby.service.ReplyService;


import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping("/replies/")
@RestController
@Log4j
@AllArgsConstructor
public class ReplyController {
	
	private ReplyService service;

//	//댓글 등록 
//	@PostMapping(value= "/new",
//				consumes = "application/json",
//				produces = {MediaType.TEXT_PLAIN_VALUE })
//	public ResponseEntity<String> create(@RequestBody ReplyVO vo) {
//		
//		log.info("ReplyVO : " + vo);
//		
//		int insertCount = service.register(vo);
//		
//		log.info("Reply INSERT COUNT: " + insertCount);
//		
//		//삼항연산자 처리 
//		return insertCount == 1
//				? new ResponseEntity<>("success", HttpStatus.OK)
//				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);				
//	}
//	
//	//댓글 목록 확인 
//	@GetMapping(value= "/{cbBno}", 
//				produces = {
//					MediaType.APPLICATION_XML_VALUE, 
//					MediaType.APPLICATION_JSON_UTF8_VALUE })
//	public ResponseEntity<List<ReplyVO>> getList(@PathVariable("cbBno") Long cbBno) {
//		
//		log.info("getList...........");
//		
//		return new ResponseEntity<>(service.getList(cbBno), HttpStatus.OK);
//	}
//	
//	//댓글 조회
////	@GetMapping(value= "/{rno}", 
////				produces = {
////					MediaType.APPLICATION_XML_VALUE, 
////					MediaType.APPLICATION_JSON_UTF8_VALUE })
////	public ResponseEntity<ReplyVO> get(@PathVariable("rno") Long rno) {
////		
////		log.info("get:" + rno);
////		
////		return new ResponseEntity<>(service.get(rno), HttpStatus.OK);
////	}
//	
//	//댓글 삭제 
//	@DeleteMapping(value= "/{rno}", produces= {MediaType.TEXT_PLAIN_VALUE})
//	public ResponseEntity<String> remove(@PathVariable("rno") Long rno) {
//		
//		log.info("remove:" + rno);
//		
//		return service.remove(rno) == 1
//				? new ResponseEntity<>("success", HttpStatus.OK)
//				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
//	}
//	
//	//댓글 수정 
//	@RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH},
//			value = "/{rno}",
//			consumes = "application/json",
//			produces = {MediaType.TEXT_PLAIN_VALUE})
//	public ResponseEntity<String> modify(
//			@RequestBody ReplyVO vo, 
//			@PathVariable("rno") Long rno) {
//		
//		vo.setRno(rno);
//		
//		log.info("rno:" + rno);
//		log.info("modify: " + vo);
//		
//		return service.modify(vo) == 1
//				? new ResponseEntity<>("success", HttpStatus.OK)
//				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
//	}
	
	//댓글 목록
	@RequestMapping(value="/list", method=RequestMethod.POST)  
	@ResponseBody
	private List<ReplyVO> getList(Authentication auth, @RequestParam("cbBno") Long cbBno) {
		
		log.info("getList...........");
		
		Map<String, Object> result = new HashMap<>();
		CustomUser customUser = (CustomUser) auth.getPrincipal();
		UserVO userVO = customUser.getUser();
		
		List<ReplyVO> replyList = service.getList(cbBno);
		
		for (ReplyVO reply : replyList) {
			log.info("userVO.getUsrName( : " + userVO.getUsrName() + " / reply.getReplyer() : " + reply.getReplyer());
			if (userVO.getUsrName().equals(reply.getReplyer())) {
				reply.setIsReplyer("true");
			} else {
				reply.setIsReplyer("false");
			}
		}
		log.info("replyList : " + replyList);
		return replyList;
	}
	
	//댓글 등록
	@RequestMapping(value="/insert", method=RequestMethod.POST) 
	public Map<String, Object> register(Authentication auth, @RequestBody ReplyVO vo) {
		
		Map<String, Object> result = new HashMap<>();
		CustomUser customUser = (CustomUser) auth.getPrincipal();
		UserVO userVO = customUser.getUser();
		
		vo.setReplyer(userVO.getUsrName());
		
		try {
			service.register(vo);
			result.put("status", "OK");
			
		} catch (Exception e) {
			e.printStackTrace();
			result.put("status", "False");
		}
		return result;
	}
	
	//댓글 수정 
	@RequestMapping(value="/update", method = {RequestMethod.GET, RequestMethod.POST})
	public Map<String, Object> modify(@RequestBody ReplyVO vo) {
		
		Map<String, Object> result = new HashMap<>();
		
		try {
			service.modify(vo);
			result.put("status", "OK");

		} catch (Exception e) {
			e.printStackTrace();
			result.put("status", "False");
		}
		return result;
	}

	//댓글 삭제 
	@RequestMapping(value="/delete", method = {RequestMethod.GET, RequestMethod.POST})
	public Map<String, Object> remove(@RequestParam("rno") Long rno) {
		
		Map<String, Object> result = new HashMap<>();
		
		try {
			service.remove(rno);
			result.put("status", "OK");
			
		} catch (Exception e) {
			e.printStackTrace();
			result.put("status", "False");
		}
		return result;
	}
	
}

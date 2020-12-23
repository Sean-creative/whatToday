package com.hobby.controller;


import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.hobby.domain.UserVO;
import com.hobby.service.MypageService;

import lombok.Setter;

public class EchoHandler2 extends TextWebSocketHandler {

	
	@Setter(onMethod_ = @Autowired)
	private MypageService service;
	
	private Map<String, WebSocketSession> socketMap = new ConcurrentHashMap<>();
	private Map<String, List> messageMap = new ConcurrentHashMap<>();
	
	// 클라이언트와 연결 이후에 실행되는 메서드
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {

		String sckId = getMemberId(session);

		if (getMemberId(session) != null) {
			System.out.println(sckId + " 연결");// 소켓 연결
			socketMap.put(sckId, session);// 아이디를 key값 소켓세션값을 value로
		}

	}

	// 클라이언트가 서버로 메시지를 전송했을 때 실행되는 메서드
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		List<String> list = new ArrayList<String>();
		Long usNum;
		// 특정 유저에게 보내기
		String msg = message.getPayload();
		System.out.println(msg);
		if (msg != null) {
			
			String[] strs = msg.split(",",2);
			String target = strs[0];
			String content = strs[1];
			if(content.equals("접속")) {
				usNum = Long.parseLong(target);
				UserVO userVO = service.getUserN(usNum);
				target = userVO.getUsrId();
				System.out.println(target);
				System.out.println(content);
			}
			if ((!content.equals("접속")) && strs != null && strs.length == 2) {
				
				if(messageMap.get(target) == null) {
					messageMap.put(target, new ArrayList<String>());
					list.add(content);
					messageMap.put(target, list);
				}else {
					list = messageMap.get(target);
					System.out.println("list : " + list);
					if(list.size()==6) {
						list.remove(0);
					}
					list.add(content);
					messageMap.put(target, list);
				}
				
				System.out.println("++++++++++++++++++"+messageMap.get(target));
				WebSocketSession targetSession = socketMap.get(target); // 메시지를 받을 세션 조회

				// 접속안하면 못받아요					
				if(targetSession != null){
					TextMessage tmpMsg = new TextMessage(content);
					targetSession.sendMessage(tmpMsg);
				}
			}else if(content.equals("접속")) {
				WebSocketSession targetSession = socketMap.get(target);
				if (targetSession != null && content.equals("접속")) {
					list = messageMap.get(target);
					if(list != null) {
					for(int i = 0; i < list.size(); i++) {
						TextMessage tmpMsg = new TextMessage(list.get(i));
						targetSession.sendMessage(tmpMsg);
					}
					}
					
			}
			}
		}
	}

	// 클라이언트와 연결을 끊었을 때 실행되는 메소드
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		String senderId = getMemberId(session);

		if (senderId != null) { // 로그인 값이 있는 경우만

			socketMap.remove(senderId);

		}
	}

	// 소켓에 있는 아이디 찾기
	private String getMemberId(WebSocketSession session) {

		String str = "";

		str = session.getPrincipal().getName();

		return str == null ? null : str;
	}
}
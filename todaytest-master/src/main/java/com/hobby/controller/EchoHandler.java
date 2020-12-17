package com.hobby.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;
/**
 * 멀티 채팅창 구현 - WebSocket관리
 * 사용자는 , 없이 메지시를 보내야 한다.
 * @author jiyeong
 *
 */
public class EchoHandler extends TextWebSocketHandler {

	// 모임 번호 : 소켓리스트 (=가입한 사람들중 채팅창에 현재 접속한 사람들)
	private Map<String, List> socketMap = new ConcurrentHashMap<>();
	
	private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();

	// 클라이언트가 서버로 메시지를 전송했을 때 실행되는 메서드
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		String msg = message.getPayload();
		System.out.println("@@@inputMsg: " + msg);

		// 입장or채팅, 모임번호, msg
		if (msg != null) {
			// 사용자가 메시지에 ,를 붙일 수 있음
			// json 형태로 주고 받고 싶은데 나중에..
			String[] strs = msg.split(",",3);
			if (strs != null && strs.length == 3) {
				
				// 입장 or 채팅
				String enter = strs[0];
				
				// 방번호
				String target = strs[1];
				
				// msg
				String content = strs[2];

				if(enter.equals("입장")) {
					// 현재 소켓맵에 채팅방이 없을 경우 채팅창을 만든다.
					if(socketMap.get(target)==null) {
						System.out.println("### map Put");
						socketMap.put(target, new ArrayList<WebSocketSession>());
						
					// 채팅방이 있을 경우 방번호로 채팅방을 찾아 접속한사람(=리스트) 추가
					}else {
						List<WebSocketSession> llist = socketMap.get(target);
						System.out.println("list : " + llist);
						llist.add(session);
					}
				}
				
				// 채팅일 경우
				else {
					 // 현재 채팅방을 찾아 현재 채팅창에 접속한 사람들에게만 메시지를 전송한다. 
					 List<WebSocketSession> llist222 = socketMap.get(target);
					 for (WebSocketSession sess : llist222) {
						 	// sessionid 사용자이름 받아와서 바꾸기
						 	sess.sendMessage(new TextMessage(session.getId() + " : " + content));
					 }
				}
			}
		}
	}

	// 클라이언트와 연결을 끊었을 때 실행되는 메소드_연결 끊기는거 나중에 구현
//	@Override
//	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
//		String senderId = getMemberId(session);
//
//		if (senderId != null) { // 로그인 값이 있는 경우만
//
//			socketMap.remove(senderId);
//
//		}
//	}

}
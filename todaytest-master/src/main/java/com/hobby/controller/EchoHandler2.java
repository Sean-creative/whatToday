package com.hobby.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class EchoHandler2 extends TextWebSocketHandler {

	private Map<String, WebSocketSession> socketMap = new ConcurrentHashMap<>();

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
		String senderId = getMemberId(session);
		// 특정 유저에게 보내기
		String msg = message.getPayload();

		if (msg != null) {
			
			String[] strs = msg.split(",",2);

			if (strs != null && strs.length == 4) {
				String target = strs[0];

				String content = strs[1];

				WebSocketSession targetSession = socketMap.get(target); // 메시지를 받을 세션 조회

				// 실시간 접속시
				if (targetSession != null) {
					// ex: [&분의일] 신청이 들어왔습니다.
					TextMessage tmpMsg = new TextMessage(content);
					targetSession.sendMessage(tmpMsg);
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
package com.hobby.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class EchoHandler extends TextWebSocketHandler{

	private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
	
	// 클라이언트와 연결 이후에 실행되는 메서드
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
    	// 맵을 쓸 때 방법
    	// sessions.put(session.getId(), session);
    	sessionList.add(session);
    	System.out.println("{} 연결됨"+ session.getId());
    }
   
    // 클라이언트가 서버로 메시지를 전송했을 때 실행되는 메서드
    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
      System.out.println(("{}로 부터 {} 받음"+ session.getId()+ message.getPayload()));
      for (WebSocketSession sess : sessionList) {
        sess.sendMessage(new TextMessage(session.getId() + " : " + message.getPayload()));
      }
    }
   
    // 클라이언트와 연결을 끊었을 때 실행되는 메소드
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
      sessionList.remove(session);
      System.out.println(("{} 연결 끊김"+ session.getId()));
      System.out.println("채팅방 퇴장하는 사람: " + session.getPrincipal().getName());
    }
}

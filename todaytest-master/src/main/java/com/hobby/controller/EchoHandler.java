package com.hobby.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class EchoHandler extends TextWebSocketHandler{
	private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
	private Map<String, WebSocketSession> map  = new HashMap<String, WebSocketSession>();
	
	// 클라이언트와 연결 이후에 실행되는 메서드
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
    	// map.put(session.getId(), session);
    	sessionList.add(session);
    	System.out.println("{} 연결됨"+ session.getId());
    }
   
    // 클라이언트가 서버로 메시지를 전송했을 때 실행되는 메서드
    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
      System.out.println("inMsg: " + message);

      System.out.println(("{}로 부터 {} 받음 : id: "+ session.getId() + ", msg: " + message.getPayload()));
      
      JSONParser jsonParser = new JSONParser();

      JSONObject jsonObject = (JSONObject) jsonParser.parse(message.getPayload());
      System.out.print("@to : " + jsonObject.get("to"));

      
      
      for (WebSocketSession sess : sessionList) {
    	String str = message.getPayload();
        sess.sendMessage(new TextMessage(session.getId() + " : " + str));
        System.out.println("str: " + str);
        
        String to = sess.getRemoteAddress().getHostName();
        
        
        
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

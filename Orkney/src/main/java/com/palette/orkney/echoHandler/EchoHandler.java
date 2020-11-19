package com.palette.orkney.echoHandler;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;





public class EchoHandler extends TextWebSocketHandler{

	 private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
	 
//	    @Autowired
//	    private TestService service;
	    
	    private static Logger logger = LoggerFactory.getLogger(EchoHandler.class);
	    private Map<String,WebSocketSession> userData=new HashMap<String,WebSocketSession>();
	    
	    //클라이언트가 연결 되었을 때 실행
	    @Override
	    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
	        sessionList.add(session);
	        logger.info("{} 연결됨", session.getId()); 
	    }

	    //클라이언트가 웹소켓 서버로 메시지를 전송했을 때 실행
	    @Override
	    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
	        logger.info("{}로 부터 {} 받음", session.getId(), message.getPayload());
	        //모든 유저에게 메세지 출력
	        
	        JSONObject jo=new JSONObject(message.getPayload());
	        		Map m=new HashMap();
	        		int userNo=0;
	        
	        if(jo.getString("type").equals("register")) {
	        	userData.put(jo.getString("user"),session);
	        }else {
	        	if(jo.getString("type").equals("text")) {
	        		for(String s:userData.keySet()) {
	        			System.out.println(s);
	        			if(userData.get(s)!=null&&s.equals(jo.getString("user"))) {
//	        				userNo=service.userNo(s);
	        				if(!jo.getString("user").equals("admin")) {
	        				m.put("userNo",userNo);
	        				m.put("sender",s);
	        				m.put("reciver","admin");
	        				m.put("message",jo.getString("ms"));
//	        				int result=service.chatData(m);
	        				}
	        				userData.get(s).sendMessage(new TextMessage(message.getPayload()));
	        			}
	        			if(s.equals("admin")&&!("admin").equals(jo.getString("user"))) {
	        				userData.get(s).sendMessage(new TextMessage(message.getPayload()));
	        			}
	        			if(("admin").equals(jo.getString("user"))&&s.equals(jo.getString("sendId"))) {
//	        				userNo=service.userNo(jo.getString("sendId"));
	        				m.put("userNo",userNo);
	        				m.put("sender","admin");
	        				m.put("reciver",jo.getString("sendId"));
	        				m.put("message",jo.getString("ms"));
//	        				int result=service.chatData(m);
	        				userData.get(s).sendMessage(new TextMessage(message.getPayload()));
	        			}
	        		}
	    
	        	}
	        }
	        
	        
//	        for(WebSocketSession sess : sessionList){
//	            sess.sendMessage(new TextMessage(message.getPayload()));
//	        }
	    }
	    //클라이언트 연결을 끊었을 때 실행
	    @Override
	    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
	        sessionList.remove(session);
	        logger.info("{} 연결 끊김.", session.getId());
	    	} 
	
}

package com.palette.orkney.google.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import com.fasterxml.jackson.annotation.JsonInclude.Include;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.PropertyNamingStrategy;
import com.google.gson.Gson;
import com.palette.orkney.google.model.vo.GoogleOAuthRequest;
import com.palette.orkney.google.model.vo.GoogleOAuthResponse;
import com.palette.orkney.member.model.service.MemberService;

@SessionAttributes("login")
@Controller
public class GoogleController {
	
	@Autowired
	private MemberService service;
	

	@RequestMapping("/login/google/auth")
	public String googleAuth(Model model, @RequestParam(value = "code") String authCode)
			throws JsonProcessingException {
		
		//HTTP Request�� ���� RestTemplate
		RestTemplate restTemplate = new RestTemplate();
		//Google OAuth Access Token ��û�� ���� �Ķ���� ����
		GoogleOAuthRequest googleOAuthRequestParam = GoogleOAuthRequest
				.builder()
				.clientId("63421017718-97poh5dtj10hbv1ul6q80h9g51tpov1d.apps.googleusercontent.com")
				.clientSecret("RlqoutVI0qC4Zw8CPuo3UBwC")
				.code(authCode)
				.redirectUri("http://localhost:9090/orkney/login/google/auth")
				.grantType("authorization_code").build();
				
		
		//JSON �Ľ��� ���� �⺻�� ����
		//��û�� �Ķ���ʹ� ������ũ ���̽��� ���õǹǷ� Object mapper�� �̸� �������ش�.
		ObjectMapper mapper = new ObjectMapper();
		mapper.setPropertyNamingStrategy(PropertyNamingStrategy.SNAKE_CASE);
		mapper.setSerializationInclusion(Include.NON_NULL);

//		https://www.googleapis.com/oauth2/v4/token
			
		//AccessToken �߱� ��û
		ResponseEntity<String> resultEntity = restTemplate.postForEntity("https://oauth2.googleapis.com/token", googleOAuthRequestParam, String.class);
		
		GoogleOAuthResponse result=new Gson().fromJson(resultEntity.getBody(),GoogleOAuthResponse.class);
		System.out.println(result);
		//Token Request
//		GoogleOAuthResponse result = mapper.readValue(resultEntity.getBody(), new TypeReference<GoogleOAuthResponse>() {
//		});

		//ID Token�� ���� (������� ������ jwt�� ���ڵ� �Ǿ��ִ�)
		String jwtToken = result.getId_token();
		String requestUrl = UriComponentsBuilder.fromHttpUrl("https://oauth2.googleapis.com/tokeninfo")
		.queryParam("id_token", jwtToken).encode().toUriString();
		
		String resultJson = restTemplate.getForObject(requestUrl, String.class);
		
		Map<String,String> userInfo = mapper.readValue(resultJson, new TypeReference<Map<String, String>>(){});
		System.out.println(userInfo);
		model.addAllAttributes(userInfo);
		model.addAttribute("aToken", result.getAccess_token());
		model.addAttribute("rToken", result.getRefresh_token());
		
		Map snsData=new HashMap();
		snsData.put("id",userInfo.get("email"));
		snsData.put("name",userInfo.get("name"));
		snsData.put("profile",userInfo.get("picture"));
		snsData.put("aToken",result.getAccess_token());
		snsData.put("rToken",result.getRefresh_token());
		System.out.println(snsData);
		boolean flag=false;
		//Map existId=service.searchGoogleId(snsData,flag);
//		if(existId==null) {
//			service.insertSnsLogin(snsData);
//			existId=service.searchGoogleId(snsData,flag);
//			model.addAttribute("login",existId);
//		}else {
//			flag=true;
//			existId=service.searchGoogleId(snsData,flag);
//			model.addAttribute("login",existId);
//		}
		return "index";

	}
	
	@GetMapping("/google/revoke/token")
	public String revokeToken(@RequestParam(value = "token") String token,SessionStatus ss) throws JsonProcessingException {
		
		//https://oauth2.googleapis.com/revoke?token=token��
		//-- <li><a href="${path }/google/revoke/token?token=${login.ACCESS_TOKEN}">�α׾ƿ�2</a></li>
		System.out.println(token);
		System.out.println();
		Map<String, String> result = new HashMap<>();
		RestTemplate restTemplate = new RestTemplate();
		String requestUrl = UriComponentsBuilder.fromHttpUrl("https://oauth2.googleapis.com/revoke")
				.queryParam("token", token).encode().toUriString();
		final String resultJson = restTemplate.postForObject(requestUrl,null,String.class);
		result.put("result", "success");
		result.put("resultJson", resultJson);
		System.out.println(resultJson);
		if(!ss.isComplete()) {
			ss.setComplete();
		}
		
		
		return "index";

	}
}

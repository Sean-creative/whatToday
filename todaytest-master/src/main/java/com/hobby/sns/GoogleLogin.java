package com.hobby.sns;

import java.io.IOException;
import java.util.concurrent.ExecutionException;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.scribejava.apis.GoogleApi20;
import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.github.scribejava.core.model.OAuthRequest;
import com.github.scribejava.core.model.Response;
import com.github.scribejava.core.model.Verb;
import com.github.scribejava.core.oauth.OAuth20Service;

/**
 * 구글 로그인 인증 URL 생성/ 사용자 프로필 API 호출 
 * @author jiyeong
 *
 */
public class GoogleLogin {

	/* 인증 요청문을 구성하는 파라미터 */
	private final static String CLIENT_ID = "306036003490-stl04ho7t5kkqj9gji3kifnnnfc72sdt.apps.googleusercontent.com";
	private final static String CLIENT_SECRET = "uiPTCEBP98l6RYcV1Jl60pKu";
	private final static String REDIRECT_URI = "http://localhost:8088/login/auth/google/callback";
	private final static String EMAIL_SCOPE = "https://www.googleapis.com/auth/userinfo.email";
	
	// 사용자 이름 정보가져오는 scope
//	private final static String NAME_SCOPE = "https://www.googleapis.com/auth/userinfo.profile";
	
	/* 프로필 조회 API URL */
	private final static String PROFILE_API_URL = "https://www.googleapis.com/oauth2/v1/userinfo";

	private static OAuth20Service oauthService;
	
	/* 구글 아이디로 인증  URL 생성  Method */
	public static String getAuthorizationUrl() {
		oauthService = new ServiceBuilder(CLIENT_ID)                                                   
				.apiSecret(CLIENT_SECRET)
				.callback(REDIRECT_URI)
				.scope(EMAIL_SCOPE)
				.build(GoogleApi20.instance());	
		
		return oauthService.getAuthorizationUrl();
	}
	
	/* 구글  Callback 처리 및  AccessToken 획득 Method */
	public static OAuth2AccessToken getAccessToken(String code) throws IOException, InterruptedException, ExecutionException{
		OAuth2AccessToken accessToken = oauthService.getAccessToken(code);
		System.out.println("accessToken: " + accessToken);
		
		return accessToken;
	}

	/* Access Token을 이용하여 구글 사용자 프로필 API를 호출 */
	public static String getUserProfile(OAuth2AccessToken oauthToken) throws IOException, InterruptedException, ExecutionException{
		OAuthRequest request = new OAuthRequest(Verb.GET, PROFILE_API_URL);
		oauthService.signRequest(oauthToken, request);

		Response response = oauthService.execute(request);

		System.out.println("response: " + response.getBody());
		ObjectMapper mapper = new ObjectMapper();
		JsonNode rootNode = mapper.readTree(response.getBody());

		System.out.println("rootNode: " + rootNode);

		return response.getBody();
	}




}


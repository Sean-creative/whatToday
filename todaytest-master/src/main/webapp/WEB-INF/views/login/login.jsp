<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- 작성자: 김지영 -->
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/resources/css/login.css">
    <title>Login</title>
</head>
<body>
    <div id="login">
        <div class="loginbx">
            <h1>LOGIN</h1>
            <hr>
            <form method="post" action="/login">
                <div>
                    <input type="text" name="username" value="${username }" placeholder="아이디 입력">
                </div>
                <div>
                    <input type="password" name="password" value="${password }" placeholder="비밀번호 입력(영문,숫자,특수문자조합)">
                </div>
                <div>
                	<button type="submit">로그인</button>
                	 <!--<input type="submit" value="로그인">--> 
                </div>

                <div class="check">
                    <input type="checkbox" id="cb1" name='remember-me'>
                    <span>아이디 저장</span>
                </div>
                <hr>

                <div id="sns">
                    <div OnClick="location.href='https://kauth.kakao.com/oauth/authorize?client_id=14e5f73be7a3dcdce0e0cf981f72f775&redirect_uri=http://localhost:8080/login/kakaoLogin&response_type=code'">
                        <div class="kakao"></div>
                        <p>카카오<br>로그인</p>
                    </div>

                    <div OnClick="location.href='/login/naverLogin'">
                        <div class="naver"></div>
                        <p>네이버<br>로그인</p>
                    </div>
                    <div>
                        <div class="google"></div>
                        <!-- 아직 적용 안됨 -->
                        <p>구글<br>로그인</p>
                    </div>
                </div>
                <!-- <hr> -->
                <div id="idpass">
                    <a href="/login/find">아이디 찾기 | 비밀번호 찾기</a>
                </div>

                <div id="membership" OnClick="location.href='/login/register'">
                    <p>아직 회원이 아니세요?</p>
                    <p>회원가입 ></p>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
<%@ include file="../includes/footer.jsp"%>
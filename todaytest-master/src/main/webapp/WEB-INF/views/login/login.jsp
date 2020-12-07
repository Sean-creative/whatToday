<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- 작성자: 김지영 -->
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/resources/css/registerStyle.css">
</head>
<body>
	<div style="max-width: 500px; margin: auto"></div>

	<form method="post" action="/login"
		style="max-width: 500px; margin: auto">
		<h2>회원 로그인 </h2>
		<div class="input-container">
			<label>이메일(아이디) </label>
			<!-- type="email" test하고  바꾸기 -->
			<input class="input-field" type="text" placeholder="Email"
				name="username" value = "${username }">
		</div>

		<div class="input-container">
			<label>비밀번호 </label> <input class="input-field" type="password"
				placeholder="Password" name="password" value = "${password }">
		</div>
		
		<div>
			<!-- security-context.xml에서 태그security:remember-me로 쿠키 생성  // 데이터 베이스 이용 -->
			<input type='checkbox' name='remember-me'>로그인 유지 
		</div>
	
		<a href="/login/register">회원가입</a>
		<a href="/login/find">아이디/비밀번호 찾기</a>
		<br>
		<a href="https://kauth.kakao.com/oauth/authorize?client_id=14e5f73be7a3dcdce0e0cf981f72f775&redirect_uri=	
http://localhost:8080/login/kakaoLogin&response_type=code">카카오 로그인</a><br>

		<a href="/login/naverLogin">네이버 로그인</a>
		<a href="http://nid.naver.com/nidlogin.logout">네이버 로그아웃(TEST)</a>

		<button type="submit" class="btn">LOG IN</button>
	</form>

<script type="text/javascript">
	// 모달창으로 변경 예정
	if("${registerSuccessMsg }" != ""){
		alert("회원가입 성공! ${registerSuccessMsg}님 반갑습니다.");
	}
	
</script>
 

</body>
</html>
<%@ include file="../includes/footer.jsp"%>
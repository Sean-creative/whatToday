<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri = "http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="/resources/css/style.css">
    <title>Document</title>
</head>
<body>

<!-- Masthead-->
    <header id=header>

      <a href="/index/main">
        <img src="/resources/img/logo.png" alt="logo">
      </a>
        <input type="text" placeholder="관심취미를 입력해주세요.">
        <ul>
            <a href="/login/login">로그인</a>
            <a href="/cs/faq">고객센터</a>
        </ul>
        <!-- 로그인되면 보여지는 페이지 -->
        <sec:authorize access="isAuthenticated()">			
			<ul>
        		<a href ="/"><sec:authentication property="principal.user.usrNum"/>님</a>
            	<a href="/login/logout">로그아웃</a>
            	<a href="/account/main">마이페이지</a>
           		<a href="">고객센터</a>
       	 	</ul>
		</sec:authorize>
		
<!-- Navigation-->
        <nav id="nav">
            <ul>
                <a href="">三</a>
                <a href="/regular/list">정기</a>
                <a href="/thunder/list">번개</a>
                <a href="/thunder/add">번개개설</a>
                <a href="">베스트</a>
                <a href="">추천</a>
                <div class="dropdown">모임개설
  					<div class="dropdown-content">
  						<a href="/regular/add">정기모임</a>
      					<a href="/thunder/add">번개모임</a>
  					</div>
				</div>
            </ul>
        </nav>
      </header>
<div id="wrap">

    <section id="#thunder_add">
    </section>


</div>

<script src="http://code.jquery.com/jquery-latest.js"></script>
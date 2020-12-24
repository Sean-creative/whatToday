<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" type="text/css" href="/resources/css/slimHeader.css">
</head>
<body>
   <div id="header">
      <div id="head">
         <div class="menu1">
            <a href="/index/main">
               <img src="/resources/img/logo.png" alt="logo">
            </a>
         </div>
         <sec:authorize access="isAnonymous()">
            <div class="menu2">
               <li><a href="/login/login">로그인</a></li>
               <li><a href="/cs/faq">고객센터</a></li>
            </div>
         </sec:authorize>     
      </div>
	</div>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<style>
#test{
    height:90vh;
    display: flex;
    justify-content: center;
    align-items: center;
  
}

.testbx{
    width: 900px;
    height: 600px;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
    text-align:center;    
}

#testQuestions{
	margin : 125px;	
}

#regularResult{
    display:flex;
    justify-content:space-evenly;
}

#thunderResult{
    display:flex;
    justify-content:space-evenly;
}

.testReuslt1{
    width:80px;
    height:80px;
    background-size: cover;
    border-radius: 50%;
}

.testReuslt2{
    width:80px;
    height:80px;
    background-size: cover;
    border-radius: 50%;
}

.testReuslt3{
    width:80px;
    height:80px;
    background-size: cover;
    border-radius: 50%;
}
</style>

</head>
<body>
	<div id ="test">
	<div class="testbx">
		  <div id = "testQuestions">
		  <h1>취미 분석 테스트</h1><br><br>
		  <h3>당신의 취미를 찾아드립니다.</h3><br><br><br>
			  <div id="regularResult">
					<div OnClick="location.href='http://localhost:8080/regular/list?category=${testReuslt1.category}&subclass=${testReuslt1.subclass}'">
						<div class="testReuslt1"></div><br>
						<p>${testReuslt1.subclass}</p>
					</div>
	
					<div OnClick="location.href='http://localhost:8080/regular/list?category=${testReuslt2.category}&subclass=${testReuslt2.subclass}'">
						<div class="testReuslt2"></div><br>
						<p>${testReuslt2.subclass}</p>
					</div>
	
					<div OnClick="location.href='http://localhost:8080/regular/list?category=${testReuslt3.category}&subclass=${testReuslt3.subclass}'">
						<div class="testReuslt3"></div><br>
						<p>${testReuslt3.subclass}</p>
					</div>
				</div>
			
				<div id="thunderResult">
					<div OnClick="location.href='http://localhost:8080/thunder/list?category=${testReuslt1.category}&subclass=${testReuslt1.subclass}'">
						<div class="testReuslt1"></div><br>
						<p>${testReuslt1.subclass}</p>
					</div>
	
					<div OnClick="location.href='http://localhost:8080/thunder/list?category=${testReuslt2.category}&subclass=${testReuslt2.subclass}'">
						<div class="testReuslt2"></div><br>
						<p>${testReuslt2.subclass}</p>
					</div>
	
					<div OnClick="location.href='http://localhost:8080/thunder/list?category=${testReuslt3.category}&subclass=${testReuslt3.subclass}'">
						<div class="testReuslt3"></div><br>
						<p>${testReuslt3.subclass}</p>
					</div>
				</div>
			</div>
	</div>
	</div>
	
	
<script type="text/javascript">
	let hiking = "/resources/img/kakao.png";
	let traking ="/resources/img/naver.png";
	let camping ="/resources/img/naver.png";
	$( document ).ready(function() {
		document.getElementByName("testReuslt1").style.backgroundImage = "url('" + hiking + "')";
		document.getElementByName("testReuslt2").style.backgroundImage = "url('" + traking + "')";
		document.getElementByName("testReuslt3").style.backgroundImage = "url('" + camping + "')";
	});

</script>	
</body>
</html>
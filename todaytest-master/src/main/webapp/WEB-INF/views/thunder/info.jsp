<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!-- 작성자 : 김선우 -->
<%@include file="../includes/header.jsp"%>
<style>
section a:link {
	color: white;
	text-decoration: none;
}

section a:visited {
	color: white;
	text-decoration: none;
}

section a:hover {
	color: red;
	text-decoration: none;
}
</style>


	<!--  번개 모임 개설 -->
	<section id="wrap" style="border: 1px solid; margin-top: 30px">
		<form action="#" method="post">

			<div style="display: flex; margin-bottom: 30px">
				<div
					style="text-align: center; margin: 0px; width: 50%; padding: 15px; background-color: orange; color: white; font-size: 40px; border: 1px solid;">
					<a class="info" href="#">정보</a><br>
				</div>
				<div
					style="text-align: center; margin: 0px; width: 50%; padding: 15px; background-color: orange; color: white; font-size: 40px; border: 1px solid;">
					<a class="info" href="#">채팅</a><br>
				</div>
			</div>


			<div style="font-size: 30px; text-align: center; margin: 20px">
				<b> "<c:out value="${clubVO.cbName}" />"
				</b>
			</div>

			<div style="margin-left: 30px;">
				<div style="float: left; margin-right: 50px">
					<div style="margin: 2px 0px">
						<img src="/resources/img/thunderImg.png" width="170" height="170"
							alt="번개대표사진">
					</div>
					<br>
				</div>

				<div style="font-size: 20px; margin-left: 15%; margin-bottom: 20px;">
					<c:out value="${clubVO.cbIntro}" />
				</div>


				<div style="font-size: 20px; margin-left: 15%; margin-bottom: 20px;">
					<b> <c:out value="${clubVO.cbHashtag}" />
					</b>
				</div>

				<div style="font-size: 20px; margin-left: 15%; margin-bottom: 10px;">
					모임일정 :
					<c:out value="${clubVO.thunderDetailVO.cbDate}" />
				</div>
				<div style="font-size: 20px; margin-left: 15%; margin-bottom: 10px;">
					모임장소 :
					<c:out
						value="${clubVO.cbCity} ${clubVO.cbDistrict} ${clubVO.thunderDetailVO.cbPlace}" />
				</div>
				<div style="font-size: 20px; margin-left: 15%; margin-bottom: 10px;">
					모임인원 :
					<c:out
						value="${clubVO.cbCurMbnum}/${clubVO.cbMbnum}" />
				</div>
				<br>

				<div style="font-size: 20px; margin-left: 15%; margin-bottom: 10px;">
					준비물 :
					<c:out value="${clubVO.thunderDetailVO.cbSupplies}" />
				</div>


			</div>



			<div style="margin-bottom: 30px; margin-left: 10px;">
				개설자 정보<br> <br>

				<div style="border: 1px solid; float: left">
					<img src="../resources/img/thunderHuman.png">
				</div>

				<div>
					<c:out value="${userVO.usrName}" />
					<br>
					<c:out value="${userVO.usrId}" />
				</div>

				<div
					style="width: 500px; height: 50px; border: 1px solid; text-align: center;">
					<c:out value="${clubVO.thunderDetailVO.cbAppPeriod}" />
				</div>
			</div>

<div style="float:right"> 	
	<c:if test="${usrNum eq clubVO.cbLeaderNum}">
		<button  data-oper='modify' class="btn btn-default">Modify</button>
	</c:if>

		

		<button  data-oper='list' class="btn btn-info">List</button>
</div>
		</form>

			<input id="sign" type="button" style="margin-left: 230px; padding: 5px 80px; margin-bottom: 30px;" value="신청하기"/>
		
		
		<form id ='operForm' action="/thunder/modify" method="get">
                           	<input type='hidden' id='cbNum' name='cbNum' value='<c:out value="${clubVO.cbNum}"/>'>
                           	<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum}"/>'>
                           	<input type='hidden' name='amount' value='<c:out value="${cri.amount}"/>'>
                           	
							<input type='hidden' name='category' value='<c:out value="${cri.category}"/>'>
							<input type='hidden' name='subclass' value='<c:out value="${cri.subclass}"/>'>
							<input type='hidden' name='city' value='<c:out value="${cri.city}"/>'>
							<input type='hidden' name='district' value='<c:out value="${cri.district}"/>'>                           	                           	                           	
                           	<input type='hidden' name='keyword' value='<c:out value="${cri.keyword}"/>'>                           							
                           </form>



		<div id="plusDiv" style="display: none">
			<hr style="width: 70%; margin: 20px auto; border: solid 3px green;">
			<div style="text-align: center; font-size: 30px;">
				"오늘은 같이 농구해요!" -- 참석자(4/6)
				<button id="pulsButton" onclick=viewPlus();
					style="text-align: center; width: 100px; height: 100px; font-size: 80px; margin: 0px; overflow: hidden;">🐵</button>
			</div>

			<div id="plus"
				style="width: 70%; border: 1px solid; margin: 30px auto; display: none">
				<div style="display: flex; margin-bottom: 30px; margin: 0px;">
					<div
						style="text-align: center; margin: 0px; width: 50%; padding: 15px; font-size: 30px;">
						<img src="../resources/img/thunderHuman.png"
							style="width: 80px; height: 80px;"> 김지영 모임장
					</div>
					<div
						style="text-align: center; margin: 0px; width: 50%; padding: 15px; font-size: 30px;">
						<img src="../resources/img/thunderHuman.png"
							style="width: 80px; height: 80px;"> 김영지 회원
					</div>
				</div>

				<div style="display: flex; margin-bottom: 30px; margin: 0px;">
					<div
						style="text-align: center; margin: 0px; width: 50%; padding: 15px; font-size: 30px;">
						<img src="../resources/img/thunderHuman.png"
							style="width: 80px; height: 80px;"> 김선우 회원
					</div>
					<div
						style="text-align: center; margin: 0px; width: 50%; padding: 15px; font-size: 30px;">
						<img src="../resources/img/thunderHuman.png"
							style="width: 80px; height: 80px;"> 김우선 회원
					</div>
				</div>
			</div>
		</div>


	</section>

	<script type="text/javascript">
	
		$(document)
				.ready(
						function() {
							
							
							
							
							
							
							
							

							console.log("<c:out value="${clubVO}" />")
							var operForm = $("#operForm");

							$("button[data-oper='modify']").on(
									"click",
									function(e) {
										e.preventDefault();
										operForm.attr("action",
												"/thunder/modify").submit();
									});

							$("button[data-oper='list']")
									.on(
											"click",
											function(e) {
												e.preventDefault();
												console.log("??????");
												console.log('click');
												/* operForm.find("#cbNum").remove(); */
												operForm.attr("action",
														"/thunder/list")
												console.log("operForm.attr");

												operForm.submit();
											});
						
							
							
						});
		

		function viewPlus() {

			if (document.getElementById("plus").style.display == 'none') {
				document.getElementById("plus").style.display = 'block';
				document.getElementById("pulsButton").innerHTML = "🙊";
			} else {
				document.getElementById("plus").style.display = 'none';
				document.getElementById("pulsButton").innerHTML = "🐵";
			}
		}
		$("#sign").click(function() {

			if (document.getElementById("sign").value == '신청하기') {
				document.getElementById("sign").value = '취소하기';
				alert('번개모임이 신청되었습니다.');
				document.getElementById("plusDiv").style.display = "block";									
			} 
			else if (document.getElementById("sign").value == '취소하기') {
				document.getElementById("sign").value = '신청하기';
				alert('번개모임이 취소되었습니다.');
				document.getElementById("plusDiv").style.display = "none";
				document.getElementById("plus").style.display = 'none';
				document.getElementById("pulsButton").value = "🐵";
			}
		});
		
		
	</script>


<%@include file="../includes/footer.jsp"%>
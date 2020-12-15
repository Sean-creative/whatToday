<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

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

.oriImg {
	width: 200;
	height: auto;
}

.thumbImg {
	width: 200px;
	height: auto;
}

* {
	margin: 0;
	padding: 0;
	list-style: none;
}

ul li {
	display: inline-block;
	margin: 0 5px;
	font-size: 14px;
	letter-spacing: -.5px;
}

form {
	padding-top: 16px;
}

ul li.tag-item {
	padding: 4px 8px;
	background-color: orange;
	color: white;
}

.tag-item:hover {
	background-color: #262626;
	color: #fff;
}

/* .del-btn {
          font-size: 12px;
          font-weight: bold;
          cursor: pointer;
          margin-left: 8px;
      } */
</style>


<!--  번개 모임 개설 -->
<section id="wrap" style="border: 1px solid; margin-top: 30px">

	<h1>
		<c:out value="${text}" />
	</h1>

	<div style="display: flex; margin-bottom: 30px">
		<div style="text-align: center; margin: 0px; width: 50%; padding: 15px; background-color: orange; color: white; font-size: 40px; border: 1px solid;">
			<a class="info" href="#">정보</a>
			<br>
		</div>
		<div style="text-align: center; margin: 0px; width: 50%; padding: 15px; background-color: orange; color: white; font-size: 40px; border: 1px solid;">
			<a class="info" href="#">채팅</a>
			<br>
		</div>
	</div>


	<div style="font-size: 30px; text-align: center; margin: 20px">
		<b> "<c:out value="${clubVO.cbName}" />"
		</b>
	</div>

	<div style="margin-left: 30px;">
		<!-- 사진 왼쪽에 붙어있게 -->
		<div style="float: left; padding-bottom: 20px; margin: 0px;">
			<!-- <img src="/resources/img/thunderImg.png" width="170" height="170" alt="번개대표사진"> -->


			<div class="inputArea">
				<label for="gdsImg">썸네일</label> <img src="${clubVO.cbThumbImg}" class="thumbImg" />
			</div>


		</div>


		<!-- 사진 기준 오른쪽에 붙어 있게 끔 -->
		<div style="width: 70%; margin: 0px; margin-left: 10%;">
			<div style="font-size: 20px; margin-bottom: 20px; word-break: break-all; word-wrap: break-word;">
				<c:out value="${clubVO.cbIntro}" />
			</div>



			<!-- 지정된 포맷으로 보내기 위해, JS단에서 값을 넣어준다. -->
			<div style="font-size: 20px; margin-bottom: 20px;" id="date">
				모임일정 :
				<fmt:parseDate var="dateString" value="${clubVO.thunderDetailVO.cbDate}" pattern="yyyy-MM-dd'T'HH:mm" />
				<fmt:formatDate value="${dateString}" pattern="M월 d일  E'요일' a h시  m분" />
			</div>

			<div style="font-size: 20px; margin-bottom: 20px;">
				모임장소 :
				<c:out value="${clubVO.cbCity} ${clubVO.cbDistrict} ${clubVO.thunderDetailVO.cbPlace}" />
			</div>
			<div style="font-size: 20px; margin-bottom: 20px;">
				모임인원 :
				<c:out value="${clubVO.cbCurMbnum}/${clubVO.cbMbnum}" />
			</div>
			<br>

			<div style="font-size: 20px; margin-bottom: 20px;">
				준비물 :
				<c:out value="${clubVO.thunderDetailVO.cbSupplies}" />
			</div>

		</div>
	</div>



	<div style="margin-bottom: 30px; margin-left: 10px;">
		개설자 정보<br>
		<div style="border: 1px solid; width: 120px; height: 130px; float: left;">

			<img src="../resources/img/thunderHuman.png">
		</div>

		<div style="position: relative; left: 20px;">
			<c:out value="${userVO.usrName}" />
			<br>
			<c:out value="${userVO.usrId}" />
		</div>

		<div style="width: 500px; height: 50px; position: relative; left: 130px; border: 1px solid; text-align: center;" id="period">
			<fmt:parseDate var="dateString" value="${clubVO.thunderDetailVO.cbAppPeriod}" pattern="yyyy-MM-dd'T'HH:mm" />
			<fmt:formatDate value="${dateString}" pattern="M월 d일  E'요일' a h시  m분 까지 신청" />
		</div>
	</div>


	<!-- 해시태그 구현 -->
	<br>
	<div style="font-size: 20px; margin-bottom: 20px;">
		<div style="float: left;">해시태그 :</div>
		<ul id="tag-list">
		</ul>
	</div>



	<div style="float: right">
		<!-- 지금 로그인된 유저의 정보와 개설자의 번호가 일치하면(=같은사람 이라면) modify 버튼을 보여준다.-->
		<c:if test="${usrNum eq clubVO.cbLeaderNum}">
			<button data-oper='modify' class="btn btn-default">Modify</button>
		</c:if>



		<button data-oper='list' class="btn btn-info">List</button>
	</div>


	<!-- 로그인한유저와 모임장이 같은 사람이 아니라면 버튼을 보여줘야한다. -->
	<c:if test="${usrNum != clubVO.cbLeaderNum}">
		<button style="margin-left: 230px; padding: 5px 80px; margin-bottom: 30px;" class="btn btn-info" data-oper='join' id="join">
			<!-- joinState - 모임추방, 모임만료, 모임탈퇴, 가입승인, Null (아직 데이터 넣기 전) -->
			<!-- 모임 마감 까지도 아니면, 모임 가입하기 보여주는 것으로 한다. 그러면 순서가 맞음 -->
			<c:choose>
				<c:when test="${joinState eq '가입승인'}">모임 나가기</c:when>
				<c:when test="${joinState eq '모임추방'}">모임 가입불가</c:when>
				<c:when test="${clubVO.cbCurMbnum == clubVO.cbMbnum}">모임 정원 초과</c:when>

				<c:when test="${joinState eq '모임탈퇴' || joinState == null}">모임 가입하기</c:when>
			</c:choose>
		</button>
	</c:if>




	<form id='operForm' action="/thunder/modify" method="get">
		<input type='hidden' id='cbNum' name='cbNum' value='<c:out value="${clubVO.cbNum}"/>'>
		<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum}"/>'>
		<input type='hidden' name='amount' value='<c:out value="${cri.amount}"/>'>
		<input type='hidden' name='category' value='<c:out value="${cri.category}"/>'>
		<input type='hidden' name='subclass' value='<c:out value="${cri.subclass}"/>'>
		<input type='hidden' name='city' value='<c:out value="${cri.city}"/>'>
		<input type='hidden' name='district' value='<c:out value="${cri.district}"/>'>
		<input type='hidden' name='searchBy' value='<c:out value="${cri.searchBy}"/>'>
		<input type='hidden' name='keyword' value='<c:out value="${cri.keyword}"/>'>
		<input type='hidden' name='joinState' value='<c:out value="${joinState}"/>'>
	</form>









	<div id="plusDiv" style="display: block">
		<hr style="width: 70%; margin: 20px auto; border: solid 3px green;">
		<div style="text-align: center; font-size: 30px;">
			"
			<c:out value="${clubVO.cbName}" />
			" -- 참석자(${fn:length(joinList)}/
			<c:out value="${clubVO.cbMbnum}" />
			)
			<button id="pulsButton" onclick=viewPlus(); style="text-align: center; width: 100px; height: 100px; font-size: 80px; margin: 0px; overflow: hidden;">🐵</button>
		</div>

		<div id="plus" style="width: 70%; border: 1px solid; margin: 30px auto; display: none">
			<div style="display: flex; flex-wrap: wrap; margin-bottom: 30px; margin: 0px;">


				<c:forEach items="${joinList}" var="ClubMemberVO">
					<div style="text-align: center; margin: 0px; width: 40%; padding: 15px; font-size: 30px;">
						<img src="../resources/img/thunderHuman.png" style="width: 80px; height: 80px;">

						<c:choose>
							<c:when test="${ClubMemberVO.usrNum == clubVO.cbLeaderNum}">모임장</c:when>
							<c:otherwise>모임원</c:otherwise>
						</c:choose>

						<br> ${ClubMemberVO.usrName}
					</div>
				</c:forEach>
			</div>

		</div>
		<!-- plus END -->
	</div>
</section>



<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.14.1/moment.min.js"></script> -->
<script type="text/javascript">
	$(document).ready(
			function() {

				console.log("<c:out value="${clubVO}" />")
				let operForm = $("#operForm");

				$("button[data-oper='join']").on(
						"click",
						function(e) {
							e.preventDefault();
							operForm.attr("action", "/thunder/join").attr(
									"method", "post").submit();
						});

				$("button[data-oper='modify']").on("click", function(e) {
					e.preventDefault();
					operForm.attr("action", "/thunder/modify").submit();
				});

				$("button[data-oper='list']").on("click", function(e) {
					e.preventDefault();
					console.log('button - list click');
					/* operForm.find("#cbNum").remove(); */
					operForm.attr("action", "/thunder/list")
					console.log("operForm.attr");

					operForm.submit();
				});
			});

	/* let nowDate = '${clubVO.thunderDetailVO.cbDate}';
	nowDate = moment(nowDate).format("YYYY년 MM월 DD일 A hh시 mm분 ");
	$("#date").html('모임일정 :  ' + nowDate);

	let deadDate = '${clubVO.thunderDetailVO.cbAppPeriod}';
	deadDate = moment(deadDate).format("YYYY년 MM월 DD일 A hh시 mm분 ");
	$("#period").html("<b>" + deadDate + "</b>" + "  까지 신청"); */

	// * 신청하기, 신청 취소하기 버튼 로직 *
	// A. 신청하기
	// 1. 개설한 사람이 아니다.
	// 2. 신청을 하지 않은 사람 (로그인 자체는 컨트롤러 단에서 해결 )
	// 조건을 위해 필요 한 것 -> 개설한 사람의 번호, 로그인한 사람의 번호
	/* 		30번(로그인한 사람의 번호)이 신청을 했는지 안했는지 어떻게 알지? -> 모임멤버 테이블에 CBMBSTRESULT가 '활동중' 이어야 한다.
	 if ( (개설한 사람의 번호 != 로그인한 사람의 번호) && (CBMBSTRESULT != '활동중') )
	
	 val = '신청하기'
	 */

	// B. 신청 취소하기
	// 1. 개설한한 사람이 아니다.
	// 2. 신청을 한 사람
	/* 2차 구현 예정........... */

	console.log($("#join").text().trim());
	if ($("#join").text().trim() == '모임 나가기') {
		//모임에 참석중일 때
		document.getElementById("plusDiv").style.display = "block";
		document.getElementById("pulsButton").value = "🐵";
	} else if ($("#join").text().trim() == '모임 가입하기') {
		//모임에 참석 중이 아닐 때
		document.getElementById("plusDiv").style.display = "none";
		document.getElementById("plus").style.display = 'none';

	} else if ($("#join").text().trim() == '모임 가입불가'
			|| $("#join").text().trim() == '모임 정원 초과') {
		//모임에 가입이 불가능 할 때
		document.getElementById('join').disabled = 'disabled';
		document.getElementById("plusDiv").style.display = "none";
		document.getElementById("plus").style.display = 'none'
	}

	function viewPlus() {

		if (document.getElementById("plus").style.display == 'none') {
			document.getElementById("plus").style.display = 'block';
			document.getElementById("pulsButton").innerHTML = "🙊";
		} else {
			document.getElementById("plus").style.display = 'none';
			document.getElementById("pulsButton").innerHTML = "🐵";
		}
	}

	/* 해시태그 구현관련!! */
	let stringHash = '${clubVO.cbHashtag}';
	console.log(stringHash);

	let arrayHash = stringHash.split(',');
	console.log(arrayHash);
	
	for ( let i in arrayHash) {
		if (arrayHash[i] != "") {
		$("#tag-list").append("<li class='tag-item'>" + arrayHash[i] + "</li>");		
		}
	}
</script>


<%@include file="../includes/footer.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!-- 작성자 : 김선우 -->
<%@include file="../includes/header.jsp"%>
<link rel="stylesheet" type="text/css" href="/resources/css/thunderInfo.css">
<link rel="stylesheet" type="text/css" href="/resources/css/kakaoMap.css">

<style>
* {
	margin: 0;
	padding: 0;
}

#bgpic {
	width: 100%;
	height: 400px;
	background: #ffaf31;
	position: relative;
	display: flex;
	justify-content: center;
}

#detail {
	width: 1200px;
	position: absolute;
	top: 150px;
	display: flex;
	justify-content: space-evenly;
	box-sizing: border-box;
}

#leftinfo {
	width: 800px;
}

#leftinfo img {
	width: 100%;
	height: 400px;
	border-radius: 20px;
}

#rightinfo {
	width: 30%;
	height: 400px;
	background: #ffffff;
	/* border:1px solid #eee; */
	box-shadow: 0 0 5px rgba(0, 0, 0, 0.2);
	margin-left: 20px;
	border-radius: 20px;
}

.uu {
	position: -webkit-sticky;
	position: sticky;
	top: 150px;
	margin-left: 70%;
}

/* ======해쉬태그  */
#phashtag {
	width: 100%;
	height: 80px;
	/* background:#ab1111; */
	display: flex;
}

.hashpp {
	width: 70px;
	height: 30px;
	background: #fff;
	border-radius: 30px;
	border: 1px solid #666;
	text-align: center;
	line-height: 30px;
	font-weight: bold;
}
/* ========== */
#error {
	width: 100%;
	height: 150px;
	background:white;
	display: flex;
}

#error .infole {
	width: 30%;
	/* background:pink; */
}

#error .infole>p {
	font-size: 20px;
	font-weight: bold;
	color: #333;
}

#error .inforig {
	width: 70%;
	/* background:beige */
}

/* 상세 내용  */
#pdetail {
	width: 100%;
	height: auto;
	/* background:pink; */
	display: flex;
}

#pdetail .infole {
	width: 30%;
	/* background:pink; */
}

#pdetail .infole>p {
	font-size: 20px;
	font-weight: bold;
	color: #333;
}

#pdetail .inforig {
	width: 70%;
	/* background:beige */
}

/* 모임명  */
.clubb {
	font-size: 18px;
	color: #333;
	padding: 20px;
	padding-top: 0;
}

.clubname {
	font-size: 20px;
	background: linear-gradient(to top, rgba(255, 175, 49, 0.7) 50%, transparent 50%);
}
/* 한줄소개 */
.clubintro {
	font-size: 18px;
	color: #333;
	padding: 20px;
}

.cluban {
	width: 100%;
	height: 80px;
	display: flex;
	justify-content: space-between;
	background: rgba(241, 237, 237, 0.7);
	border-radius: 20px;
	padding: 20px;
}

.moinname {
	font-weight: bold;
	font-size: 16px;
	padding-bottom: 10px;
}

.cluban button {
	width: 100px;
	height: 30px;
	background: #ffaf31;
	margin-top: 30px;
	border: none;
	color: #fff;
}

.sticky {
	position: sticky;
	top: 40px;
	/* margin-left:70%; */
}
</style>



<!--  번개 모임 상세페이지 -->
<section id="wrap">

	<div id="bgpic">
		<div id="detail">
			<div id="leftinfo">
				<img src="${clubVO.cbThumbImg}" class="thumbImg" />

					<!-- 해시태그 구현 -->
					<br>
					<ul id="tag-list"></ul>

				<div id="phashtag">
					<div class="hashpp">
						<p>#등산</p>
					</div>
				</div>
				

				<div id="error">
					<div class="infole">
						<p>모임명이 무엇인가요?</p>
					</div>
					<div class="inforig">
						<span class="clubname">&#8727;모임명 : <c:out value="${clubVO.cbName}" /></span>
						<p class="clubintro">&#9829; 한줄소개 : <c:out value="${clubVO.cbIntro}" /></p>
					</div>
				</div>

				<div id="error">
					<div class="infole">
						<p>카테고리는 무엇인가요?</p>
					</div>
					<div class="inforig">
						<p class="clubb">등산 입니다.</p>
					</div>
				</div>

				<div id="error">
					<div class="infole">
						<p>지역은 어디인가요?</p>
					</div>
					<div class="inforig">
						<%-- <c:out value="${clubVO.cbCity} ${clubVO.cbDistrict} ${clubVO.thunderDetailVO.cbPlace}" /> --%>
						<p class="clubb"><c:out value="${clubVO.cbCity} ${clubVO.cbDistrict} " /></p>
						<p class="clubintro"><c:out value="${clubVO.thunderDetailVO.cbPlace}" /></p>
					</div>
				</div>

				<div id="error">
					<div class="infole">
						<p>정원은 몇명인가요?</p>
					</div>
					<div class="inforig">
						<p class="clubb"><c:out value="${clubVO.cbCurMbnum}/${clubVO.cbMbnum}" />명 입니다.</p>
					</div>
				</div>

				<div id="error">
					<div class="infole">
						<p>개설자를 소개합니다.</p>
					</div>
					<div class="inforig">
						<p class="clubb">이름</p>
						<p class="clubintro">아이디</p>
					</div>
				</div>

				<div id="error">
					<div class="infole">
						<p>이 모임에 가입된 회원은?</p>
					</div>
					<div class="inforig">
						<p class="clubb">이름</p>
					</div>
				</div>

				<div id="pdetail">
					<div class="infole">
						<p>이 모임은 어떤 모임인가요?</p>
					</div>
					<div class="inforig">
						<p class="clubb">ㅁㅇㄹㅁㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹㅁㄴㅇㄹ</p>
					</div>
				</div>


				<div id="orange">
					<div id="plusDiv">
						<div>
							"
							<c:out value="${clubVO.cbName}" />
							" -- 참석자(${fn:length(joinList)}/
							<c:out value="${clubVO.cbMbnum}" />
							)
							<button id="plusButton" onclick=viewPlus();>🐵</button>
						</div>


						<div id="plus">
							<div>
								<c:forEach items="${joinList}" var="ClubMemberVO">
									<div>
										<img src="../resources/img/thunderHuman.png">

										<c:choose>
											<c:when test="${ClubMemberVO.usrNum == clubVO.cbLeaderNum}">모임장</c:when>
											<c:otherwise>모임원</c:otherwise>
										</c:choose>

										<br> ${ClubMemberVO.usrName}
									</div>
								</c:forEach>
							</div>

						</div>
					</div>
					<!-- plus END -->
				</div>
				<!-- orange END -->



				<div id="ab1111">

					<!-- 카카오 맵 -->
					<div class="map_wrap">
						<div id="map"></div>
						<div id="menu_wrap" class="bg_white">
							<div class="option">
								<div>
									<form role="form" onsubmit="searchPlaces(); return false;">
										모임 장소 :
										<input type="text" value=<c:out value="${clubVO.thunderDetailVO.cbPlace}" /> id="keyword" size="15">

										<button type="submit">검색하기</button>
									</form>
								</div>
							</div>
							<hr>
							<ul id="placesList"></ul>
							<div id="pagination"></div>
						</div>
					</div>
					<!-- 카카오맵 END -->
				</div>
				<!-- ab1111 END -->
			</div>
			<!-- left INFO END -->




			<div id="rightinfo" class="rightinfo">
				<div class="content">

					<br>
					<c:out value="${userVO.usrName}" />
					<br>
					<c:out value="${userVO.usrId}" />

					<br> <img src="../resources/img/thunderHuman.png"> <br>
					<fmt:parseDate var="dateString" value="${clubVO.thunderDetailVO.cbAppPeriod}" pattern="yyyy-MM-dd'T'HH:mm" />
					<fmt:formatDate value="${dateString}" pattern="M월 d일  E'요일' a h시  m분 까지 신청" />


					<!-- 해시태그 구현 -->
					<!-- <br>
					<ul id="tag-list"></ul> --> 

					<br>
					<!-- 로그인한유저와 모임장이 같은 사람이 아니라면 버튼을 보여줘야한다. -->
					<c:if test="${usrNum != clubVO.cbLeaderNum}">
						<button class="btn btn-info" data-oper='join' id="join">
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



					<!-- 지금 로그인된 유저의 정보와 개설자의 번호가 일치하면(=같은사람 이라면) modify 버튼을 보여준다.-->
					<c:if test="${usrNum eq clubVO.cbLeaderNum}">
						<button class="btn btn-default" data-oper='modify'>수정</button>
					</c:if>



					<button class="btn btn-info" data-oper='list'>목록</button>
				</div>
			</div>

		</div>
	</div>
	<!-- body end -->



	<!-- controller로 넘어가야하는 정보들 -->
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
		<input type='hidden' name='orderBy' value='<c:out value="${cri.orderBy}"/>'>

		<input type="hidden" name="userLatitude" value='<c:out value="${cri.userLatitude}"/>'>
		<input type="hidden" name="userLongitude" value='<c:out value="${cri.userLongitude}"/>'>

		<input type='hidden' name='joinState' value='<c:out value="${joinState}"/>'>
	</form>
</section>





<script>
	window.onscroll = function() {
		myFunction()
	};

	var right = document.getElementById("rightinfo");
	var sticky = rightinfo.offsetTop;

	function myFunction() {
		if (window.pageYOffset > sticky) {
			rightinfo.classList.add("sticky");
		} else {
			rightinfo.classList.remove("sticky");
		}
	}
</script>



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
			$("#tag-list").append(
					"<li class='tag-item'>" + arrayHash[i] + "</li>");
		}
	}

</script>

<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- services와 clusterer, drawing 라이브러리 불러오기 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e19ea28cff4b871b68b2fabda7855cab&libraries=services,clusterer,drawing"></script>

<script type="text/javascript" src="/resources/js/kakaoMap.js"></script>




<%@include file="../includes/footer.jsp"%>
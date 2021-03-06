<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!-- 작성자 : 김선우 -->
<%@include file="../includes/header.jsp"%>
<link rel="stylesheet" type="text/css"
	href="/resources/css/thunderInfo.css">
<link rel="stylesheet" type="text/css"
	href="/resources/css/kakaoMap.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">



<!--  번개 모임 상세페이지 -->
<section id="wrap">



	<div id="regularInfo">
		<div id="detail">
			<div id="leftinfo">
				<div>
					<p id="topInfo">#${clubVO.cbSubcat} #${clubVO.cbDistrict}</p>
				</div>
				<div>
					<p id="topcbName">${clubVO.cbName}</p>
					
					<!-- 하트버튼 -->
						<div id="sss">
						<c:choose>
							<c:when test="${likecheck eq '1'}">
							<!-- likecheck가1이면 빨간 하트-->								
								<img id="qqq" src="/resources/img/heart.gif" />																															
							</c:when>
							<c:otherwise>
								<!-- likecheck가0이면 빈하트-->
								<img id="qqq" src="/resources/img/heartCancle.gif" />																								
							</c:otherwise>
						</c:choose>
						</div>																				
        
      <script>
        var usrNum = ${usrNum};
        var cbNum = ${clubVO.cbNum};
         
         var qqq = document.getElementById("qqq");        
         qqq.onclick = function(){ changeHeart(); }    

        /* 좋아요 버튼 눌렀을떄 */
         function changeHeart(){ 
             $.ajax({
                    type : "POST",  
                    url : "/thunder/clickLike",       
                    dataType : "json",   
                    data : "usrNum="+usrNum+"&cbNum="+cbNum,
                    error : function(){
                        alert("통신 에러");
                    },
                    
                    success : function(jdata) {
                        if(jdata.resultCode == -1){
                           alert("좋아요 오류");
                        }
                        else{
                        	console.log(jdata.likecheck);
                            if(jdata.likecheck == 1){
                            	 $("#qqq").attr('src', '/resources/img/heart.gif');
                            }
                            else if (jdata.likecheck == 0){
                            	$("#qqq").attr('src', '/resources/img/heartCancle.gif');                         
                                
                            }
                        }
                    }
                });
         }
      </script>
					
				</div>
				<img src="${clubVO.cbFile}" class="thumbImg" />

				<div id=banner>
					<ul>
						<li><a href="javascript:void(0);">정보</a></li>
						<!--a태그의 페이지이동 기능 무효화 -->
						<li><a
							href="/thunder/chat?cbNum=<c:out value="${clubVO.cbNum}" />">채팅</a></li>
						<!--a태그의 페이지이동 기능 무효화 및 클릭시 경고창 -->
					</ul>
				</div>
				<!--  
				<div class="thunderTag">
					<ul id="tag-list"></ul>
				</div>-->
				
				<div id="pdetail">
					<div class="infole">
						<p>  </p>
					</div>
					<div class="inforig">
						<p class="clubb">
							<ul id="tag-list"></ul>
						</p>
					</div>
				</div>
				
				
				<div id="pdetail">
					<div class="infole">
						<p>✔️어떤 모임인가요?</p>
					</div>
					<div class="inforig">
						<p class="clubb">
							<c:out value="${clubVO.cbIntro}" />
						</p>
					</div>
				</div>

				<div id="pdetail">
					<div class="infole">
						<p>✔️대기중인 회원은?</p>
					</div>
					<div class="inforig">
						<p class="clubb">👪모임 멤버 ( ${clubVO.cbCurMbnum} /
							${clubVO.cbMbnum}명 )</p>

						<c:forEach items="${joinList}" var="joinList">

							<li>
								<p class="clubb">
									<c:out value="${joinList.usrName}" />
									<c:if test="${joinList.usrNum == clubVO.cbLeaderNum}">
							(모임장)
							</c:if>
								</p>
							</li>

						</c:forEach>

					</div>
				</div>


				<div id="pdetail">
					<div class="infole">
						<p>✔️언제 모이나요?</p>
					</div>
					<div class="inforig">
						<p class="clubb">
							<fmt:parseDate var="dateString"
								value="${clubVO.thunderDetailVO.cbDate}"
								pattern="yyyy-MM-dd'T'HH:mm" />
							<fmt:formatDate value="${dateString}"
								pattern="yyyy년  M월 d일  E'요일' a h시  m분에 시작합니다!!" />
						</p>
					</div>
				</div>
				
				<div id="pdetail">
					<div class="infole">
						<p>✔️신청은 언제까지?</p>
					</div>
					<div class="inforig">
						<p class="clubb">
							<fmt:parseDate var="dateString" value="${clubVO.thunderDetailVO.cbAppPeriod}" pattern="yyyy-MM-dd'T'HH:mm" />
							<fmt:formatDate value="${dateString}" pattern="M월 d일  E'요일' a h시  m분까지!!" />
						</p>
					</div>
				</div>


				<div id="pdetail">
					<div class="infole">
						<p>✔️장소는 어딘가요?</p>
					</div>
					<div class="inforig">
						<p class="clubb">${clubVO.thunderDetailVO.cbPlace}</p><br>
						<!-- 카카오 맵 -->
						<div class="map_wrap" style="height: 400px;margin-bottom: 20px;">
							<div id="map"></div>
							<div id="menu_wrap" class="bg_white" style="width: 210px;">
								<div class="option">
									<div>
										<form role="form" onsubmit="searchPlaces(); return false;">
											<p class="clubb">
												모임 장소:
													<input type="text"
													value='${clubVO.cbCity} ${clubVO.cbDistrict} ${clubVO.thunderDetailVO.cbPlace}'
													id="keyword" size="15">
											</p>
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
				</div>




				<button data-oper='list' class="btn btn-info" id="clubList">
					<p class="clubb" style="border-bottom: 1.5px solid #999;">더 많은 모임을 보려면?</p>
				</button>
			</div>
			<!-- END leftinfo -->





			<div id="rightinfo" class="rightinfo">
				<div class="contentup">
					<div class="contentl">
						<p>⚡️모임장은?</p>
					</div>
				</div>

				<div style="margin: 0 10px">
					<div class="contentmid">
						<img src="\resources\img\upload\2021\01\04\747421e8-169e-483d-b98b-9efa8db79813_zxczxc.jpg" style="width:120px; height:110px; border-radius:50px;">

						<p class="clubb">
							<c:out value="${userVO.usrName}" />
						</p>
						<p class="clubb">
							(
							<c:out value="${userVO.usrId}" />
							)
						</p>
						
						<div id="appDate">
							
							<p class="clubb">
								주요 활동 지역 : 종로구
							</p>
							
							<p class="clubb">
								만족도 : 
								<span class="fa fa-star checked"></span>
								<span class="fa fa-star checked"></span>
								<span class="fa fa-star checked"></span>
								<span class="fa fa-star checked"></span>
								<span class="fa fa-star unchecked"></span>
							</p>
							<p class="clubb">
								최근 모임 개설 : 14개
							</p>
							
						


						
		


						<div style="width: 323px;margin: 0 auto;">
						

						<!-- 로그인한유저와 모임장이 같은 사람이 아니라면 버튼을 보여줘야한다. -->
						<c:if test="${usrNum != clubVO.cbLeaderNum}">
							<button class="btn btn-info" data-oper='join' id="join">
								<!-- joinState - 모임추방, 모임만료, 모임탈퇴, 가입승인, Null (아직 데이터 넣기 전) -->
								<!-- 모임 마감 까지도 아니면, 모임 가입하기 보여주는 것으로 한다. 그러면 순서가 맞음 -->
								<c:choose>
									<c:when test="${joinState eq '가입승인'}">탈퇴</c:when>
									<c:when test="${joinState eq '모임추방'}">가입불가</c:when>
									<c:when test="${clubVO.cbCurMbnum == clubVO.cbMbnum}">정원초과</c:when>

									<c:when test="${joinState eq '모임탈퇴' || joinState == null}">가입</c:when>
								</c:choose>
							</button>
						</c:if>

						<!-- 지금 로그인된 유저의 정보와 개설자의 번호가 일치하면(=같은사람 이라면) modify 버튼을 보여준다.-->
						<c:if test="${usrNum eq clubVO.cbLeaderNum}">
							<button class="btn btn-default" data-oper='modify'>수정</button>
						</c:if>
						</div>
					
					</div>
				</div>
			</div>
			<!-- rightinfo END -->
		</div>
		<!-- END detail -->


	</div>
	<!-- END regularInfo -->











	<!-- controller로 넘어가야하는 정보들 -->
	<form id='operForm' action="/thunder/modify" method="get">
		<input type='hidden' id='cbNum' name='cbNum'
			value='<c:out value="${clubVO.cbNum}"/>'> <input
			type='hidden' name='pageNum' value='<c:out value="${cri.pageNum}"/>'>
		<input type='hidden' name='amount'
			value='<c:out value="${cri.amount}"/>'> <input type='hidden'
			name='category' value='<c:out value="${cri.category}"/>'> <input
			type='hidden' name='subclass'
			value='<c:out value="${cri.subclass}"/>'> <input
			type='hidden' name='city' value='<c:out value="${cri.city}"/>'>
		<input type='hidden' name='district'
			value='<c:out value="${cri.district}"/>'> <input
			type='hidden' name='searchBy'
			value='<c:out value="${cri.searchBy}"/>'> <input
			type='hidden' name='keyword' value='<c:out value="${cri.keyword}"/>'>
		<input type='hidden' name='orderBy'
			value='<c:out value="${cri.orderBy}"/>'> <input type="hidden"
			name="userLatitude" value='<c:out value="${cri.userLatitude}"/>'>
		<input type="hidden" name="userLongitude"
			value='<c:out value="${cri.userLongitude}"/>'> <input
			type='hidden' name='joinState' value='<c:out value="${joinState}"/>'>
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
	// 탈퇴/가입불가/정원초과/가입
	console.log($("#join").text().trim());
	if ($("#join").text().trim() == '탈퇴') {
		//모임에 참석중일 때
		document.getElementById("plusDiv").style.display = "block";
		document.getElementById("pulsButton").value = "🐵";
	} else if ($("#join").text().trim() == '가입') {
		//모임에 참석 중이 아닐 때
		document.getElementById("plusDiv").style.display = "none";
		document.getElementById("plus").style.display = 'none';

	} else if ($("#join").text().trim() == '가입불가'
			|| $("#join").text().trim() == '정원 초과') {
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
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- services와 clusterer, drawing 라이브러리 불러오기 -->
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e19ea28cff4b871b68b2fabda7855cab&libraries=services,clusterer,drawing"></script>

<script type="text/javascript" src="/resources/js/kakaoMap.js"></script>




<%@include file="../includes/footer.jsp"%>
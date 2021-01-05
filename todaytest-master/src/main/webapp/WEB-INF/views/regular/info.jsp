<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>

<%@include file="../includes/header.jsp"%>

<link rel="stylesheet" href="../resources/css/clubInfoStyle.css">
<style>
/* 해시태그  */
ul li.tag-item {
	padding: 4px 8px;
	background-color: #ffaf31;
	color: white;
	display: inline-block;
	font-size: 14px;
	letter-spacing: -.5px;
	margin-bottom: 10px;
	color: white;
	margin: 0 5px;
}

.tag-item:hover {
	background-color: #262626;
	color: #fff;
}

/* 찜하기 구현 */
#sss>img {
	width: 100%;
	height: 100%;
	position: relative;
	top: -4px;
	cursor: pointer;
	margin: 0;
}

#sss {
	width: 42px;
	overflow: hidden;
	height: 42px;
	display: inline-block;
/* 	margin-left: 149px; */
	position: relative;
	top: 20px;
}

ul#tag-list {
	margin-bottom: 15px;
}
</style>






<div id="regularInfo">
	<div id="detail">
		<div id="leftinfo">
			<div>
				<p id="topInfo">#${club.cbSubcat} #${club.cbDistrict}</p>
			</div>
			<div>
				<p id="topcbName">${club.cbIntro},${club.cbName}</p>
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
        var cbNum = ${club.cbNum};
         
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
			<img src="${club.cbFile}" alt="">

			<div id=banner>
				<ul>
					<li><a href="javascript:void(0);">정보</a></li>
					<!--a태그의 페이지이동 기능 무효화 -->
					<li><a
						href="/regular/board?cbNum=<c:out value="${club.cbNum}" />">게시판</a></li>
					<!--cbNum(모임번호)을 가지고 게시판페이지이동-->
					<li><a
						href="/regular/chat?cbNum=<c:out value="${club.cbNum}" />">채팅</a></li>
					<!--a태그의 페이지이동 기능 무효화 및 클릭시 경고창 -->
				</ul>
			</div>
                        
            <div id="pdetail">
                <div class="infole"> <p>☀️어떤 모임인가요?</p></div>
                <div class="inforig">
                	<ul id="tag-list"></ul>
                	
                	               
                    <p class="clubb"><pre style="font-family: 'BMHANNAAir'; line-height: 30px;">${club.cbDetailContent}</pre>
                </div>
            </div>

			<div id="pdetail">
				<div class="infole">
					<p>☀️가입된 회원은?</p>
				</div>
				<div class="inforig">
					<p>👪모임 멤버 ( ${club.cbCurMbNum} / ${club.cbMbNum}명 )</p>
					<c:forEach items="${joinList}" var="joinList">
						<p class="clubb">
						<li><c:out value="${joinList.usrName}" /> <c:if
								test="${joinList.usrNum == club.cbLeaderNum}">
						(모임장)
						</c:if></li>
						</p>
					</c:forEach>
					<!-- 로그인 유저의 정보와 개설자의 번호가 일치하지 않으면 버튼을 보여줘야한다. -->
					<c:if test="${usrNum != club.cbLeaderNum}">
						<button class="btn btn-info" data-oper='join' id="join">
							<!-- joinState - 모임추방, 모임만료, 모임탈퇴, 가입승인, Null (아직 데이터 넣기 전) -->
							<!-- 모임 마감 까지도 아니면, 모임 가입하기 보여주는 것으로 한다. 그러면 순서가 맞음 -->
							<c:choose>
								<c:when test="${joinState eq '가입승인'}">모임 나가기</c:when>
								<c:when test="${joinState eq '모임추방' || joinState eq '승인거부' }">모임 가입불가</c:when>
								<c:when test="${joinState eq '승인대기'}">승인 대기 중</c:when>

								<c:when test="${club.cbMbNum == club.cbCurMbNum}">모임 정원 초과</c:when>
								<c:when test="${joinState eq '모임탈퇴' || joinState == null}">모임 가입하기</c:when>
							</c:choose>
						</button>
					</c:if>
				</div>
			</div>
			<button data-oper='list' class="btn btn-info" id="clubList">더
				많은 모임을 보려면?</button>

			<form id='operForm' action="/regular/update" method="get">
				<input type="hidden" id="cbNum" name="cbNum"
					value="<c:out value="${cbNum}" />" />
			</form>
		</div>
		<!-- END leftinfo -->

		<div id="rightinfo" class="rightinfo">
			<div class="contentup">
				<div class="contentl">
					<p>만남 일정</p>
				</div>
				
				<div class="contentr">
					<!-- 로그인 유저가 모임장이면 만남 추가 버튼을 보여준다 -->
					<c:if test="${usrNum == club.cbLeaderNum}">
						<button class="btn-meeting" data-oper='addMeeting'>만남 추가</button>
					</c:if>
				</div>
			</div>
			<div style="margin: 0 10px">
				<div class="contentmid">

					<form action="#" method="get" id="meeting-form">
						<%-- <c:choose>
                        <c:when test="${ClubMemberVO.usrNum == clubVO.cbLeaderNum}">모임장</c:when>
                        <c:otherwise>모임원</c:otherwise>
               </c:choose> --%>
						<c:forEach items="${meetingList}" var="MeetingVO">
							<p id="meetingName">🔸 ${MeetingVO.mtName}
								(${MeetingVO.mtCurMbNum}/${MeetingVO.mtMbNum}명)</p>
							<button class="btn-meeting" data-oper='joinMeeting'
								value="${MeetingVO.mtNum}">
								<c:choose>
									<c:when test="${MeetingVO.usrMtState eq '참석중'}">참석 취소</c:when>
									<c:when
										test="${MeetingVO.usrMtState eq '미참석' || MeetingVO.usrMtState==null || MeetingVO.usrMtState eq '모임탈퇴'}">참석</c:when>
								</c:choose>
							</button>

							<fmt:parseDate var="dateString" value="${MeetingVO.mtStartDate}"
								pattern="yyyy-MM-dd'T'HH:mm" />
							<p>
								🔸
								<fmt:formatDate value="${dateString}"
									pattern="M월 d일  E'요일' a h시  m분 " />
							</p>

							<p>🔸 ${MeetingVO.mtAddress} ${MeetingVO.mtPlace}</p>

							<p>🔸 ${MeetingVO.mtSupplies}</p>

							<hr width="100%" style="margin: 10px">

						</c:forEach>
						<input type="hidden" name="cbNum"
							value="<c:out value="${club.cbNum}" />" /> <input type="hidden"
							name="cbName" value="${club.cbName }" />
					</form>
				</div>
			</div>
		</div>
		<!-- rightinfo END -->
	</div>
	<!-- END detail -->

	<!-- 가입하기 모달창  -->
	<div id="id01" class="modal">
		<span onclick="document.getElementById('id01').style.display='none'"
			class="close" title="Close Modal">×</span>

		<form class="modal-content" action="/regular/clubjoin" method="post">

			<div class="container">
				<h4>가입 신청서</h4>
				<input type="hidden" name="cbNum"
					value="<c:out value="${club.cbNum}" />" /> <input type="hidden"
					name="usrNum" value="<c:out value="${usrNum}" />" /> <input
					type="hidden" name="cbType" value="정기모임" /> <input type="hidden"
					name="cbName" value="${club.cbName }" /> <input type="hidden"
					name="cbJoinStateResult" value="승인대기" />
			</div>
			<div class="container1">
				<label><b>가입일자</b></label> <input type="text" name="cbAppDate"
					value="<c:out value="${toDate}"/>" readonly="readonly">
			</div>
			<div class="container1">
				<label><b>회원이름</b></label> <input type="text" name="usrName"
					value="<c:out value="${usrName}"/>" readonly="readonly">
			</div>
			<div class="container2">
				<label><b>가입인사</b></label>
				<textarea rows="5" cols="50" style="resize: none" name="cbMemIntro"></textarea>
			</div>
			<div class="clearfix">
				<button type="submit"
					onclick="document.getElementById('id01').style.display='none'"
					class="submitbtn">제출하기</button>
			</div>
		</form>
	</div>
	<!-- 가입하기 모달창  -->
</div>
<!-- END regularInfo -->


<script type="text/javascript">
	var modal = document.getElementById('id01');
	
	var replyer = false;
	<sec:authorize access="isAuthenticated()">
		/* replyer = '<sec:authentication property="principal.username"/>'; */
		replyer = true;
	</sec:authorize>
	
	/* window.onclick = function(event) {
		if(!replyer){
				alert("로그인");
				location.href="/regular/clubjoin?cbNum=${club.cbNum}";
				return ;
			if(event.target == modal) {
				modal.style.display = "block";
			}
		}
	} */
	
	const btnText = $("#join").text().trim();
	console.log(btnText);
	if (btnText=='모임 가입불가'||btnText=='승인 대기 중'||btnText=='모임 정원 초과') {
		document.getElementById("join").disabled = 'disabled';
	} 
	
	$("button[data-oper='join']").on(
			"click",
			function(e) {
				e.preventDefault();
				
				if ($("#join").text().trim() == '모임 나가기') {
					$(".modal-content").submit();
				}
				
				else if ($("#join").text().trim() == '모임 가입하기') {
					join();
				}																															
			});
	
	function join() {
		if(!replyer){
			location.href="/regular/clubjoin?cbNum=${club.cbNum}";
			return;
		} else {
			
			modal.style.display = "block";
		}
	}

	
	// Meeting에 관련된 것들 중에서 -> 참석하기, 개설하기, 수정하기 중 버튼을 누른다면
	let formObj = $("#meeting-form");
		
	$('.btn-meeting').on(
			"click",
			function(e) {
				e.preventDefault();
				let operation = $(this).data("oper");
				console.log(operation);
				
				//만남 참석하기 버튼 눌렀을 때
				if (operation === 'joinMeeting') {
					if ($("button[data-oper='joinMeeting']").text().trim() == '만남참석취소') {
// 						alert('만남 참석취소합니다');
					}
					else if ($("button[data-oper='joinMeeting']").text().trim() == '만남참석') {
// 						alert('만남 참석합니다');
					}
	
					formObj.attr("action","/meeting/join").attr("method", "post");
					formObj.append("<input type='hidden' name='mtNum' value='" + $(this).val() + "'>");
				} 
				// 만남 추가하기 버튼 눌렀을 때
				else if (operation === 'addMeeting') {
// 					alert('만남 추가합니다');
					formObj.attr("action","/meeting/add");
				}
				// 만남 수정하기 버튼 눌렀을 때
				else if (operation === 'modifyMeeting') {
// 					alert('만남 수정합니다');
					formObj.attr("action", "/meeting/modify");
					formObj.append("<input type='hidden' name='mtNum' value='" + $(this).val() + "'>");
				}
				formObj.submit();
			});
	
	
	
	// 사용자의 참석상태(joinState)가 '가입승인'이라면 버튼을 활성화 해주고, 그게 아니라면 버튼을 비활성화한다.
	if ('${joinState}' !== '가입승인') {
		$("button[data-oper='joinMeeting']").attr("disabled", "disabled");
	}
	
	
	
	/* 해시태그 구현관련!! (선우)*/
	let stringHash = '${club.cbHashtag}';
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

<script type="text/javascript">

	$(document).ready(function() {
		var operForm = $("#operForm");

		$("button[data-oper='modify']").on("click", function(e) {
			operForm.attr("action", '/regular/update').submit();
		}); 

		$("button[data-oper='list']").on("click",function(e) {
			operForm.find("#cbNum").remove();
			operForm.attr("action", '/regular/list')
			operForm.submit();
		});
	});
</script>

<script>
window.onscroll = function() {myFunction()};

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
<%@include file="../includes/footer.jsp"%>
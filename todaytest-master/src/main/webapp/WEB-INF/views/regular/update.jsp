<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp"%>

<style>
/* 파일 업로드 블로그 style */
.inputArea {
	margin: 10px 0px;
}

select {
	with: 100px;
}

label {
	display: inline-block;
	width: 70px;
	padding: 5px;
}

label[for='gdsDes'] {
	display: block;
}

input {
	width: 150px;
}

textarea#gdsDes {
	width: 400px;
	height: 180px;
}

.select_img img {
	margin: 20px 0px;
}

/* 해시태그 구현 */
* {
	margin: 0;
	padding: 0;
	list-style: none;
}

ul {
	padding: 16px 0;
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

.del-btn {
	font-size: 12px;
	font-weight: bold;
	cursor: pointer;
	margin-left: 8px;
}

.thumbImg {
	width: 200px;
	height: auto;
}
</style>
<link rel="stylesheet" href="../resources/css/clubAddStyle.css">
<h1 style="text-align: center">정기모임 수정</h1>
<h3 style="text-align: center">기본정보(필수)</h3>

<form role="form" id="formclubUpdate" action="/regular/update" method="post" enctype="multipart/form-data">

	<input type="hidden" id="cbNum" name="cbNum" value='<c:out value="${cbNum}" />'/>
	
 	<label for="cbCategory">카테고리/분야</label>
	<select id="cbCategory" name="cbCategory">
		<option value="아웃도어/여행" <c:if test="${club.cbCategory eq '아웃도어/여행'}">selected</c:if>>아웃도어/여행</option>
		<option value="문화/공연/축제" <c:if test="${club.cbCategory eq '문화/공연/축제'}">selected</c:if>>문화/공연/축제</option>
		<option value="운동/스포츠" <c:if test="${club.cbCategory eq '운동/스포츠'}">selected</c:if>>운동/스포츠</option>
		<option value="음악/악기" <c:if test="${club.cbCategory eq '음악/악기'}">selected</c:if>>음악/악기</option>
		<option value="외국/언어" <c:if test="${club.cbCategory eq '외국/언어'}">selected</c:if>>외국/언어</option>
		<option value="게임/오락" <c:if test="${club.cbCategory eq '게임/오락'}">selected</c:if>>게임/오락</option>
		<option value="기타" <c:if test="${club.cbCategory eq '기타'}">selected</c:if>>기타</option>
	</select> 
	<label for="cbSubcat">모임</label> 
	<select id="cbSubcat" name="cbSubcat"></select><br> 
	<label for="cbName">모임명</label> 
	<input type="text" id="club" name="cbName" value='<c:out value="${club.cbName}"/>'><br> 
	<label for="cbCity">지역 </label> 
	<select name="cbCity" id="cbCity">
		<option value="서울특별시" <c:if test="${club.cbCity eq '서울특별시'}">selected</c:if>>서울특별시</option>
		<option value="경기도" <c:if test="${club.cbCity eq '경기도'}">selected</c:if>>경기도</option>
	</select> 
	<select name="cbDistrict" id="cbDistrict"></select> 
	<label for="cbMbNum">정원</label> 
	<input type="number" id="num" name="cbMbNum" min="1" max="200" value='<c:out value="${club.cbMbNum}"/>'><br> 
	<input type="hidden" name="cbMakeDate">
	<!--개설일자 : sysdate로 기본설정 -->
	<label for="cbHashtag">해시태그</label> 
	<input type="text" id="hash" name="cbHashtag" value='<c:out value="${club.cbHashtag}"/>'><br> 
	<label for="cbIntro">한줄소개</label>
	<input type="text" id="info" name="cbIntro" value='<c:out value="${club.cbIntro}"/>'><br>
	<label for="cbDetailContent">모임 상세내용(필수)</label><br>
	<textarea name="cbDetailContent" rows="10" cols="100" style="resize: none"><c:out value="${club.cbDetailContent}"/></textarea><br> 
	
	
	<div class="inputArea" style="float: left; margin-right: 50px">

			<div class="select_img" style="margin: 2px 0px">
				<img class="thumbImg" src="${club.cbThumbImg}" style="margin: 0px;" /> <br>
				<!-- <label for="gdsImg" >이미지 선택</label> -->
				<input type="file" id="gdsImg" name="file" style="width: 200px;" />
			</div>
<!-- 사진 첨부 안했을 시 사용해야함 -->
		<input type='hidden' name='cbFile' value='<c:out value="${club.cbFile}"/>'>
		<input type='hidden' name='cbThumbImg' value='<c:out value="${club.cbThumbImg}"/>'>


			<script>
				/* 스크립트는 파일이 등록되면 현재화면에서 어떤 이미지인지 볼 수 있도록 해주는 역할 */
				$("#gdsImg").change(
						function() {
							if (this.files && this.files[0]) {
								var reader = new FileReader;
								reader.onload = function(data) {
									$(".select_img img").attr("src",
											data.target.result).width(200)
											.height(144);
								}
								reader.readAsDataURL(this.files[0]);
							}
						});
			</script>
			<!-- 현재 프로젝트의 실제 경로를 표시합니다. 스프링 파일이 저장되는 워크스페이스와 다르므로, 파일을 저장할 때 실제 경로를 알아야합니다. -->
			<%-- <%=request.getRealPath("/")%> --%>
		</div>
	
	
	
	<button type="submit" data-oper='modify' class="btn btn-default">모임 수정하기</button>
	<button type="submit" data-oper='remove' class="btn btn-danger">모임 폐쇄하기</button>
	<button type="submit" data-oper='list' class="btn btn-info">List</button>
	
</form>

<script type="text/javascript">

   //카테고리/분야 선택, 지역 선택 
   $(function() {
      //초기 세팅값
      selectHobby('${club.cbCategory}');
      selectCity('${club.cbCity}');
      
      $('#cbCity').change(function(e) { //cbCity변경 시, e(event)발생 
         selectCity(e.target.value); //e.target.value=경기도 / 이벤트의 값으로 selectCity를 호출한다.
      });
      $('#cbCategory').change(function(e) { //cbCategory 변경 시, e(event)발생
         selectHobby(e.target.value); //e.target.value=문화/공연/축제 (이벤트가 발생한 값=cbCategory의 변경된 이벤트 값)이벤트의 값으로 selectHobboy를 호출한다. 
      });
   });
   
   let hobbyCategory = {
      "아웃도어/여행" : ["등산","산책/트래킹","캠핑/백패킹","낚시","기타"],
      "문화/공연/축제" : ["뮤지컬/오페라", "공연/연극", "전시회", "파티/페스티벌", "기타"],
      "운동/스포츠" : ["자전거", "배드민턴", "볼링", "헬스/크로스핏", "탁구", "당구/포켓볼", "축구/풋살", "농구", "야구", "스케이트/인라인", "기타"],
      "음악/악기" : ["노래/보컬", "기타/베이스", "피아노", "랩/힙합/DJ", "클래식", "기타"],
      "외국/언어" : ["영어", "일본어", "중국어", "프랑스어", "스페인어", "러시아어", "기타"],
      "게임/오락" : ["다트", "보드게임", "온라인게임", "마술", "바둑", "기타"],
      "기타" : ["기타"]
   }
   
   function selectHobby(targetVal) { //e.target.value를 targetVal로 받아온다. 
      Object.keys(hobbyCategory).filter(item1 => { //object.keys: hobbycategory array에서 key만 리스트로 뽑아오기 //filter: 가지고있는 값을 반복
      // Object.keys(hobbyCategory).filter(function(item1) {
         if (targetVal === item1) { //선택한 값과 hobbycategory에 있는 값이 일치하면, 
            $("#cbSubcat").empty(); //기존모임 목록 초기화 
            //console.log(item1, hobbyCategory[item1]); //리스트명[key] = value 
            hobbyCategory[item1].forEach(item2 => { //item2(value)에 있는 option을 보여준다.(처음부터 끝까지)
               let option = $("<option value=" + item2 + " "+ ('${club.cbSubcat}' === item2 ? 'selected' : '') +">" + item2 + "</option>"); 
               $("#cbSubcat").append(option); //아래로 붙여준다. 
               //안녕//
            })
         } 
      })
   }
   
   let city = {
      "서울특별시" : [ "강남구", "강동구", "강북구", "강서구", "관악구", "광진구", "구로구",
         "금천구", "노원구", "도봉구", "동대문구", "동작구", "마포구", "서대문구", "서초구",
         "성동구", "성북구", "송파구", "양천구", "영등포구", "용산구", "은평구", "종로구",
         "중구", "중랑구" ],
      "경기도" : [ "고양시", "과천시", "광명시", "광주시", "구리시", "군포시", "김포시",
         "남양주시", "동두천시", "부천시", "성남시", "수원시", "시흥시", "안산시", "안성시",
         "안양시", "양주시", "여주시", "오산시", "용인시", "의왕시", "의정부시", "이천시",
         "파주시", "평택시", "포천시", "하남시", "화성시", "가평군", "양평군", "연천군" ]
   }
      
   function selectCity(targetValCity) {
      Object.keys(city).filter(item1 => { //city array에 있는 key만 반복한다. 
         if (targetValCity === item1) { //선택한 값과 city에 있는 값이 일치하면, 
            $("#cbDistrict").empty(); //세부지역 목록 초기화
            city[item1].forEach(item2 => { //item2(value)에 있는 option을 보여준다.(처음부터 끝까지)
               let option = $("<option value=" + item2 + " "+ ('${club.cbDistrict}' === item2 ? 'selected' : '') +">" + item2 + "</option>");
               $("#cbDistrict").append(option); //아래로 붙여준다.
            })
         }
      })
   }
</script>

<script type="text/javascript">
	$(document).ready(function() {
		
		var formObj = $("#formclubUpdate");
		$('button').on("click", function(e) {
			e.preventDefault();
			var operation = $(this).data("oper");
			
			console.log(operation);
			
			if (operation === 'remove') {
				
				formObj.attr("action", "/regular/delete");
				
			} else if (operation === 'list') {
				
				formObj.attr("action", "/regular/list").attr("method", "get");
				formObj.empty();
			}
			formObj.submit();
		});
	});
</script>
<%@include file="../includes/footer.jsp"%>
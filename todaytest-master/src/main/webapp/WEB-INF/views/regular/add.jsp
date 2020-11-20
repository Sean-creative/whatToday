<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp" %>
<link rel="stylesheet" href="../resources/css/clubAddStyle.css">
	
<h3 style="text-align:center"> 기본정보(필수)</h3>
<form id="register" name="register" action="/regular/add" method="post" onsubmit="return inputCheck()">

    <input type="hidden" id="cbLeaderNum" name="cbLeaderNum" value ="${usrNum}"/>
    <input type="hidden" id="cbType" name="cbType" value ="정기모임"/>
    <input type="hidden" id="cbLeaderName" name="cbLeaderName" value ="${usrName}"/>
    <!--카테고리/분야별 모임나오는걸로 나중에 바꾸기  -->
	<label for="cbCategory">카테고리/분야</label>
		<select id="cbCategory" name="cbCategory">
			<option>아웃도어/여행</option>
			<option>문화/공연/축제</option>
			<option>운동/스포츠</option>
			<option>음악/악기</option>
			<option>외국/언어</option>
			<option>게임/오락</option>
			<option>기타</option>
		</select>
	<label for="cbSubcat">모임</label>
		<select id="subcate" name="cbSubcat">
			<option>등산</option>
			<option>산책/트랙킹</option>
			<option>캠핑/백패킹</option>
			<option>낚시</option>
			<option>뮤지컬/오페라</option>
			<option>공연/연극</option>
			<option>자전거</option>
			<option>배드민턴</option>
			<option>볼링</option>
			<option>농구</option>
			<option>랩/힙합/DJ</option>
			<option>마술</option>
			<option>영어</option>
			<option>노래/보컬</option>
			<option>기타</option>
		</select><br>
	<label for="cbName">모임명</label>
		<input type="text" id="club" name="cbName"><br>
	<div class="input-container">
			<label>지역 </label> <select class="input-field" name="cbCity"
				id="city">
				<option value="시/도">시/도 선택</option>
				<option value="서울특별시">서울특별시</option>
				<option value="경기도">경기도</option>
			</select> <select class="input-field" name="cbDistrict" id="district">
				<option value="군/구">군/구선택</option>
			</select>
		</div>
	<label for="cbMbNum">정원</label>
		<input type="number" id="num" name="cbMbNum"><br>
	<input type="hidden" name="cbMakeDate"> <!--개설일자 : sysdate로 기본설정 -->
	<label for="cbHashtag">해시태그</label>
		<input type="text" id="hash" name="cbHashtag" value="#"><br>
	<label for="cbIntro">한줄소개</label>
		<input type="text" id="info" name="cbIntro" onfocus="this.value=''; return true" value="30자이내로만 작성하세요"><br>
	<label for="cbDetailContent">모임 상세내용(필수)</label><br>
		<textarea name="cbDetailContent" rows="10" cols="100"></textarea><br>
	<input type="file" name="cbFile"> 
		<input type="submit" value="개설하기">
</form>

<script>
	function inputCheck(){
		
		var club = document.register.cbName;
		var number = document.register.cbMbNum;
		var date = document.register.cbMakeDate;
		var info = document.register.cbIntro;
		var infodetail = document.register.cbDetailContent;
		
		if(!club.value || club.value.length>30) {		
			alert("모임명을 입력해주세요.");
			return false;
		}
		if(club.search(/\s/) != -1) {
			alert("유효하지 않습니다.")
			return false;
		}
		if(!number.value || number.value<0 || number.value>201) {
			alert("모임정원을 입력해주세요.(최대정원:200명)");
			return false;
		}
		if(!info.value || info.value.length>30) {
			alert("한줄소개를 입력해주세요.");
			return false;
		}
		if(!infodetail.value || infodetail.value.length>30) {
			alert("30자 이내로 상세내용을 입력해주세요.");
			return false;
		}
	}

</script>
<script type="text/javascript">
		$(function() {
			$('#city').change(function() {
				region(this, $("#district"));
			});
		});

		function region(o, d) {
			var city = [ "서울특별시", "경기도" ];

			var seoul = [ "강남구", "강동구", "강북구", "강서구", "관악구", "광진구", "구로구",
					"금천구", "노원구", "도봉구", "동대문구", "동작구", "마포구", "서대문구", "서초구",
					"성동구", "성북구", "송파구", "양천구", "영등포구", "용산구", "은평구", "종로구",
					"중구", "중랑구" ];

			var gyeonggi = [ "고양시", "과천시", "광명시", "광주시", "구리시", "군포시", "김포시",
					"남양주시", "동두천시", "부천시", "성남시", "수원시", "시흥시", "안산시", "안성시",
					"안양시", "양주시", "여주시", "오산시", "용인시", "의왕시", "의정부시", "이천시",
					"파주시", "평택시", "포천시", "하남시", "화성시", "가평군", "양평군", "연천군" ];
			var district;
			// change(function(){$( ':selected', o).val() => this }
			if ($(':selected', o).val() == "서울특별시") {
				district = seoul;
			} else if ($(':selected', o).val() == "경기도") {
				district = gyeonggi;
			}

			d.empty();

			for (var i = 0; i < district.length; i++) {
				var option = $("<option value=" + district[i] +">"
						+ district[i] + "</option>");
				d.append(option);
			}
		}
</script>

<%@include file="../includes/footer.jsp" %>
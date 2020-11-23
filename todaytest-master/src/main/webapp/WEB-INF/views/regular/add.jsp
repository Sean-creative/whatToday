<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp"%>
<link rel="stylesheet" href="../resources/css/clubAddStyle.css">

<h3 style="text-align: center">기본정보(필수)</h3>

	<form id="register" name="register" action="/regular/add" method="post" onsubmit="return inputCheck();">

		<input type="hidden" id="cbLeaderNum" name="cbLeaderNum" value="${usrNum}" /> 
		<input type="hidden" id="cbType" name="cbType" value="정기모임" /> 
		<input type="hidden" id="cbLeaderName" name="cbLeaderName" value="${usrName}" />
		
		<label for="cbCategory">카테고리/분야</label> 
			<select id="cbCategory" name="cbCategory">
				<option value="아웃도어/여행">아웃도어/여행</option>
				<option value="문화/공연/축제">문화/공연/축제</option>
				<option value="운동/스포츠">운동/스포츠</option>
				<option value="음악/악기">음악/악기</option>
				<option value="외국/언어">외국/언어</option>
				<option value="게임/오락">게임/오락</option>
				<option value="기타">기타</option>
			</select> 
		<label for="cbSubcat">모임</label> 
			<select id="cbSubcat" name="cbSubcat"></select><br> 
		<label for="cbName">모임명</label> 
			<input type="text" id="club" name="cbName"><br> 
		<label for="cbCity">지역 </label> 
			<select name="cbCity" id="cbCity">
				<option value="서울특별시">서울특별시</option>
				<option value="경기도">경기도</option>
			</select> 
			<select name="cbDistrict" id="cbDistrict"></select> 
		<label for="cbMbNum">정원</label> 
			<input type="number" id="num" name="cbMbNum" min="1" max="200"><br> 
		<input type="hidden" name="cbMakeDate">
		<!--개설일자 : sysdate로 기본설정 -->
		<label for="cbHashtag">해시태그</label> 
			<input type="text" id="hash" name="cbHashtag" value="#"><br> 
		<label for="cbIntro">한줄소개</label>
			<input type="text" id="info" name="cbIntro" placeholder="30자이내로 작성하세요"><br>
		<label for="cbDetailContent">모임 상세내용(필수)</label><br>
		<textarea name="cbDetailContent" rows="10" cols="100"
			placeholder="30자이내로 작성하세요"></textarea><br> 
		<input type="file" name="cbFile"> 
		<input type="submit" value="개설하기">
	</form>

<script type="text/javascript">

	//유효성 검사 (빈문자열 체크, 글자 제한(30자이내로), 공백 제한 등)
	function inputCheck(){
		
		let club = document.register.cbName;
		let number = document.register.cbMbNum;
		let date = document.register.cbMakeDate;
		let info = document.register.cbIntro;
		let infodetail = document.register.cbDetailContent;
		
		//모임명의 앞뒤 공백 체크 
		let inputValue = club.value.replace(/^(\s|\.)*|(\s|\.)*$/g, ""); //replace:공백을 ""(제거)해준다.
		
		//모임명 빈문자열 체크 
		if(inputValue.length <= 0) {		
			alert("모임명을 입력해주세요.");
			return false;
		}
		//모임명 글자수 제한  
		if(inputValue.length > 30) {		
			alert("30자 이내로 모임명을 입력해주세요.");
			return false;
		}
		//모임정원 빈문자열체크,정원 제한(1~200명)
		if(!number.value || (number.value <= 0) || (number.value > 201)) {
			alert("모임정원을 입력해주세요.(최대정원:200명)");
			return false;
		}
		//한줄소개 빈문자열 체크, 글자수 제한 
		if(!info.value || info.value.length > 30) {
			alert("한줄소개를 입력해주세요.");
			return false;
		}
		//상세내용 빈문자열 체크, 글자수 제한 
		if(!infodetail.value || infodetail.value.length > 30) {
			alert("30자 이내로 상세내용을 입력해주세요.");
			return false;
		}
	}

		//카테고리/분야 선택, 지역 선택 
		$(function() {
			
			//초기 세팅값
 			selectHobby("아웃도어/여행");
			selectCity("서울특별시");
			
			$('#cbCity').change(function(e) { //cbCity변경 시, e(event)발생 
				
				selectCity(e.target.value); //e.target.value = 경기도
				
		});
			$('#cbCategory').change(function(e) { //cbCategory 변경 시, e(event)발생
				selectHobby(e.target.value); //e.target.value = 문화/공연/축제
				
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
		
		function selectHobby(targetVal) {
			
			Object.keys(hobbyCategory).filter(item1 => { //hobbycategory에 있는 name 순으로 반복 
				if (targetVal === item1) { //선택한 값과 hobbycategory에 있는 값이 일치하면, 
					$("#cbSubcat").empty(); //기존모임 목록 초기화 
					hobbyCategory[item1].forEach(item2 => { //item2에 있는 option을 보여준다. 
						let option = $("<option value=" + item2 + ">" + item2 + "</option>");
						$("#cbSubcat").append(option);
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
			
				Object.keys(city).filter(item1 => { //city에 있는 name 순으로 반복 
					if (targetValCity === item1) { //선택한 값과 city에 있는 값이 일치하면, 
						$("#cbDistrict").empty(); //세부지역 목록 초기화
						city[item1].forEach(item2 => { //item2에 있는 option을 보여준다.
							let option = $("<option value=" + item2 + ">" + item2 + "</option>");
							$("#cbDistrict").append(option);
						})
					}
				})
			}

</script>

<%@include file="../includes/footer.jsp"%>
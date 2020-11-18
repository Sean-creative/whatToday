<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../includes/header.jsp"%>
<!-- 작성자: 김지영 -->
<!DOCTYPE html>
<html>
<head>

<link rel="stylesheet" href="/resources/css/registerStyle.css">
</head>
<body>
	<form name ="register" method="post" action="/login/registerAction" onsubmit="return inputCheck()"
		style="max-width: 500px; margin: auto" >
		<h2>Register Form</h2>
		<div class="input-container">
			<label>이메일(아이디) </label>
			<!--type="email" 나중에 바꾸기  -->
			<input class="input-field" type="email" placeholder="이메일(아이디)를 입력해주세요"
				id="id" name="usrId">
			<button id="idDuplicateCheck" type="button" onclick="check();">중복체크</button>
		</div>

		<div class="input-container">
			<label>비밀번호 </label> <input class="input-field" type="password"
				placeholder="영어+특수문자+숫자를 섞어서 (8~16)자리" name="usrPwd">
		</div>

		<div class="input-container">
			<label>비밀번호 확인 </label> <input class="input-field" type="password"
				placeholder="비밀번호를 다시 입력해주세요" name="usrPwdRe">
		</div>

		<div class="input-container">
			<label>이름 </label> <input class="input-field" type="text"
				placeholder="이름을 입력해주세요" name="usrName">
		</div>

		<div class="input-container">
			<label>휴대전화 번호 </label> <input class="input-field" type="text"
				placeholder="01012345678" name="usrPhone">
		</div>

		<div class="input-container">
			<label>성별 </label> <input type="radio" id="male" name="usrGender"
				value="m"> <label for="male">남자</label> <input type="radio"
				id="female" name="usrGender" value="f"> <label for="female">여자</label><br>
		</div>
		
 		<!--text -> Date(DB타입)으로 변환-->
		<div class="input-container">
			<label>생년월일 </label> <input class="input-field" type="date"
				placeholder="Birthday" name="usrBirth" value='<fmt:formatDate pattern = "yyyy/MM/dd" value="${usrBirth}"/>'>
		</div>
		

		<div class="input-container">
			<label>지역1 </label> <select class="input-field" name="usrCity1"
				id="city1">
				<option value="시/도">시/도 선택</option>
				<option value="서울특별시">서울특별시</option>
				<option value="경기도">경기도</option>
			</select> <select class="input-field" name="usrDistrict1" id="district1">
				<option value="군/구">군/구선택</option>
			</select>
		</div>

		<div class="input-container">
			<label>지역2 </label> <select class="input-field" name="usrCity2"
				id="city2">
				<option value="시/도">시/도 선택</option>
				<option value="서울특별시">서울특별시</option>
				<option value="경기도">경기도</option>
			</select> <select class="input-field" name="usrDistrict2" id="district2">
				<option value="군/구">군/구선택</option>
			</select>
		</div>
		<div class="input-container">
			<label>카테고리/분야 </label> <select class="input-field"
				name="usrCategory1" id="category1">
				<option value="관심분야">관심분야 선택1</option>
			</select>
		</div>

		<div class="input-container">
			<label>카테고리/분야 </label> <select class="input-field"
				name="usrCategory2" id="category2">
				<option value="관심분야">관심분야 선택2</option>
			</select>

		</div>

		<div class="input-container">이용약관 / 개인정보 수집 및 이용 동의</div>
		<div class="input-container">
			<label>이용약관 동의</label> 
			<input type="radio" name="usrTerm"
				value="Y" checked="checked"> <label for="agree">동의</label> <input type="radio"
				name="usrTerm" value="N"> <label for="disagree">비동의</label></input>
		</div>

		<div class="input-container">
			<label>개인정보 수집 동의</label> <input type="radio"
				name="usrPersonalTerm" value="Y" checked="checked"> <label for="agree">동의</label>
			<input type="radio" name="usrPersonalTerm" value="N">
			<label for="disagree">비동의</label>
		</div>

		<div class="input-container">
			<label>이메일 수신</label> <input type="radio" name="usrEmailTerm"
				value="Y"> <label for="agree">동의</label> <input type="radio"
				name="usrEmailTerm" value="N" checked="checked"> <label for="disagree">비동의</label>
		</div>


		<button type="submit" class="btn">Register</button>

	</form>
	
	
	<script type="text/javascript">
	function inputCheck() {
		var id = document.register.usrId;
		var pw = document.register.usrPwd;
		var pwRe = document.register.usrPwdRe;
		var name = document.register.usrName;
		var phone = document.register.usrPhone;
		var gender = document.register.usrGender;
		
		// 정규식 
		// 비밀번호 : 영어+특수문자+숫자를 섞어서 (8~16)자리
		var pwPattern = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,16}$/;
		// 이름 : 한글만 2~4글자
		var namePattern = /^[가-힣]{2,4}$/;
		// 핸드폰 번호 : 010-1234-1234
		var phonePattern = /^\d{3}\d{3,4}\d{4}$/;
		
	    if(!id.value){
	        alert("아이디를 입력하세요.");
	        return false;
	    }
	    
	    if(!pw.value){
	        alert("비밀번호를 입력하세요.");
	        return false;
	    }
	    if(pwPattern.test(pw.value) == false){
	    	alert("영어+특수문자+숫자를 섞어서 (8~16)자리");
	        return false;
	    }
	    if(!pwRe.value){
	        alert("비밀번호를 다시 입력해주세요.");
	        return false;
	    }
	    if(pw.value != pwRe.value){
	        alert("비밀번호가 일치하지 않습니다.다시 입력해주세요");
	        return false;
	    }
	    
	    if(!name.value){
	        alert("이름을 입력하세요.");
	        return false;
	    }
	    if(namePattern.test(name.value) == false){
	        alert("한글만 2~4글자");
	        return false;
	    }
	    
	    if(!phone.value){
	        alert("핸드폰번호를 입력하세요.");
	        return false;
	    }
	 
	    if(phonePattern.test(phone.value) == false){
	    	alert("핸드폰 번호 : 01012341234");
	    	return false;
	    	
	    }
	    
	    if(!gender.value){
	        alert("성별을 선택하세요.");
	        return false;
	    }
	    
	    if(!usrBirth.value){
	    	alert("생년월일을 입력해주세요");
	    	return false;
	    }
	    
	    
	}
	</script>
		<script src="http://code.jquery.com/jquery-3.3.1.js"></script>
	<script type="text/javascript">
		$(document).ready(
				function() {
					var categoryArr = [ '관심분야선택', '아웃도어/여행', '문화/공연/축제',
							'운동/스포츠', '음악/악기', '외국/언어', '게임/오락', '기타' ];
					for (var i = 1; i < categoryArr.length; i++) {
						document.getElementById("category1")[i] = new Option(
								categoryArr[i], categoryArr[i]);
						document.getElementById("category2")[i] = new Option(
								categoryArr[i], categoryArr[i]);
					}
				});
	</script>

	<script type="text/javascript">
		$(function() {
			$('#city1').change(function() {
				region(this, $("#district1"));
			});
		});

		$(function() {
			$('#city2').change(function() {
				region(this, $("#district2"));
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

	<script type="text/javascript">
		function check() {
			id = $("#id").val();

			$.ajax({
				url : 'idDuplicateCheck',
				type : 'POST',
				dataType : 'text', //서버로부터 내가 받는 데이터의 타입
				contentType : 'text/plain; charset=utf-8;',//내가 서버로 보내는 데이터의 타입
				data : id,

				success : function(data) {
					if (data == -1) {
						alert("사용하실 수 있는 아이디입니다.");
					} else {
						alert("중복된 아이디가 존재합니다.");
					}
				},
				error : function() {

				}
			});
		}
	</script>
</body>
</html>

<%@include file="../includes/footer.jsp" %>
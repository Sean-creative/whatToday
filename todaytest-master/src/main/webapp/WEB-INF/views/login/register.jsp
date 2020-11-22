<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../includes/header.jsp"%>
<!-- 작성자: 김지영 -->
<!DOCTYPE html>
<html>
<head>
<style>
    .hide {
    font-size: 15px;
    color: blue;
}
</style>
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
				id="email" name="usrId">
            <button id="idDuplicateCheck" type="button" onclick="idDuplicate();">중복체크</button>
		</div>
		<span id ="emailResult" class="hide"></span>

		<div class="input-container">
			<label>비밀번호 </label> <input class="input-field" type="password"
                placeholder="영어+특수문자+숫자를 섞어서 (8~16)자리"  id="pwd" name="usrPwd">
		</div>
		<span id="pwdResult" class="hide"></span>
		
		<div class="input-container">
			<label>비밀번호 확인 </label> <input class="input-field" type="password"
				placeholder="비밀번호를 다시 입력해주세요" id="pwdRe" name="usrPwdRe">
		</div>
		<span id="pwdReResult" class="hide"></span>	
		
		<div class="input-container">
			<label>이름 </label> <input class="input-field" type="text"
                placeholder="이름을 입력해주세요" id="name" name="usrName">
		</div>
		<span id="nameResult" class="hide"></span>

		<div class="input-container">
			<label>휴대전화 번호 </label> <input class="input-field" type="text"
                placeholder="핸드폰번호를 '-'없이 입력해주세요" id="phone" name="usrPhone">
            <button id="phoneDuplicateCheck" type="button" onclick="phoneDuplicate();">핸드폰번호 체크</button>
		</div>
        <span id ="phoneResult" class="hide"></span>

		<div class="input-container">
			<label>성별 </label> <input type="radio" name="usrGender" value ="m"> 
			<label for="male">남자</label> 
			<input type="radio" id="female" name="usrGender" value ="f"> 
			<label for="female">여자</label><br>
		</div>
		
 		<!--text -> Date(DB타입)으로 변환-->
		<div class="input-container">
			<label>생년월일 </label> <input class="input-field" id ="datefield"  type="date" min="1900-01-01" max="2020-01-01"
				placeholder="Birthday" name="usrBirth" value='<fmt:formatDate pattern = "yyyy/MM/dd" value="${usrBirth}"/>'>
		</div>
		
		<p>선택사항</p>
		<div class="input-container">
			<label>지역1 </label> <select class="input-field" name="usrCity1"
				id="city1">
				<option value="시/도 선택">시/도 선택</option>
				<option value="서울특별시">서울특별시</option>
				<option value="경기도">경기도</option>
			</select> <select class="input-field" name="usrDistrict1" id="district1">
				<option value="군/구 선택">군/구 선택</option>
			</select>
		</div>

		<div class="input-container">
			<label>지역2 </label> <select class="input-field" name="usrCity2"
				id="city2">
				<option value="시/도 선택">시/도 선택</option>
				<option value="서울특별시">서울특별시</option>
				<option value="경기도">경기도</option>
			</select> <select class="input-field" name="usrDistrict2" id="district2">
				<option value="군/구 선택">군/구 선택</option>
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
				value="Y"> <label for="agree">동의</label> <input type="radio"
				name="usrTerm" value="N"> <label for="disagree">비동의</label>
		</div>

		<div class="input-container">
			<label>개인정보 수집 동의</label> <input type="radio"
				name="usrPersonalTerm" value="Y"> <label for="agree">동의</label>
			<input type="radio" name="usrPersonalTerm" value="N">
			<label for="disagree">비동의</label>
		</div>

		<div class="input-container">
			<label>이메일 수신</label> <input type="radio" name="usrEmailTerm"
				value="Y"> <label for="agree">동의</label> <input type="radio"
				name="usrEmailTerm" value="N"> <label for="disagree">비동의</label>
		</div>


		<button type="submit" class="btn">Register</button>

	</form>

	<script src="http://code.jquery.com/jquery-3.3.1.js"></script>
	<script>
		// 이메일 유효성 검사 
		let emailInput = document.getElementById("email");
		let emailResult = document.getElementById("emailResult")
		let emailPattern = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
	
		function emailCheck() {
			if (emailInput.value.length === 0) {
				emailResult.innerHTML = "이메일을 입력하세요.";
			} else if (emailPattern.test(emailInput.value) == false) {
				emailResult.innerHTML = "이메일을 다시 입력하세요.";
			} else {
				// 이메일 입력이 형식에 맞을 경우
				emailResult.innerHTML = "사용할 수 있는 이메일 입니다.";
			}
		}
		// 포커스를 잃었을 때 함수 실행됨.
		emailInput.addEventListener("blur", emailCheck);

		// 비밀번호 유효성 검사
		let pwdInput = document.getElementById("pwd");
		let pwdResult = document.getElementById("pwdResult");
		let pwdPattern = /^(?=.*[a-zA-Z])((?=.*\d)|(?=.*\W))(?=.*[0-9]).{8,16}$/;

		function pwdCheck() {
			if (pwdInput.value.length === 0) {
				pwdResult.innerHTML = "비밀번호를 입력하세요.";
			} else if (pwdPattern.test(pwdInput.value) == false) {
				pwdResult.innerHTML = "비밀번호는 8글자이상 16글자이하여야 하며 영어,숫자,특수문자를 1개이상 포함해야 합니다.";
			} else if (pwdInput.value.search(/\s/)!= -1){
				pwdResult.innerHTML = "비밀번호는 공백없이 다시 입력해주세요";
				//pw.value.replace(/\s/, "");
			}else {
				pwdResult.innerHTML = "사용할 수 있는 비밀번호 입니다.";
			}


		}
		pwdInput.addEventListener("blur", pwdCheck);

		// 비밀번호 재입력 유효성 검사
		let pwdReInput = document.getElementById("pwdRe");
		let pwdReResult = document.getElementById("pwdReResult");

		function pwdReCheck() {
			if (pwdReInput.value.length === 0) {
				pwdReResult.innerHTML = "비밀번호를 입력하세요.";
			} else if (pwdInput.value != pwdReInput.value) {
				pwdReResult.innerHTML = "입력한 비밀번호와 일치하지 않습니다. 다시 입력해주세요";
			} else {
				pwdReResult.innerHTML = "사용할 수 있는 비밀번호 입니다.";
			}
		}
		pwdReInput.addEventListener("blur", pwdReCheck);
		
		// 이름 유효성 검사.
		let nameInput = document.getElementById("name");
		let nameResult = document.getElementById("nameResult")
		let namePattern = /^[가-힣]{2,4}$/;

		function nameCheck() {
			if (nameInput.value.length === 0) {
				nameResult.innerHTML = "이름을 입력하세요.";
			} else if (namePattern.test(nameInput.value) == false) {
				nameResult.innerHTML = "한글 2~4글자인 이름을 입력해주세요";
			} else {
				// 이름 형식이 맞을 경우
				nameResult.innerHTML = "사용할 수 있는 이름 입니다.";
			}
		}
		// 포커스를 잃었을 때 함수 실행됨.
		nameInput.addEventListener("blur", nameCheck);
		
		// 핸드폰 번호 유효성 검사
		let phoneInput = document.getElementById("phone");
		let phoneResult = document.getElementById("phoneResult")
		//01012341234
		let phonePattern = /^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$/;

		function phoneCheck() {
			if (phoneInput.value.length === 0) {
				phoneResult.innerHTML = "핸드폰 번호를 입력하세요.";
			} else if (phonePattern.test(phoneInput.value) == false) {
				phoneResult.innerHTML = "핸드폰 번호를 다시 입력하세요 (01012341234)";
			} else {
				// 핸드폰 번호 형식이 맞을 경우
				phoneResult.innerHTML = "사용할 수 있는 핸드폰 번호 입니다.";
			}
		}

		phoneInput.addEventListener("blur", phoneCheck);
	
		function inputCheck(){
			if(emailInput.value == ""){
				return false;
			}
			if(document.getElementById('idDuplicateCheck').value == ""){
				alert("아이디 중복체크를 확인하세요");
				return false;
			}
			if(pwdInput.value == ""){
				return false;
			}
			if(pwdReInput.value == ""){
				return false;
			}
			if(nameInput.value == ""){
				return false;
			}
			if(phoneInput.value == ""){
				return false;
			}
			if(document.getElementById('phoneDuplicateCheck').value == ""){
				alert("핸드폰 번호 체크를 확인하세요");
				return false;
			}
			if(pwdInput.value == ""){
				return false;
			}
			
			let usrGender = document.getElementsByName('usrGender');
			let gender = null;
			if(usrGender[0].checked == true){
				gender = usrGender[0].value;
			}
			if(usrGender[1].checked == true){
				gender = usrGender[1].value;
			}
			if(gender == null){
				alert("성별을 선택하세요");
				return false;
			}
			
			if(document.getElementById('datefield').value == ""){
				alert("생년월일을 선택하세요");
				console.log("dd");
				return false;
			}
			
			let usrTerm = document.getElementsByName('usrTerm');
			let term = null;
			if(usrTerm[0].checked == true){
				term = usrTerm[0].value;
			}
			if(usrTerm[1].checked == true){
				alert("이용약관에 반드시 동의해야 회원가입이 가능합니다.");
				return false;
			}
			if(term == null){
				alert("이용약관에 동의를 확인하세요");
			}
			
			let usrPersonalTerm = document.getElementsByName('usrPersonalTerm');
			let personalTerm = null;
			if(usrPersonalTerm[0].checked == true){
				personalTerm = usrPersonalTerm[0].value;
			}
			if(usrPersonalTerm[1].checked == true){
				alert("개인정보 약관에 반드시 동의해야 회원가입이 가능합니다.");
				return false;
			}
			if(personalTerm == null){
				alert("개인정보 약관에 동의를 확인하세요");
				return false;
			}

			
			let usrEmailTerm = document.getElementsByName('usrEmailTerm');
			let emailTerm = null;
			if(usrEmailTerm[0].checked == true){
				emailTerm = usrEmailTerm[0].value;
			}
			if(usrEmailTerm[1].checked == true){
				emailTerm = usrEmailTerm[1].value;
			}
			if(emailTerm == null){
				alert("이메일 수신여부를 체크해주세요");
				return false;
			}
	
		}
	</script>

	<script type="text/javascript">
		// 생년월일 입력 : max=오늘
		let today = new Date();
		let dd = today.getDate();
		let mm = today.getMonth() + 1; //January is 0!
		let yyyy = today.getFullYear();
		if (dd < 10) {
			dd = '0' + dd
		}
		if (mm < 10) {
			mm = '0' + mm
		}

		today = yyyy + '-' + mm + '-' + dd;
		document.getElementById("datefield").setAttribute("max", today);

		// 관심분야 선택 값들
		$(document).ready(
				function() {
					let categoryArr = [ '관심분야선택', '아웃도어/여행', '문화/공연/축제',
							'운동/스포츠', '음악/악기', '외국/언어', '게임/오락', '기타' ];
					for (let i = 0; i < categoryArr.length; i++) {
						document.getElementById("category1")[i] = new Option(
								categoryArr[i], categoryArr[i]);
						document.getElementById("category2")[i] = new Option(
								categoryArr[i], categoryArr[i]);
					}
				});

		// 지역 선택 - jquery
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
			let city = [ "서울특별시", "경기도" ];

			let seoul = [ "강남구", "강동구", "강북구", "강서구", "관악구", "광진구", "구로구",
					"금천구", "노원구", "도봉구", "동대문구", "동작구", "마포구", "서대문구", "서초구",
					"성동구", "성북구", "송파구", "양천구", "영등포구", "용산구", "은평구", "종로구",
					"중구", "중랑구" ];

			let gyeonggi = [ "고양시", "과천시", "광명시", "광주시", "구리시", "군포시", "김포시",
					"남양주시", "동두천시", "부천시", "성남시", "수원시", "시흥시", "안산시", "안성시",
					"안양시", "양주시", "여주시", "오산시", "용인시", "의왕시", "의정부시", "이천시",
					"파주시", "평택시", "포천시", "하남시", "화성시", "가평군", "양평군", "연천군" ];
			
			let district;
			// change(function(){$( ':selected', o).val() => this }
            if ($(':selected', o).val() == "시/도 선택") {
                district = ["군/구 선택"];
			}
            else if ($(':selected', o).val() == "서울특별시") {
				district = seoul;
			} else if ($(':selected', o).val() == "경기도") {
				district = gyeonggi;
			}

			d.empty();

			for (let i = 0; i < district.length; i++) {
				let option = $("<option value=" + district[i] +">"
						+ district[i] + "</option>");
				d.append(option);
			}
		}
	</script>

	<script type="text/javascript">
		function idDuplicate() {
			let id = $("#email").val();

			$.ajax({
				url : 'idDuplicateCheck',
				type : 'POST',
				dataType : 'text', //서버로부터 내가 받는 데이터의 타입
				contentType : 'text/plain; charset=utf-8;',//내가 서버로 보내는 데이터의 타입
				data : id,

				success : function(data) {
					if (data == -1) {
						emailResult.innerHTML = "사용하실 수 있는 아이디입니다.";

					} else {
						emailResult.innerHTML = "이미 사용중인 아이디 입니다.";
					}
				},
				error : function() {
				}
			});
			
			document.getElementById('idDuplicateCheck').value = "idChecked";
		}
		
		function phoneDuplicate() {
			let phone = $("#phone").val();

			$.ajax({
				url : 'phoneDuplicateCheck',
				type : 'POST',
				dataType : 'text', //서버로부터 내가 받는 데이터의 타입
				contentType : 'text/plain; charset=utf-8;',//내가 서버로 보내는 데이터의 타입
				data : phone,

				success : function(data) {
					if (data == -1) {
						phoneResult.innerHTML = "사용하실 수 있는 핸드폰번호입니다.";

					} else {
						phoneResult.innerHTML = "이미 사용중인 핸드폰 번호 입니다.";
					}
				},
				error : function() {
				}
			});
			
			document.getElementById('phoneDuplicateCheck').value = "phoneChecked";
		}
	</script>




</body>
</html>

<%@include file="../includes/footer.jsp"%>
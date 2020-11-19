<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file = "../includes/header.jsp" %>


<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/account.css' />?after">
<nav id="nav">
<div class ="menu">
    <ul>
        <li>
            <form action="/account/main" method="post">
                <button class="btn1" type="submit" >마이페이지</button>
            </form>
        </li>
            <li>
        <div class="dropdown">
            <button type="button" class="dropbtn">모임관리</button>
            <div class="dropdown-content">
            <ul>
                <li>
                <form action="/account/myclub/main" method="post">
            	<button type="submit">모임관리홈</button>
        		</form>
                </li>
                <li>                <form action="/account/myclub/main" method="post">
            	<button type="submit">만남개설</button>
        		</form></li>
                <li>                <form action="/account/myclub/main" method="post">
            	<button type="submit">회원관리</button>
        		</form></li>
                
                
            </ul>
            </div>
        </div>
        </li>
    <li>
        <form action="/account/auth_edit" method="post">
            <button type="submit" style="color: yellow">회원정보수정</button>
        </form>
    </li>
    <li>
        <form action="/account/password" method="post" >
            <button type="submit">비밀번호수정</button>
        </form>
    </li>
    <li>
        <form action="/account/auth_leave" method="post">
            <button type="submit">회원탈퇴하기</button>
        </form>
        
        </li>
    </ul>

</div>
</nav>
<section id="wrap">
<form name="register" action="/account/editAction" method="post" onsubmit="return inputCheck();">
    <div class ="info"> 
        <div class="pic">
            <img src="${userVO.usrImg }" alt="일단 사진은 이미지 주소로 넣는걸로">
        <button>사진변경</button>
        </div>
        <div class="userInfo">
            <span>ID </span><input type="text" readonly="readonly" value="<c:out value="${userVO.usrId }"/>"><br> 
            <span>NAME </span><input type="text" name="usrName" value="<c:out value="${userVO.usrName }"/>"><br>
            <span>PHONE </span><input type="text" name="usrPhone" value="<c:out value="${userVO.usrPhone }"/>"><br>
            <input type="hidden" name="usrNum" value="<c:out value="${userVO.usrNum }"/>">
        </div>
    
    </div>
    
    <div class ="info"> 
        <div class="userInfo" style="margin-left: 18.5%;">
             <h1>관심정보<span style="font-size: 15px; margin-left: 20px">개인별 맞춤정보 제공 - 수정은 이름, 폰번, 지역, 관심카테고리</span></h1>
             
             <ul style = "list-style: none;">
             <li>
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
             </li>
             <li>
                <label>관심분야 1 </label><select name="usrCategory1">
                </select>
                <label>관심분야 2 </label><select name="usrCategory2">
                </select>
             
             </li>
             
             </ul>

            
        </div>
        
    </div>
    <div>
    <button type="submit" class="modifyBtn"> 수정 </button>
    </div>
    </form>
</section>
<script type="text/javascript" src="/resources/js/select.js"></script>
<script type="text/javascript">
function inputCheck() {

	let name = document.register.usrName;
	let phone = document.register.usrPhone;

	// 이름 : 한글만 2~4글자
	const namePattern = /^[가-힣]{2,4}$/;
	// 핸드폰 번호 : 010-1234-1234
	const phonePattern = /^\d{3}\d{3,4}\d{4}$/;

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
    
    
}

$(document).ready(function() {
	<!-- 도시고르는거는 하드코딩, 카테고리는 ajax 뭐로할지 정할것-->
	
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
		if ($(':selected', o).val() == "서울특별시") {
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
	
	
	let usrCat1 = $("select[name=usrCategory1]");
	let usrCat2 = $("select[name=usrCategory2]");
	const cat = 'C001';
	
	categoryService.getCategorylist({catClassificationCode:cat},function(list){
		console.log(list);
		let str = "";
		if("<c:out value="${userVO.usrCategory1 }"/>" == ""){
			str += '<option name = "usrCategory1" value="">선택안함</option>';
		}else{
			str += '<option name = "usrCategory1" value="<c:out value="${userVO.usrCategory1 }"/>">${userVO.usrCategory1 }</option>';
			str += '<option name = "usrCategory1" value="">선택안함</option>';
		}
		for(let i = 0, len = list.length || 0; i< len; i++){
			if(list[i].catName == "${userVO.usrCategory1 }"){
				console.log(list[i].catName);
				continue;
			}
			str += '<option name="usrCategory1" value="'+list[i].catName+'">'+list[i].catName+'</option>';
		}
		usrCat1.html(str);
	
	});	

	categoryService.getCategorylist({catClassificationCode:cat},function(list){
		console.log(list);
		let str = "";
		if("<c:out value="${userVO.usrCategory2 }"/>" == ""){
			str += '<option name = "usrCategory2" value="">선택안함</option>';
		}else{
			str += '<option name = "usrCategory2"value="<c:out value="${userVO.usrCategory2 }"/>">${userVO.usrCategory2 }</option>';
			str += '<option name = "usrCategory2" value="">선택안함</option>';
		}
		for(let i = 0, len = list.length || 0; i< len; i++){
			if(list[i].catName == "${userVO.usrCategory2 }"){
				console.log(list[i].catName);
				continue;
			}
			str += '<option name="usrCategory2" value="'+list[i].catName+'">'+list[i].catName+'</option>';
		}
		usrCat2.html(str);
	});
	
});
</script>
    <%@include file = "../includes/footer.jsp" %>
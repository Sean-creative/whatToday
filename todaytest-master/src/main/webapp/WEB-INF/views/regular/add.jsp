<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

<h3 style="text-align: center">기본정보(필수)</h3>

<form id="register" name="register" action="/regular/add" method="post" onsubmit="return inputCheckclub();" enctype="multipart/form-data">

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
	<select id="cbSubcat" name="cbSubcat"></select>
	<br> <label for="cbName">모임명</label>
	<input type="text" id="club" name="cbName">
	<br> <label for="cbCity">지역 </label>
	<select name="cbCity" id="cbCity">
		<option value="서울특별시">서울특별시</option>
		<option value="경기도">경기도</option>
	</select>
	<select name="cbDistrict" id="cbDistrict"></select>
	<label for="cbMbNum">정원</label>
	<input type="number" id="num" name="cbMbNum" min="1" max="200">
	<br>
	<input type="hidden" name="cbMakeDate">
	<!--개설일자 : sysdate로 기본설정 -->
	<label for="cbHashtag">해시태그</label>
	<input type="text" id="hash" name="cbHashtag" value="#">
	<br> <label for="cbIntro">한줄소개</label>
	<input type="text" id="info" name="cbIntro" placeholder="30자이내로 작성하세요">
	<br> <label for="cbDetailContent">모임 상세내용(필수)</label><br>
	<textarea name="cbDetailContent" rows="10" cols="100" style="resize: none" placeholder="30자이내로 작성하세요"></textarea>
	<br>
	
	<div class="inputArea" style="float: left; margin-right: 50px">

			<div class="select_img" style="margin: 2px 0px">
				<img class="thumbImg" src="/resources/img/logo.png" style="margin: 0px;" /> <br>
				<!-- <label for="gdsImg" >이미지 선택</label> -->
				<input type="file" id="gdsImg" name="file" style="width: 200px;" />
			</div>

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
		</div>
	
	
	
	<button type="submit">개설하기</button>
</form>

<script type="text/javascript">

   //유효성 검사 (빈문자열 체크, 글자 제한(30자이내로), 공백 제한 등)
   function inputCheckclub(){
      
      let club = document.register.cbName;
      let number = document.register.cbMbNum;
      let date = document.register.cbMakeDate;
      let info = document.register.cbIntro;
      let infodetail = document.register.cbDetailContent;
      let cbMbNum = document.register.cbMbNum;
      
      //모임명의 앞뒤 공백 체크 
      let inputValue = club.value.replace(/^(\s|\.)*|(\s|\.)*$/g, ""); //replace:공백,.을 ""(제거)해준다.
      
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
      if(!number.value || (number.value <= 0) || (number.value > 200)) {
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
     
      
   // 50명이상일경우 포인트 결제 창으로 이동 (지영)
      if(!number.value || (number.value <= 0) || (number.value > 50)){
    	  console.log("모임 정원: " + number.value);
		  // 현재 개설자가 포인트가 있는 지 확인한다.
		  let usrNum = document.register.cbLeaderNum.value;
    	  $.ajax({
    		url: "/pay/check/userpoint", 
           	type: 'POST',  
       	    dataType: 'text', //서버로부터 내가 받는 데이터의 타입
       	    contentType : 'text/plain; charset=utf-8;',//내가 서버로 보내는 데이터의 타입
            data: usrNum,
            success: function(userPoint){
    	    	console.log("userPoint: " + userPoint);
    	    	// 모임 개설 = 만원
    			// 포인트가 만원이하 있을 경우
    			// 카카오 페이 포인트 결제 창으로 
    			if(userPoint<'10000'){
    				window.open('http://localhost:8080/pay/kakaoPayPayment', '카카오페이 포인트 결제','width=#, height=#');
    				/**window.open('http://localhost:8080/pay/kakaoPayPayment222', '카카오페이 포인트 결제','width=#, height=#');*/
    			}else{
    				// 포인트 결제 창으로 
    				// 모달로 바꾸기
					// 결제 완료되었는지 체크전에 미리 개설 되어 있음.. 수정필요..    				
    				window.open('http://localhost:8080/pay/pointPayment', '포인트 결제','width=#, height=#');
    				document.getElementById('register').submit();
    			}
    	    },
    	    error: function (){        
    	                      
    	    }
		
       	    
           });
		return false;
	  }
   }

   //카테고리/분야 선택, 지역 선택 
   $(function() {
      //초기 세팅값
      selectHobby("아웃도어/여행");
      selectCity("서울특별시");
      
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
               let option = $("<option value=" + item2 + ">" + item2 + "</option>"); 
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
               let option = $("<option value=" + item2 + ">" + item2 + "</option>");
               $("#cbDistrict").append(option); //아래로 붙여준다.
            })
         }
      })
   }
</script>

<%@include file="../includes/footer.jsp"%>
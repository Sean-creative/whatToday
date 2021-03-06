<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp"%>
<link rel="stylesheet" href="../resources/css/clubAddStyle.css">
<link rel="stylesheet" href="/resources/css/paymentModal.css">

<form id="register" name="register" action="/regular/add" method="post" onsubmit="return inputCheckclub();" enctype="multipart/form-data">
<div class="regubg">

	<div id="reguform">

		<input type="hidden" id="cbLeaderNum" name="cbLeaderNum" value="${usrNum}" />
		<input type="hidden" id="cbType" name="cbType" value="정기모임" />
		<input type="hidden" id="cbLeaderName" name="cbLeaderName" value="${usrName}" />

		<span class="half">정기모임개설</span>

		<p class="cate">모임명</p>
		<div class="caja1">
			<div class="lef1">
				<div class="select_img">
					<img class="thumbImg" src="/resources/img/logo.png" /> <br>

					<!-- <label for="gdsImg" >이미지 선택</label> -->
					<input type="file" id="gdsImg" name="file" style="width: 200px;" />
				</div>
			</div>
			<div class="rig1">
				<input type="text" id="club" name="cbName" placeholder="모임명을 입력하세요.">
				<br>
				<input type="text" style="width: 350px" id="info" name="cbIntro" placeholder="한줄소개를 10자이내로 작성하세요.">
			</div>
		</div>

		<p class="cate">카테고리</p>
		<div class="caja2">
			<div class="lef1">
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
			</div>
			<div class="rig1">
				<label for="cbSubcat">모임</label>
				<select id="cbSubcat" name="cbSubcat"></select>
			</div>
		</div>

		<p class="cate">지역</p>
		<div class="caja2">
			<div class="lef1">
				<label for="cbCity">지역 </label>
				<select name="cbCity" id="cbCity">
					<option value="서울특별시">서울특별시</option>
					<option value="경기도">경기도</option>
				</select>
			</div>
			<div class="rig1">
				<label for="cbDistrict">세부지역 </label>
				<select name="cbDistrict" id="cbDistrict"></select>
			</div>
		</div>

		<p class="cate">정원</p>
		<div class="caja2">
			<div class="lef1">
				<label for="cbMbNum">정원</label>
				<input type="number" id="num" name="cbMbNum" min="1" max="200">
			</div>
			<div class="rig1">
				<p class="pil">*50명 이상은 포인트 결제가 필요합니다.</p>
			</div>
		</div>



		<p class="cate">해시태그 (최대 5개)</p>
		<div class="caja2">
			<div id="hashTagDiv">
				<label for="cbHashtag" class="class" style="margin-top: 17px;">해시태그 </label>
				<input type="hidden" value="" name="cbHashtag" id="rdTag" />
				<input type="text" id="tag" size="7" value="#"/>
				<ul id="tag-list"></ul>
			
				<input type="hidden" name="cbMakeDate">
				<!--개설일자는 sysdate로 설정 -->
							
			</div>
		</div>




		<p class="cate">모임상세내용</p>
		<div class="caja2">
			<div class="lef1 detailinfo">
				<label for="cbDetailContent" style="margin-top: 12px;">상세내용</label>
				<textarea name="cbDetailContent" rows="10" cols="100" style="resize: none" placeholder="자세하게 작성하세요 (모임설명,강퇴조건 등)"></textarea>
			</div>
      	 </div>
      	 
      	 <!-- ##### 50명이상일경우 포인트 결제 모달 (지영) ##### -->
   	 	 <div id="myModal" class="modal">
		    <!-- Modal content -->
		    <div class="modal-content">
		        <div id="pointBanner">
		            <a href="/index/main"> <img src="/resources/img/logo.png" alt="logo"width="80px"></a>
		            <span class="close">&times;</span>
		        </div>
		        
		        <main>
		            <p id="myPointHist">내 포인트 내역 > </p>
		            <div id="myPoint"> ${usrPoint }P </div>
		            <div class="bar"></div><br>
		            <p id="pointPayment">포인트 결제</p>
		            <div id="pointbx">
		                <div>
		                    <img src="/resources/img/coupon.png" alt="coupon" id="couponImg">
		                    <div class="pointChargeBox">
		                    <span id="product">모임 정원 범위 확대 ( 50이상 200명이하 ) </span>   
		                    <input type="hidden" id="item" value="10000" >   
		                    <span id="pointAmount">10,000P</span> 
		                </div>
		            </div>     
		            <div id="chargebtn">
		                <button type="button" id="chargePoint">결제하기</button>
		            </div>   
		            </div>
		
		            <div id = warnTitle>
		                <p id="warnLetter">유의사항</p><br>
		                <ul>
		                    <li>포인트 적립 및 사용처의 변경은 사전 고지 없이 내부 사정에 따라 변경될 수 있습니다.</li>
		                    <li>포인트의 유효기간은 포인트 지급 경로에 따라 다를 수 있습니다.</li>
		                    <li>한번 사용하신 포인트에 대해서는 철회가 불가능합니다.</li>
		                    <li>계정 정보 이전 시에 포인트 이전은 불가능합니다.</li>
		                </ul>
		            </div>
		        </main>
		    </div>
		 </div><!--END myModal-->
      	 
      	 <div id="regiform">
      	 	<input type="submit" class="btn" value="개설하기">
   	 	 </div>
   	 	 
	</div>		
</div>
</form>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
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
      if(!infodetail.value) {
         alert("상세내용을 입력해주세요.");
         return false;
      }
      
      //해시태그값이 hidden에 들어감!  (선우)
      var value = marginTag(); // return array
	  $("#rdTag").val(value);
     
      
   	  //START ##### 50명이상일경우 포인트 결제 창으로 이동 (지영) #####
      if(!number.value || (number.value <= 0) || (number.value >= 50)){
    	  console.log("모임 정원: " + number.value);
		  // 현재 개설자가 포인트가 있는 지 확인한다.
		  let usrNum = document.register.cbLeaderNum.value;
		  let userPoint = document.getElementById("myPoint");
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
    				window.open('http://localhost:8088/pay/kakaoPayPayment?usrNum='+usrNum, '카카오페이 포인트 결제','width=700px, height=700px');
    			}else{
    				
					// 결제 완료되었는지 체크전에 미리 개설 되어 있음.. 수정필요..    			
    				// window.open('http://localhost:8080/pay/pointPayment', '포인트 결제','width=#, height=#');
    				// document.getElementById('register').submit();
    				
    				// 포인트 결제 창으로 
    				// 모달로 바꾸기 - ok!!
    				var modal = document.getElementById("myModal");
    				modal.style.display = "block";
    				var span = document.getElementsByClassName("close")[0];
    				span.onclick = function() {
    					modal.style.display = "none";
    				}
    				// 카카오 페이 결제 후 업데이트돤 나의 포인트 확인 
    				$.ajax({
    					url: "/pay/check/userpoint", 
		             	type: 'POST',  
		         	    dataType: 'text', //서버로부터 내가 받는 데이터의 타입
		         	    contentType : 'text/plain; charset=utf-8;',//내가 서버로 보내는 데이터의 타입
		                data: usrNum,
		                success: function(data){ 
		                	document.getElementById("myPoint").innerText = data+"P";
		                },
		    		 	error: function (){ }		    					
    				});
    				$('#chargePoint').click(function () {
    					let money = $('#item').val();
    					console.log("money: " + money);
    			    		 $.ajax({
    			                url: "/pay/point", 
    			             	type: 'POST',  
    			         	    dataType: 'text', //서버로부터 내가 받는 데이터의 타입
    			         	    contentType : 'text/plain; charset=utf-8;',//내가 서버로 보내는 데이터의 타입
    			                data: money,
    			                success: function(){ 
    			                	// 포인트 db로 보내고 성공하면 개설
    			                	swal({
		  								title: "결제와 동시에 모임이 개설됩니다.",
		  								text: "결제 하시겠습니까?",
		  								icon: "warning",
		  								button: "확인",
									})
									.then((value) => {
										
										document.getElementById('register').submit();
									});
    			                },
    			    		 	error: function (){ }
    			             });
    			   });// end click 
    			}
    	    },
    	    error: function (){        
    	                      
    	    }
		
       	    
           });
		return false;
	  }
   }// END ##### 50명이상일경우 포인트 결제 창으로 이동 (지영) #####

   
   
   
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
   
   /* 스크립트는 파일이 등록되면 현재화면에서 어떤 이미지인지 볼 수 있도록 해주는 역할 */
	$("#gdsImg").change(
			function() {
			console.log(this.files);
				if (this.files && this.files[0]) {
					var reader = new FileReader;
					reader.onload = function(data) { console.log(data.target.result);
						$(".select_img img").attr("src",
								data.target.result).width(200)
								.height(144);
					}
					reader.readAsDataURL(this.files[0]);
				}
	});
   
   
   
   
   
   
	/* 해시태그 관련 */
	var tag = {};
	var counter = 0;
	var maxHash = 0;

	// 태그를 추가한다.
	function addTag(value) {
		tag[counter] = value; // 태그를 Object 안에 추가
		counter++; // counter 증가 삭제를 위한 del-btn 의 고유 id 가 된다.
		maxHash++;
	}

	// 최종적으로 서버에 넘길때 tag 안에 있는 값을 array type 으로 만들어서 넘긴다.
	function marginTag() {
		return Object.values(tag).filter(function(word) {
			return word !== "";
		});
	}


	// 처음 부터 #이 달려있고
	// 엔터, 스페이스바 , # 을 누르면 -> #까지 해서 올라간다.
	// 5개까지 밖에 입력하지 못한다.
	$("#tag").keyup(function(e) {
		let text = $(this).val();

		if (text.length == 0) {
			$(this).val("#");
		}

		// #은 제외
		var regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-+<>@\$%&\\\=\(\'\"]/gi;

		// test() ㅡ 찾는 문자열이 들어있는지 확인
		if (regExp.test(text)) {
			text = text.replace(regExp, ""); // 찾은 특수 문자를 제거
			$(this).val(text);
		}
		
	});

	$("#tag")
			.on(
					"keypress",
					function(e) {

						var self = $(this);

						// input 에 focus 되있을 때 엔터 및 스페이스바 입력시 구동
						if (e.key === "Enter" || e.keyCode == 32
								|| e.keyCode == 35) {

							if (maxHash >= 5) {
								alert("5개가 최대입니다.");
								self.val("#");
							} else if (self.val().length  > 11){
						        alert("해시태그 글자수는 10글자가 최대입니다.")
						      } 														
							else {
								var tagValue = self.val(); // 값 가져오기
								console.log(tagValue);

								// 사용자가 갑자기 엔터같은걸 누르면 특수문자가 들어갈 수 있으므로 한번 더 써줌,
								// #은 제외
								var regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-+<>@\$%&\\\=\(\'\"]/gi;

								// test() ㅡ 찾는 문자열이 들어있는지 확인
								if (regExp.test(tagValue)) {
									// 찾은 특수 문자를 제거
									tagValue = tagValue.replace(regExp, "");  								
								}

								// 값이 없으면 동작 안함, '#'만 실수로 들어가도 동작 안함
								if (tagValue !== "" && tagValue !== "#") {

									// 같은 태그가 있는지 검사한다. 있다면 해당값이 array 로 return
									// 된다.
									var result = Object.values(tag).filter(
											function(word) {
												return word === tagValue;
											})

									// 태그 중복 검사
									if (result.length == 0) {
										$("#tag-list")
												.append(
														"<li class='tag-item'>"
																+ tagValue
																+ "<span class='del-btn' idx='"
																+ counter
																+ "'>x</span></li>");
										addTag(tagValue);
										self.val("#");
									} else {
										alert("태그값이 중복됩니다.");
									}
								}
							}
							e.preventDefault(); // SpaceBar 시 빈공간이 생기지 않도록 방지

						}
					});

	// 삭제 버튼
	// 삭제 버튼은 비동기적 생성이므로 document 최초 생성시가 아닌 검색을 통해 이벤트를 구현시킨다.
	$(document).on("click", ".del-btn", function(e) {
		var index = $(this).attr("idx");
		tag[index] = "";
		$(this).parent().remove();
		maxHash--;
	});
	
	
</script>
<footer style="margin-top:0px;">
        <div class="canizo">
          <div class="ftlef">
            <a href="#">서비스 이용약관</a>
            <a href="#">개인정보취급방침</a>
            <a href="/cs/notice">고객센터</a>
          </div>
          <div class="ftrig">
            <li class="ftnaver">
              <a href=""></a>
            </li>  
            <li class="ftkakao"> 
              <a href=""></a>
            </li>
          </div>
        </div>
        <div class="canizo2">
          <p class="quetday">오늘뭐하지?</p>
          <div class="fotinf">
            <p>서울특별시 종로구 종로2가 9, 11층</p>
            <p>김선우,김지영,국민성,조다혜,이수진</p>
            <p>https://github.com/Sean-creative/whatToday</p>
            <p>whatToday@gmail.com</p>
            <p>02-722-1481 (문의시간:10:00~17:00/점심시간 : 13:00~14:00)</p>
          </div>
          <div class="fotinf2">
            <p>© WhatToday Inc. 2020 All Rights Reserved.</p>
          </div>
        </div>
    </footer>
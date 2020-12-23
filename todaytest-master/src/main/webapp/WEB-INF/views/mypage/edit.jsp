<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@include file="../includes/header.jsp"%>
<link id="myCss" rel="stylesheet" type="text/css" href="<c:url value='/resources/css/mypage.css' />?after">
<div id="totalMenu">
	<nav id="navMenu">
		<div class="mypageMenu">
			<div class="uInfo">
				<img
					src="\resources\img\upload\<c:out value="${userVO.usrImgPath }"/>\<c:out value="${userVO.usrImg }"/>"><br>
				<h5>${userVO.usrName }</h5>
				<br>
				<h5>${userVO.usrId }</h5>
				<br>
				<h5>포인트 ${userVO.usrPoint }점</h5>
			</div>


			<div class="info">
				<h1>메뉴</h1>
				<form action="/mypage/main" method="get">
					<button class="btn1" type="submit">마이페이지</button>
				</form>
				<button type="button" class="accordionBtn">모임관리</button>
				<div class="accordion">
					<form action="/mypage/myclub/main" method="get">
						<button type="submit">모임관리홈</button>
					</form>

					<form action="/mypage/myclub/main" method="post">
						<button type="submit">만남개설</button>
					</form>

					<form action="/mypage/myclub/userManage" method="get">
						<button type="submit">회원관리</button>
					</form>
				</div>
				<form action="/mypage/auth_edit" method="get">
					<button type="submit" style="color: yellow;">회원정보수정</button>
				</form>
				<form action="/mypage/password" method="get">
					<button type="submit">비밀번호수정</button>
				</form>
				<form action="/mypage/auth_leave" method="get">
					<button type="submit">회원탈퇴하기</button>
				</form>
			</div>
		</div>
	</nav>
	
<section id="wrapInfo2">
	<form name="register" action="/mypage/editAction" method="post"	onsubmit="return inputCheck();">
		
		<div class="modifyInfo">
			<div id="prevWrap">
			<div id="preview">
			<img src="\resources\img\upload\<c:out value="${userVO.usrImgPath }"/>\<c:out value="${userVO.usrImg }"/>" alt="로딩중"/>
			</div>
			<div class='uploadDiv'>
				<label for="uploadBtn">프로필 변경</label><input type='file' id="uploadBtn" name='uploadFile' accept="image/jpeg, image/jpg, image/png">
			</div>
			</div>
			<div class="userInfo">
			<span>휴대전화</span><br>
			<div>
			<input type="text" id="phone" name="usrPhone" value="<c:out value="${userVO.usrPhone }"/>">
			<button id="phoneDuplicateCheck" type="button" onclick="phoneDuplicate();">중복확인</button>
			</div>
                <input type="hidden" name="usrName" readonly="readonly" value="<c:out value="${userVO.usrName }"/>">
				<input type="hidden" name="usrId" readonly="readonly" value="<c:out value="${userVO.usrId }"/>">
				<input type="hidden" name="usrGender" readonly="readonly" value="<c:out value="${userVO.usrGender }"/>">
				<input type="hidden" name="usrBirth" readonly="readonly" value="<c:out value="${userVO.usrBirth	 }"/>">
				<input type="hidden" name="usrNum" value="<c:out value="${userVO.usrNum }"/>">
				<input type="hidden" name="usrState" value="<c:out value="${userVO.usrState }"/>">
				<input type="hidden" name="usrImg" value="<c:out value="${userVO.usrImg}"/>">
				<input type="hidden" name="usrImgPath" value="<c:out value="${userVO.usrImgPath}"/>">
			</div>
			<div class="userInfo2">
			<div class="smallInfo">
				<p style="font-size: 15px; font-weight: bold;">* 관심정보<br>
                <span style="font-size: 9px;font-weight: normal;color: #999;">관심정보는 선택사항이며, 선택하지 않아도 정보수정이 가능합니다.</span>
                </p>
            </div>
				<div class="smallInfo">
					<span class="detailInfoSpan">
					<label class="labelSt">카테고리/분야1</label><br>
					<select	style="width:300px" name="usrCategory1">
					</select> </span>
					<span class="detailInfoSpan">
					<label class="labelSt">카테고리/분야2</label><br>
					<select	style="width:300px" name="usrCategory2">
					</select></span>
				</div>


				<div class="smallInfo">
					
					
					<span class="detailInfoSpan"><label class="labelSt">관심지역1</label><br>
					<select
						name="usrCity1" id="city1">

					</select> <select name="usrDistrict1" id="district1">

					</select></span> 
					<span class="detailInfoSpan">
					<label class="labelSt">관심지역2</label><br>
					<select
						name="usrCity2" id="city2"></select> <select name="usrDistrict2" id="district2">


					</select></span>
				</div>
		</div>
			<button type="submit" class="modifyBtn">수정</button>
			</div>

		
				


	</form>
</section>
</div>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script type="text/javascript" src="/resources/js/select.js"></script>
<script type="text/javascript">

// 핸드폰 번호 유효성 검사
let phoneInput = document.getElementById("phone");
let phoneResult = document.getElementById("phoneResult")
//01012341234
const phonePattern = /^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$/;

function phoneCheck() {
	if (phoneInput.value.length === 0) {
		swal("핸드폰 번호를 입력하세요.", "", "warning");
		return false;
	} else if (phonePattern.test(phoneInput.value) == false) {
		swal("핸드폰 번호를 다시 입력하세요 (01012341234)", "", "warning");
		return false;
	}
		return true;
}
function inputCheck(){
	let usrDistrict1 = document.register.usrDistrict1;
	let usrDistrict2 = document.register.usrDistrict2;
	let usrCategory1 = document.register.usrCategory1;
	let usrCategory2 = document.register.usrCategory2;
	
	if ((usrDistrict1.value != '군/구 선택' && usrDistrict2.value != '군/구 선택') && usrDistrict1.value == usrDistrict2.value){
		swal("서로 다른 지역을 선택해주세요.", "", "warning");
		return false;
	}

	if ((usrCategory1.value != '관심분야선택' && usrCategory2.value != '관심분야선택') && usrCategory1.value == usrCategory2.value){
		swal("서로 다른 카테고리를 선택해주세요", "", "warning");
		return false;
	}
	if(document.getElementById('phoneDuplicateCheck').value == ""){
		swal("핸드폰 번호 중복확인를 확인하세요.", "", "warning");
		return false;
	}
	
}
	

	function phoneDuplicate() {
		let phone = $("#phone").val();
		let curPhone = "${userVO.usrPhone }"
		if(!phoneCheck()){
			return false;
		}
		else if(phone != curPhone){
		$.ajax({
			url : '/login/phoneDuplicateCheck',
			type : 'POST',
			dataType : 'text', 
			contentType : 'text/plain; charset=utf-8;',
			data : phone,
			success : function(data) {
				if (data) {
					swal("이미 사용중인 핸드폰번호 입니다.", "", "warning");
				} else {
					swal("사용하실 수 있는 핸드폰번호입니다.", "", "success");
					document.getElementById('phoneDuplicateCheck').value = "phoneChecked"
				}
			},
			error : function() {
			}
			});
		}else{
			swal("현재 사용하시는 핸드폰번호입니다.", "", "success");
			document.getElementById('phoneDuplicateCheck').value = "phoneChecked"
		}
		
	}

	$(document)
			.ready(
					function() {

						let city = [ "시/도 선택", "서울특별시", "경기도" ];

						let seoul = [ "강남구", "강동구", "강북구", "강서구", "관악구", "광진구",
								"구로구", "금천구", "노원구", "도봉구", "동대문구", "동작구",
								"마포구", "서대문구", "서초구", "성동구", "성북구", "송파구",
								"양천구", "영등포구", "용산구", "은평구", "종로구", "중구", "중랑구" ];

						let gyeonggi = [ "고양시", "과천시", "광명시", "광주시", "구리시",
								"군포시", "김포시", "남양주시", "동두천시", "부천시", "성남시",
								"수원시", "시흥시", "안산시", "안성시", "안양시", "양주시",
								"여주시", "오산시", "용인시", "의왕시", "의정부시", "이천시",
								"파주시", "평택시", "포천시", "하남시", "화성시", "가평군",
								"양평군", "연천군" ];

						let category = ["관심분야선택", "아웃도어/여행", "문화/공연/축제", "운동/스포츠",
								"음악/악기", "외국/언어", "게임/오락", "기타" ];

						let usrCat1 = $("select[name=usrCategory1]");
						let usrCat2 = $("select[name=usrCategory2]");

						let usrCity1 = $("select[name=usrCity1]");
						let usrCity2 = $("select[name=usrCity2]");

						let usrDistrict1 = $("select[name=usrDistrict1]");
						let usrDistrict2 = $("select[name=usrDistrict2]");

						$(function() {
							let str = "";

							for (let i = 0; i < city.length; i++) {
								str += "<option value='"+city[i]+"'>" + city[i]
										+ "</option>"
							}
							usrCity1.append(str);

							str = "";

							if ('<c:out value="${userVO.usrCity1 }"/>' == "서울특별시") {
								for (let i = 0; i < seoul.length; i++) {
									str += "<option value='"+seoul[i]+"'>"
											+ seoul[i] + "</option>";
								}
								;
							}
							;
							if ('<c:out value="${userVO.usrCity1 }"/>' == "경기도") {
								for (let i = 0; i < gyeonggi.length; i++) {
									str += "<option value='"+gyeonggi[i]+"'>"
											+ gyeonggi[i] + "</option>";
								}
								;
							}
							;
							if ('<c:out value="${userVO.usrCity1 }"/>' == "시/도 선택") {
								str += "<option value='군/구 선택'>군/구 선택</option>";
							}
							;
							usrDistrict1.append(str);
							$(
									"select option[value='<c:out value="${userVO.usrCity1 }"/>']:first")
									.attr("selected", true);
							$(
									"select option[value='<c:out value="${userVO.usrDistrict1 }"/>']:first")
									.attr("selected", true);

						});
						$(function() {
							let str = "";

							for (let i = 0; i < city.length; i++) {
								str += "<option value='"+city[i]+"'>" + city[i]
										+ "</option>"
							}
							usrCity2.append(str);

							str = "";

							if ('<c:out value="${userVO.usrCity2 }"/>' == "서울특별시") {
								for (let i = 0; i < seoul.length; i++) {
									str += "<option value='"+seoul[i]+"'>"
											+ seoul[i] + "</option>";
								}
								;
							}
							;
							if ('<c:out value="${userVO.usrCity2 }"/>' == "경기도") {
								for (let i = 0; i < gyeonggi.length; i++) {
									str += "<option value='"+gyeonggi[i]+"'>"
											+ gyeonggi[i] + "</option>";
								}
								;
							}
							;
							if ('<c:out value="${userVO.usrCity2 }"/>' == "시/도 선택") {
								str += "<option value='군/구 선택'>군/구 선택</option>";
							}
							;

							usrDistrict2.append(str);
							$(
									"select option[value='<c:out value="${userVO.usrCity2 }"/>']:last")
									.attr("selected", true);
							$(
									"select option[value='<c:out value="${userVO.usrDistrict2 }"/>']:last")
									.attr("selected", true);

						});//

						$(function() {
							let str = "";

							for (let i = 0; i < category.length; i++) {
								str += "<option value='"+category[i]+"'>"
										+ category[i] + "</option>"
							}
							usrCat1.append(str);

							$(
									"select option[value='<c:out value="${userVO.usrCategory1 }"/>']:first")
									.attr("selected", true);

						});//

						$(function() {
							let str = "";

							for (let i = 0; i < category.length; i++) {
								str += "<option value='"+category[i]+"'>"
										+ category[i] + "</option>"
							}
							usrCat2.append(str);
							$(
									"select option[value='<c:out value="${userVO.usrCategory2 }"/>']:last")
									.attr("selected", true);

						});//

						$(function() {
							$('#city1').change(function() {
								region(this, $("#district1"));
							});

							$('#city2').change(function() {
								region(this, $("#district2"));
							});
						});//

						function region(o, d) {

							let district;
							let option;

							// change(function(){$( ':selected', o).val() => this }
							if ($(':selected', o).val() == "서울특별시") {
								district = seoul;
								d.empty();

								for (let i = 0; i < district.length; i++) {
									option = $("<option value=" + district[i] +">"
											+ district[i] + "</option>");
									d.append(option);
								}

							} else if ($(':selected', o).val() == "경기도") {
								district = gyeonggi;
								d.empty();

								for (let i = 0; i < district.length; i++) {
									option = $("<option value=" + district[i] +">"
											+ district[i] + "</option>");
									d.append(option);
								}

							} else if ($(':selected', o).val() == "시/도 선택") {
								d.empty();
								option = $("<option value='군/구 선택'>군/구 선택</option>");
								d.append(option);
							}
						} //

						$(function() {
							// 태그에 onchange를 부여한다.
							$('input[name=uploadFile]').change(function() {
								addPreview($(this)); //preview form 추가하기
								fileUpload();
							});
							// image preview 기능 구현
							// input = file object[]
							function addPreview(input) {

								var file = input[0].files[0];
								var reader = new FileReader();
								reader.onload = function(img) {
									//div id="preview" 내에 동적코드추가.
									//이 부분을 수정해서 이미지 링크 외 파일명, 사이즈 등의 부가설명을 할 수 있을 것이다.
									$("#preview").empty();
									$("#preview").append("<img style='width:100px;height: 120px;margin-bottom:5px;'src=\"" + img.target.result + "\"\/>");
									
									console.log(img.target.result);
								};

								reader.readAsDataURL(file);
							}

							var regex = new RegExp(
									"(.*?)\.(exe|sh|zip|alz|cell|pptx|doc|hwp)$");
							var maxSize = 5242880; //5MB
							var cloneObj = $(".uploadDiv").clone();
							var uploadBtn = $("#uploadBtn");

							function checkExtension(fileName, fileSize) {
								if (fileSize >= maxSize) {
									alert("파일 사이즈 초과");
									return false;
								}

								if (regex.test(fileName)) {
									alert("해당 종류의 파일은 업로드할 수 없습니다.");
									return false;
								}
								return true;
							}

							let fileUpload = function() {
								var formData = new FormData();
								var inputFile = $("input[name='uploadFile']");
								var files = inputFile[0].files[0];

								console.log(files);
								if (!checkExtension(files.name, files.size)) {
									return false;
								}

								formData.append("uploadFile", files);

								$.ajax({
									url : '/mypage/uploadFormAction',
									processData : false,
									contentType : false,
									data : formData,
									type : 'POST',
									dataType : 'json',
									success : function(result) {
										console.log(result);
										
										$("input[name=usrImg]").attr("value",result.uuid+'_'+result.fileName)
										$("input[name=usrImgPath]").attr("value",result.uploadPath);

									}
								});
							}

						});

					});
					var acc = document.getElementsByClassName("accordionBtn");
					var i;

					for (i = 0; i < acc.length; i++) {
					  acc[i].addEventListener("click", function() {
					    this.classList.toggle("active");
					    var panel = this.nextElementSibling;
					    if (panel.style.display === "block") {
					      panel.style.display = "none";
					    } else {
					      panel.style.display = "block";
					    }
					  });
					}
					
</script>
<%@include file="../includes/footer.jsp"%>
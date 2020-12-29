<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp"%>
<link rel="stylesheet" href="../resources/css/clubAddStyle.css">
<style>
#hashTagDiv ul {
	padding: 16px 0;
}

#hashTagDiv ul li {
	display: inline-block;
	margin: 3px 5px;
}

#hashTagDiv ul li.tag-item {
	padding: 4px 8px;
	background-color: orange;
	color: white;
}

#hashTagDiv .tag-item:hover {
	background-color: #262626;
	color: #fff;
}

#hashTagDiv .del-btn {
	font-size: 12px;
	font-weight: bold;
	cursor: pointer;
	margin-left: 8px;
}
</style>


<form role="form" id="formclubUpdate" action="/regular/update" method="post" enctype="multipart/form-data">

	<div id="reguform">
	
		<input type="hidden" id="cbNum" name="cbNum" value='<c:out value="${cbNum}" />'/>
		
		<span class="half">정기모임 수정</span>
		
		<p class="cate">모임명</p>
      	<div class="caja1">
        	<div class="lef1">
            	<div class="select_img">
            		<img class="thumbImg" src="${club.cbThumbImg}" style="margin: 0px;" /> <br>
					<!-- <label for="gdsImg" >이미지 선택</label> -->
					<input type="file" id="gdsImg" name="file" style="width: 200px;" />
					<!-- 사진 첨부 안했을 시 사용해야함 -->
					<input type='hidden' name='cbFile' value='<c:out value="${club.cbFile}"/>'>
					<input type='hidden' name='cbThumbImg' value='<c:out value="${club.cbThumbImg}"/>'>
          		</div>
          	</div>		
          	<div class="rig1">
				<input type="text" id="club" name="cbName" value='<c:out value="${club.cbName}"/>'><br>
				<input type="text" style="width:350px" id="info" name="cbIntro" value='<c:out value="${club.cbIntro}"/>'>
			</div>
      	</div>
		
		<p class="cate">카테고리</p>
      	<div class="caja2">
        	<div class="lef1">
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
					<option value="서울특별시" <c:if test="${club.cbCity eq '서울특별시'}">selected</c:if>>서울특별시</option>
					<option value="경기도" <c:if test="${club.cbCity eq '경기도'}">selected</c:if>>경기도</option>
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
				<input type="number" id="num" name="cbMbNum" min="1" max="200" value='<c:out value="${club.cbMbNum}"/>'>
			</div>
            <div class="rig1">
            	<p class="pil">*50명 이상은 포인트 결제가 필요합니다.</p>
          	</div>
         </div>
		
      	 
<!--       	 해시태그 업데이트 추가 (선우) -->
      	 <p class="cate">해시태그</p>
		<div class="caja2">
			<div id="hashTagDiv">
				<label for="cbHashtag" class="class">해시태그 </label>
				<input type="hidden" value="" name="cbHashtag" id="rdTag" value='<c:out value="${club.cbHashtag}"/>'>
				<input type="text" id="tag" size="7" value="#" />
				<ul id="tag-list"></ul>
			
				<input type="hidden" name="cbMakeDate">
				<!--개설일자는 sysdate로 설정 -->
							
			</div>
		</div>
		
		
	
		<p class="cate">모임상세내용</p>
      	 <div class="caja2">
         	<div class="lef1 detailinfo">
				<label for="cbDetailContent">상세내용</label>
				<textarea name="cbDetailContent" rows="10" cols="100" style="resize: none"><c:out value="${club.cbDetailContent}"/></textarea>
			</div>
      	 </div>
      	 
      	 <div id="regiform">
      	 	<button type="submit" data-oper='modify' class="btn btn-default">모임 수정하기</button>
			<button type="submit" data-oper='remove' class="btn btn-danger">모임 폐쇄하기</button>
			<button type="submit" data-oper='list' class="btn btn-info">List</button>
   	 	 </div>

	</div>
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
			
			
			//전송되기 전에 해시태그 값 넘기기 (선우)
			var value = marginTag(); // return array
			$("#rdTag").val(value);
			formObj.submit();
		});
	});
	
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
/* 	현재 프로젝트의 실제 경로를 표시합니다. 스프링 파일이 저장되는 워크스페이스와 다르므로, 파일을 저장할 때 실제 경로를 알아야합니다.  */
	<%-- <%=request.getRealPath("/")%> --%>
	
	
	
	
	
	
	
	
	
	
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
	$("#tag")
			.keyup(
					function(e) {
						let text = $(this).val();

						if (text.length == 0) {
							$(this).val("#");
						}
						//#은 제외
						var regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-+<>@\$%&\\\=\(\'\"]/gi;

						// test() ㅡ 찾는 문자열이 들어있는지 확인
						if (regExp.test(text)) {
							text = text.replace(regExp, ""); // 찾은 특수 문자를 제거													
						}
						$(this).val(text);
					});

	$("#tag")
			.on(
					"keypress",
					function(e) {

						var self = $(this);

						// input 에 focus 되있을 때 엔터 및 스페이스바 입력시 구동
						if (e.key === "Enter"
								|| e.keyCode == 32
								|| e.keyCode == 35) {

							if (maxHash >= 5) {
								alert("5개가 최대입니다.");
								self.val("#");
							} else {
								var tagValue = self.val(); // 값 가져오기

								//사용자가 갑자기 엔터같은걸 누르면 특수문자가 들어갈 수 있으므로 한번 더 써줌, #은 제외
								var regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-+<>@\$%&\\\=\(\'\"]/gi;

								// test() ㅡ 찾는 문자열이 들어있는지 확인
								if (regExp.test(tagValue)) {
									tagValue = tagValue
											.replace(
													regExp,
													""); // 찾은 특수 문자를 제거													
								}

								// 값이 없으면 동작 안함, '#'만 실수로 들어가도 동작 안함
								if (tagValue !== ""
										&& tagValue !== "#") {

									// 같은 태그가 있는지 검사한다. 있다면 해당값이 array 로 return 된다.
									var result = Object
											.values(tag)
											.filter(
													function(
															word) {
														return word === tagValue;
													})

									// 태그 중복 검사
									if (result.length == 0) {
										$("#tag-list")
												.append(
														"<li class='tag-item'>"
																+ tagValue
																+ "<span class='del-btn' idx='" + counter + "'>x</span></li>");
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

	
	//초기에 로딩이 되면 해시태그 데이터를 넣어준다! 
	let stringHash = '${club.cbHashtag}';
	let arrayHash = stringHash.split(',');
	for ( let i in arrayHash) {
		if (arrayHash[i] != "") {
			$("#tag-list")
					.append(
							"<li class='tag-item'>"
									+ arrayHash[i]
									+ "<span class='del-btn' idx='" + counter + "'>x</span></li>");
			addTag(arrayHash[i]);
		}
	}
</script>

<%@include file="../includes/footer.jsp"%>
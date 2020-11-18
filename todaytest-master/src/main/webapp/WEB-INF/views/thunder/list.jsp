
 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
    
<!-- 작성자 : 김선우 -->    



<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" type="text/css" href="../resources/style.css">
  <style>

.pagination {
	display: inline-block;
	padding-left: 0;
	margin: 20px 0;
	border-radius: 4px
}

.pagination>li {
	display: inline
}

.pagination>li>a, .pagination>li>span {
	position: relative;
	float: left;
	padding: 6px 12px;
	margin-left: -1px;
	line-height: 1.42857143;
	color: #337ab7;
	text-decoration: none;
	background-color: #fff;
	border: 1px solid #ddd
}

.pagination>li:first-child>a, .pagination>li:first-child>span {
	margin-left: 0;
	border-top-left-radius: 4px;
	border-bottom-left-radius: 4px
}

.pagination>li:last-child>a, .pagination>li:last-child>span {
	border-top-right-radius: 4px;
	border-bottom-right-radius: 4px
}

.pagination>li>a:focus, .pagination>li>a:hover, .pagination>li>span:focus,
	.pagination>li>span:hover {
	z-index: 2;
	color: #23527c;
	background-color: #eee;
	border-color: #ddd
}

.pagination>.active>a, .pagination>.active>a:focus, .pagination>.active>a:hover,
	.pagination>.active>span, .pagination>.active>span:focus, .pagination>.active>span:hover
	{
	z-index: 3;
	color: #fff;
	cursor: default;
	background-color: #337ab7;
	border-color: #337ab7
}

.pagination>.disabled>a, .pagination>.disabled>a:focus, .pagination>.disabled>a:hover,
	.pagination>.disabled>span, .pagination>.disabled>span:focus,
	.pagination>.disabled>span:hover {
	color: #777;
	cursor: not-allowed;
	background-color: #fff;
	border-color: #ddd
}

.pagination-lg>li>a, .pagination-lg>li>span {
	padding: 10px 16px;
	font-size: 18px;
	line-height: 1.3333333
}

.pagination-lg>li:first-child>a, .pagination-lg>li:first-child>span {
	border-top-left-radius: 6px;
	border-bottom-left-radius: 6px
}

.pagination-lg>li:last-child>a, .pagination-lg>li:last-child>span {
	border-top-right-radius: 6px;
	border-bottom-right-radius: 6px
}

.pagination-sm>li>a, .pagination-sm>li>span {
	padding: 5px 10px;
	font-size: 12px;
	line-height: 1.5
}

.pagination-sm>li:first-child>a, .pagination-sm>li:first-child>span {
	border-top-left-radius: 3px;
	border-bottom-left-radius: 3px
}

.pagination-sm>li:last-child>a, .pagination-sm>li:last-child>span {
	border-top-right-radius: 3px;
	border-bottom-right-radius: 3px
}
    
    .pull-right {
	float: right !important;
	margin-bottom : 30px;
}
    
    
   
    
  </style>
  <title>list</title>
</head>

<body>

  <!-- Masthead-->
  <header id=header>

    <a href="index.html">
      <img src="../resources/logo.png" alt="logo">
    </a>
    <input type="text" placeholder="관심취미를 입력해주세요.">
    <ul>
      <a href="">로그인</a>
      <a href="">고객센터</a>
    </ul>

    <!-- Navigation-->
    <nav id="nav">
      <ul>
        <a href="">三</a>
        <a href="">정기</a>
        <a href="">번개</a>
        <a href="">베스트</a>
        <a href="">추천</a>
        <a href="">모임개설</a>

      </ul>
    </nav>
  </header>





  <!--  번개 모임 개설 -->
  <section id="wrap" style="border:1px solid; margin-top : 30px; padding:30px;">
    <form action="/thunder/list" method="get">


      <div style="font-size:30px; margin-bottom:20px;"> <b>전체모임</b> </div>

      <!-- 상세검색창 -->
      <div style=" border:1px solid black; padding:20px; background-color: lightgray;">
        <div style="font-size:20px; margin:0px;"> 상세검색 </div>
        <div style="margin-top:20px;
			display: flex;
            justify-content: space-between ;">
          <select name='category' style="width:220px; height:40px; font-size:20px;">
            <option value=''
            <c:out  value="${pageMaker.cri.category eq ''?'selected':''}"/>>카테고리/분야</option>
            <option value="아웃도어/여행"
            <c:out value="${pageMaker.cri.category eq '아웃도어/여행'?'selected':''}"/>>아웃도어/여행</option>
            <option value="문화공연/축제"
            <c:out value="${pageMaker.cri.category eq '문화공연/축제'?'selected':''}"/>>문화공연/축제</option>
            <option value="운동/스포츠"
            <c:out value="${pageMaker.cri.category eq '운동/스포츠'?'selected':''}"/>>운동/스포츠</option>
            <option value="음악/악기"
            <c:out value="${pageMaker.cri.category eq '음악/악기'?'selected':''}"/>>음악/악기</option>
            <option value="외국/언어"
            <c:out value="${pageMaker.cri.category eq '외국/언어'?'selected':''}"/>>외국/언어</option>
            <option value="게임/오락"
            <c:out value="${pageMaker.cri.category eq '게임/오락'?'selected':''}"/>>게임/오락</option>
            <option value="기타"
            <c:out value="${pageMaker.cri.category eq '기타'?'selected':''}"/>>기타</option>
          </select>
          
          
          <select name='subclass' style="width:220px; height:40px; font-size:20px;">
            <option value=''
            <c:out  value="${pageMaker.cri.subclass == ''?'selected':''}"/>>소분류</option>
            <option value="자전거"
            <c:out  value="${pageMaker.cri.subclass == '자전거'?'selected':''}"/>>자전거</option>
            <option value="배드민턴"
            <c:out  value="${pageMaker.cri.subclass == '배드민턴'?'selected':''}"/>>배드민턴</option>
            <option value="볼링"
            <c:out  value="${pageMaker.cri.subclass == '볼링'?'selected':''}"/>>볼링</option>
            <option value="헬스/크로스핏"
            <c:out  value="${pageMaker.cri.subclass == '헬스/크로스핏'?'selected':''}"/>>헬스/크로스핏</option>
            <option value="탁구"
            <c:out  value="${pageMaker.cri.subclass == '탁구'?'selected':''}"/>>탁구</option>
            <option value="당구/포켓볼"
            <c:out  value="${pageMaker.cri.subclass == '당구/포켓볼'?'selected':''}"/>>당구/포켓볼</option>
            <option value="축구/풋살"
            <c:out  value="${pageMaker.cri.subclass == '축구/풋살'?'selected':''}"/>>축구/풋살</option>
            <option value="농구"
            <c:out  value="${pageMaker.cri.subclass == '농구'?'selected':''}"/>>농구</option>
            <option value="야구"
            <c:out  value="${pageMaker.cri.subclass == '야구'?'selected':''}"/>>야구</option>
            <option value="스케이트/인라인"
            <c:out  value="${pageMaker.cri.subclass == '스케이트/인라인'?'selected':''}"/>>스케이트/인라인</option>
            <option value="기타"
            <c:out  value="${pageMaker.cri.subclass == '기타'?'selected':''}"/>>기타</option>
          </select>


          <select name='city' style="width:220px; height:40px; font-size:20px;">
            <option value=''
            <c:out  value="${pageMaker.cri.city == ''?'selected':''}"/>>지역</option>
            <option value="서울특별시"
            <c:out  value="${pageMaker.cri.city == '서울특별시'?'selected':''}"/>>서울특별시</option>
            <option value="경기도"
            <c:out  value="${pageMaker.cri.city == '경기도'?'selected':''}"/>>경기도</option>
          </select>
          
          
          <select name='district' style="width:220px; height:40px; font-size:20px;">
            <option value=''
            <c:out  value="${pageMaker.cri.district == ''?'selected':''}"/>>세부지역</option>
            <option value="종로구"
            <c:out  value="${pageMaker.cri.district == '종로구'?'selected':''}"/>>종로구</option>
            <option value="중구"
            <c:out  value="${pageMaker.cri.district == '중구'?'selected':''}"/>>중구</option>
            <option value="용산구"
            <c:out  value="${pageMaker.cri.district == '용산구'?'selected':''}"/>>용산구</option>
            <option value="성동구"
            <c:out  value="${pageMaker.cri.district == '성동구'?'selected':''}"/>>성동구</option>
            <option value="광진구"
            <c:out  value="${pageMaker.cri.district == '광진구'?'selected':''}"/>>광진구</option>
            <option value="동대문구"
            <c:out  value="${pageMaker.cri.district == '동대문구'?'selected':''}"/>>동대문구</option>
            <option value="중랑구"
            <c:out  value="${pageMaker.cri.district == '중랑구'?'selected':''}"/>>중랑구</option>
            <option value="성북구"
            <c:out  value="${pageMaker.cri.district == '성북구'?'selected':''}"/>>성북구</option>
            <option value="강북구"
            <c:out  value="${pageMaker.cri.district == '강북구'?'selected':''}"/>>강북구</option>
            <option value="도봉구"
            <c:out  value="${pageMaker.cri.district == '도봉구'?'selected':''}"/>>도봉구</option>
          </select>
          
        </div>       

        <div>

        <div>
            <input type="text" name='keyword' style="width:600px; height:30px; font-size:20px;"
			value='<c:out value="${pageMaker.cri.keyword}"/>'/>
                    
            <button style="width:100px; height:35px;"> 검색 </button>
          </div>
        </div>      
      </div>




      <div style=" padding:20px; ">
        <div style="font-size:20px; margin:0px;"> 최신순 인기순 마감임박순 </div>
        <div style="margin-top:20px; display: flex; justify-content: space-between ;">
        
        
        
        <c:forEach items="${list}" var="thunderItem">						
						<div style="border:1px solid black; width:170px; height:140px; cursor: pointer;" 
						
						class='move' onclick='move2(${thunderItem.cbNum})'> 						
							
							[모임명] : <c:out value="${thunderItem.cbName}" /> <br>
							
							[일 정] : <c:out value="${thunderItem.cbMakeDate}" /> <br>
							  														  
							[장 소] : <c:out value="${thunderItem.cbDistrict}" /> <br>
							
							[인 원] : <c:out value="${thunderItem.cbCurMbnum}" /> /							
							         <c:out value="${thunderItem.cbMbnum}" />																																							
							</div>
		</c:forEach>										        
        </div>
    </form>
    
        <div class='pull-right'>
				<ul class="pagination">
					<c:if test="${pageMaker.prev}">
						<li class="paginate_button previous">
						<a href="${pageMaker.startPage-1}">Previous</a></li>
					</c:if>

					<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
						<li class="paginate_button ${pageMaker.cri.pageNum==num ? "active":""} ">
							<a href="${num}">${num}</a>
						</li>
					</c:forEach>

					<c:if test="${pageMaker.next}">
						<li class="paginate_button next"><a
							href="${pageMaker.endPage+1}"> Next</a></li>
					</c:if>

				</ul>
			</div>
      
     	 <form id='actionForm' action="/thunder/list" method='get'>
			<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
			<input type='hidden' name='amount' value='${pageMaker.cri.amount}'>
			
			<input type='hidden' name='category' value='<c:out value="${pageMaker.cri.category}"/>'>
			<input type='hidden' name='subclass' value='<c:out value="${pageMaker.cri.subclass}"/>'>
			<input type='hidden' name='city' value='<c:out value="${pageMaker.cri.city}"/>'>
			<input type='hidden' name='district' value='<c:out value="${pageMaker.cri.district}"/>'>
			<input type='hidden' name='keyword' value='<c:out value="${pageMaker.cri.keyword}"/>'>
		</form>

  </section>

    <!-- jQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script type="text/javascript">
	$(document).ready(
					function() {
						console.log("???????");
						/* JS BODY */
						/* var result = '<c:out value="${result}"/>';
						checkModal(result);

						history.replaceState({}, null, null);

						function checkModal(result) {
							if (result === '' || history.state) {
								return;
							}

							if (parseInt(result) > 0) {
								$(".modal-body").html(
										"게시글 " + parseInt(result)
												+ " 번이 등록되었습니다.");
							}

							$("#myModal").modal("show");
						} */

						
						//버튼을 눌렀을 때 동작 정의
						/* $("#regBtn").on("click", function() {
							self.location = "/thunder/register";
						});*/

						
						actionForm = $("#actionForm"); 
						
						$(".paginate_button a").on(
								"click",
								function(e) {
									e.preventDefault();
									console.log('click');
									actionForm.find("input[name='pageNum']")
											.val($(this).attr("href"));
									actionForm.submit(); 
								});

									
						
										
				/* 	var searchForm = $("#searchForm");
						$("#searchForm button").on("click", function(e){ 
							if(!searchForm.find("option:selected").val()){
								alert("검색종류를 선택하세요");
								return false;
							}
							
							if(!searchForm.find("input[name='keyword']").val()){
								alert("키워드를 입력하세요");
								return false;
							}
							
							searchForm.find("input[name='pageNum']").val("1");
							e.preventDefault();
							
							searchForm.submit();							
						}); */
					});
	
	
	// onclick 속성을 가져올 수 없어서, 꼼수로 함수를 사용.
	function move2(cbNum) {		
		actionForm
		.append("<input type='hidden' name='cbNum' value='"
				+ cbNum + "'>");		
		actionForm.attr("action",
				"/thunder/info");
		actionForm.submit();										
	}
	
	
	
</script>

<%@include file="../includes/footer.jsp"%>





    
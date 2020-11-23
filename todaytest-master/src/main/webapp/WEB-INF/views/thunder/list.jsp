
 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
    
<!-- 작성자 : 김선우 -->    

<%@include file="../includes/header.jsp"%>
<link rel="stylesheet" type="text/css" href="/resources/css/thunder.css">



  <!--  번개 모임 개설 -->
  <section id="wrap" style="border:1px solid; margin-top : 30px; padding:30px;">
    <form action="/thunder/list" method="get" onsubmit="return inputCheck()">


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
                    
            <button style="width:100px; height:35px;" > 검색 </button>
          </div>
        </div>      
      </div>




      <div style=" padding:20px; ">
        <div style="font-size:20px; margin:0px;"> 최신순 인기순 마감임박순 </div>
        <div style="margin-top:20px; display: flex; justify-content: space-between ;">
        
        
        
        <c:forEach items="${list}" var="thunderItem">						
						<div style="border:1px solid black; width:170px; height:140px; cursor: pointer;" 
						
						class='move' onclick='move2(${thunderItem.cbNum})'> 																
							
							${thunderItem.thunderDetailVO}
							
							[모임명] : <c:out value="${thunderItem.cbName}" /> <br>
							
							[일 정] : <c:out value="${thunderItem.thunderDetailVO.cbDate}" /> <br>
							  														  
							[장 소] : <c:out value="${thunderItem.cbDistrict}" /> <br>
							
							[인 원] : <c:out value="${thunderItem.cbCurMbnum}" /> /							
							         <c:out value="${thunderItem.cbMbnum}" />																																							
							</div>
		</c:forEach>										        
        </div>
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
						/* JS BODY */
						
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

					});
	
	
					// onclick 속성을 가져올 수 없어서,함수를 사용.
					function move2(cbNum) {		
						actionForm
						.append("<input type='hidden' name='cbNum' value='"
								+ cbNum + "'>");		
						actionForm.attr("action",
								"/thunder/info");
						actionForm.submit();										
					}
					
					
					function inputCheck(){										
									
						let keyword = $("[name=keyword]").val();
						
						console.log(keyword.length);
						if (keyword.length > 30) {
							alert("키워드가 너무 깁니다 (30자 이하)");
							return false;
							}					    
					    }
	
</script>

<%@include file="../includes/footer.jsp"%>





    
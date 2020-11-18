
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

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
  <title>modify</title>
</head>

<body>


<!-- Masthead-->
    <header id=header>

      <a href="index.html">
        <img src="/resources/logo.png" alt="logo">
      </a>
        <input type="text"placeholder="관심취미를 입력해주세요.">
        <ul>
            <a href="">로그인</a>
            <a href="">고객센터</a>
        </ul>

<!-- Navigation-->
        <nav id="nav">
            <ul>
                <a href="">三</a>
                <a href="">정기</a>
                <a href="/thunder/info">번개</a>
                <a href="">베스트</a>
                <a href="">추천</a>
                <a href="/thunder/add">모임개설</a>

            </ul>
        </nav>
      </header>


    <!--  번개 모임 개설 -->
    <section id="wrap">
          <form role="form" action="/thunder/modify" method="post">

          <div>
                <div>
                  모임명<br>
                  <input type="text" name='cbName' value='<c:out value="${clubVO.cbName}" />' >
                </div>
                <div>
                  모임소개<br>
                  <input type="text" name='cbIntro' value='<c:out value="${clubVO.cbIntro}" />'>                                    
                </div>
          </div>


          <div style="float:left; margin-right:50px">            
                <div style="margin:2px 0px">
                  <img src="/resources/img/thunderImg.png" width="110" height="110" alt="번개대표사진">
                </div>
                <br>

                  <button type="button" > 사진변경 </button>

          </div>


          <div>
                <div>
                  모임 날짜<br>
                  <input type="datetime-local" name='thunderDetailVO.cbDate'
                  value='<c:out value="${clubVO.thunderDetailVO.cbDate}" />'>
                </div>
                <div>
                <!-- 분야 문제가 해결이 안됨!!!!!!!!!!!!!!!!!! -->
                  카테고리/분야<br>
                  <select name="cbCategory">
                    <option value="운동/스포츠" selected> 운동/스포츠
                    <option value="음악/악기"> 음악/악기
                    <option value="문화/공연/축제"> 문화/공연/축제
                    <option value="아웃도어/여행"> 아웃도어/여행
                  </select>
                </div>

                <div>
                  모임<br>
                  <select name="cbSubcat">
                    <option value="농구" selected> 농구
                      <option value="축구" > 축구
                    <option value="야구" > 야구
                    <option value="테니스"> 테니스
                  </select>
                </div>
          </div>


          <div>
                <div>
                  모집 인원<br>
                  <input type="number" name='cbMbnum'
                  value='<c:out value="${clubVO.cbMbnum}"/>'>
                </div>
              
                <div>
                  모집 신청기간<br>
                <input type="datetime-local" name='thunderDetailVO.cbAppPeriod'
                value='<c:out value="${clubVO.thunderDetailVO.cbAppPeriod}" />'>
                </div>

                <div>
                  해시태그<br>
                  <input type="text" name='cbHashtag'
                  value='<c:out value="${clubVO.cbHashtag}" />'>
                </div>
          </div>


          <div>
                <div>
                  지역 <br>
                  <select name="cbCity">
                    <option value="서울특별시" selected> 서울특별시
                    <option value="경기도"> 경기도
                  </select>
                </div>
                <div>
                  세부지역<br>
                  <select name="cbDistrict">
                    <option value="종로구" selected> 종로구
                    <option value="중구"> 중구
                    <option value="용산구"> 용산구
                    <option value="성동구"> 성동구
                  </select>
                </div>
          </div>

          <div>
                <div>
                  모임 장소 <br>
                  <input type="text"  name='thunderDetailVO.cbPlace'
                  value='<c:out
						value="${clubVO.thunderDetailVO.cbPlace}" />'>
                </div>

                <div>
                  모임 준비물<br>
                  <input type="text"  name='thunderDetailVO.cbSupplies'
                  value='<c:out value="${clubVO.thunderDetailVO.cbSupplies}" />'>
                </div>
          </div>
          <div style="margin-left: 470px">
                    <button type="submit" data-oper='modify' class="btn btn-default">                                                      
          Modify</button>
          
          <button type="submit" data-oper='remove' class="btn btn-danger">
          Remove</button>
          
          <button type="submit" data-oper='list' class="btn btn-info">
          List </button>            
		  </div>	
          
							<input type='hidden' id='cbNum' name='cbNum' value='<c:out value="${clubVO.cbNum}"/>'>
                           	<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum}"/>'>
                           	<input type='hidden' name='amount' value='<c:out value="${cri.amount}"/>'>
                           	
							<input type='hidden' name='category' value='<c:out value="${cri.category}"/>'>
							<input type='hidden' name='subclass' value='<c:out value="${cri.subclass}"/>'>
							<input type='hidden' name='city' value='<c:out value="${cri.city}"/>'>
							<input type='hidden' name='district' value='<c:out value="${cri.district}"/>'>                           	                           	                           	
                           	<input type='hidden' name='keyword' value='<c:out value="${cri.keyword}"/>'>
                </form>
    </section>
                             
          
          <%-- <div class="form-group">
          	<label>RegDate</label>
          	<input class="form-control" name='regDate' value='<fmt:formatDate pattern = "yyyy/MM/dd" value="${board.regdate}" />' 
          	readonly = "readonly">
          </div>
          
          <div class="form-group">
          	<label>Update Date</label>
          	<input class="form-control" name='updateDate' value='<fmt:formatDate pattern = "yyyy/MM/dd" value="${board.updateDate}" />' 
          	readonly = "readonly">
          </div>
           --%>
                                                                       
                        
    <!-- jQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script type="text/javascript">
            
               $(document).ready(function() {
            		
            		var formObj = $("form");
            		
            		$('button').on("click", function(e){
            			e.preventDefault();
            			
            			var operation = $(this).data("oper");
            			
            			console.log(operation);
            			
            			if(operation === 'remove') {
            				formObj.attr("action", "/thunder/remove"); 
            				
            			}else if (operation === 'list') {
            				//move to list
            				formObj.attr("action", "/thunder/list").attr("method", "get");
            				
            				var pageNumTag = $("input[name='pageNum']").clone();
            				var amountTag = $("input[name = 'amount']").clone();            				            				
            				
            				var categoryTag = $("input[name = 'category']").clone();
            				var subclassTag = $("input[name = 'subclass']").clone();
            				var cityTag = $("input[name = 'city']").clone();
            				var districtTag = $("input[name = 'district']").clone();
            				var keywordTag = $("input[name = 'keyword']").clone();
            				
            				formObj.empty();
            				
            				formObj.append(pageNumTag);
            				formObj.append(amountTag);            				
            				
            				formObj.append(categoryTag);
            				formObj.append(subclassTag);
            				formObj.append(cityTag);
            				formObj.append(districtTag);
            				formObj.append(keywordTag);            				
            			}
            			formObj.submit();            			        		
            			});
            		});
     </script>               

       
      
	<%@include file="../includes/footer.jsp"%>
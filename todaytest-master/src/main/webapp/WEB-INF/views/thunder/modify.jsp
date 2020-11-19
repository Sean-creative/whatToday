
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!-- 작성자 : 김선우 -->    
 <%@include file="../includes/header.jsp"%>
 <link rel="stylesheet" type="text/css" href="/resources/css/thunder.css">

    <!--  번개 모임 개설 -->
    <section id="wrap">
          <form role="form" action="/thunder/modify" method="post"
          name="modify" onsubmit="return inputCheck()">

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
                  <input type="datetime-local" name='thunderDetailVO.cbDate' id=cbDate
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
                  모임 인원<br>
                  <input type="number" name='cbMbnum'
                  value='<c:out value="${clubVO.cbMbnum}"/>'>
                </div>
              
                <div>
                  모임 신청기간<br>
                <input type="datetime-local" name='thunderDetailVO.cbAppPeriod' id=cbAppPeriod
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
                  <input type="text"  name='thunderDetailVO.cbPlace' id=cbPlace
                  value='<c:out
						value="${clubVO.thunderDetailVO.cbPlace}" />'>
                </div>

                <div>
                  모임 준비물<br>
                  <input type="text"  name='thunderDetailVO.cbSupplies' id=cbSupplies
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
    <script src="http://code.jquery.com/jquery-3.3.1.js"></script>
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
               
               
               
               
               
               
               function inputCheck(){
               	var clubname = document.modify.cbName;
               	var intro = document.modify.cbIntro;
               	
               	var date = $('#cbDate').val();
               	
               	var category = document.modify.cbCategory;
               	var subcat = document.modify.cbSubcat;
               	var mbnum = document.modify.cbMbnum;
               	var appPeriod = $('#cbAppPeriod').val();  
               	var hashtag = document.modify.cbHashtag;
               	var city = document.modify.cbCity;
               	var district = document.modify.cbDistrict;
               	var place = $('#cbPlace').val(); 
               	var supplies = $('#cbSupplies').val();  
               	
             	
               	
               	if(!clubname.value || clubname.value.length>30){
               		alert("모임명을 다시 입력해주세요.");
               		return false;
               	}
               	    	
               	if(!intro.value || intro.value.length>30){
               		alert("모임소개를 다시 입력해주세요.");
               		return false;
               	}
               	if(!date ){
               		alert("모임날짜를 입력해주세요.");
               		return false;
               	}
               	
               	if(!category.value ){
               		alert("카테고리를 입력해주세요.");
               		return false;
               	}
               	
               	if(!subcat.value ){
               		alert("모임을 다시 입력해주세요.");
               		return false;
               	}
               	
               	if(!mbnum.value || mbnum.value < 0){
               		alert("모임인원을 다시 입력해주세요.");
               		return false;
               	}
               	
               	if(!appPeriod){
               		alert("모임 신청기간 다시 입력해주세요.");
               		return false;
               	}
               	
               	if(!hashtag.value || hashtag.value.length>30){
               		alert("해시태그를 다시 입력해주세요.");
               		return false;
               	}
               	
               	if(!city.value){
               		alert("지역을  입력해주세요.");
               		return false;
               	}
               	
               	if(!district.value){
               		alert("세부지역을  입력해주세요.");
               		return false;
               	}
               	
               	if(!place || place.length>30){
               		alert("모임장소를 다시 입력해주세요.");
               		return false;
               	}
               	
               	if(!supplies || supplies.length>30){
               		alert("모임 준비물을 다시 입력해주세요.");
               		return false;
               	}
               	
            
               	alert('수정되었습니다.');
               	
               	
               }
               
                                                            
     </script>               

       
      
	<%@include file="../includes/footer.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
 <!-- 작성자 : 김선우 -->

<%@include file="../includes/header.jsp"%>
 

    <!--  번개 모임 개설 -->
    <section id="wrap">
          <form action="/thunder/add" method="post" name="add" onsubmit="return inputCheck()">

          <div>
                <div>
                  모임명<br>
                  <!-- 30자 제한 -->
                  <input type="text" name='cbName' size="50">
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
                  <!-- date 타입을 비동기적으로(실시간으로) 계속 찍어줘야 할듯
					ex) 1분차이로 현재의 시간이 과거가 될 수 도 있다. -->
					<!-- JS로 MIN과 MAX를 찍어주자 -->
                  <input type="datetime-local" name='thunderDetailVO.cbDate' id=cbDate
                  >
                </div>
                <div>
                  카테고리/분야<br>
                  <select name="cbCategory" id=category></select>
                </div>

                <div>
                  모임<br>
                  <select name="cbSubcat" id="subcat">
                    <option value="모임 선택" selected> 모임 선택                   
                  </select>
                </div>
          </div>


          <div>
                <div>
                  모임 인원<br>
                  <input type="number" name='cbMbnum' min="1" max="1000000">
                </div>
              
                <div>
                  모임 마감기간<br>
                <input type="datetime-local" name='thunderDetailVO.cbAppPeriod' id=cbAppPeriod>
                </div>

                <div>
                  해시태그<br>
                  <input type="text" name='cbHashtag'>
                </div>
          </div>


          <div>
                <div>
                  지역 <br>
                  <select name="cbCity" id="city">
                  <option value="지역 선택" >지역 선택</option>                  
                  <option value="서울특별시" >서울특별시</option>                  
                  <option value="경기도" >경기도</option>                  
                  </select>
                </div>
                <div>
                  세부지역<br>
                  <select name="cbDistrict" id="district">
                  <option value="세부지역 선택">세부지역 선택</option> 
                  </select>
                </div>
          </div>

          <div>
                <div>
                  모임 장소 <br>
                  <input type="text"  name='thunderDetailVO.cbPlace' id=cbPlace>
                </div>

                <div>
                  모임 준비물<br>
                  <input type="text"  name='thunderDetailVO.cbSupplies' id=cbSupplies size="50">
                </div>
          </div>
          
                   <div>
                  모임소개<br>
                  <!-- 300자 제한 -->
                  <textarea  name='cbIntro' cols="100" rows="7" maxlength="300"></textarea>                                 
                </div>
                
          <div style="margin-left: 470px">
                  <button type="submit" >번개만들기</button>     
                <button type="reset" onclick="alert('리셋되었습니다.')">
		      리셋 하기 </button>
		  </div>
	
                </form>
                
                                
    </section>
    <script src="http://code.jquery.com/jquery-3.3.1.js"></script>    
    
    <!-- 렌더링을 거의 마치고 JS를 해석 할 것  -->
    <script type="text/javascript" src="/resources/js/thunderAdd.js"></script>


<%@include file="../includes/footer.jsp"%>
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
                  <input type="text" name='cbName'>
                </div>
                <div>
                  모임소개<br>
                  <input type="text" name='cbIntro'>                                    
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
                  <input type="datetime-local" name='thunderDetailVO.cbDate' id=cbDate>
                </div>
                <div>
                  카테고리/분야<br>
                  <select name="cbCategory" id=category></select>
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
                  <input type="number" name='cbMbnum'>
                </div>
              
                <div>
                  모임 신청기간<br>
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
                  </select>
                </div>
                <div>
                  세부지역<br>
                  <select name="cbDistrict" id="district">
                  <option value="세부지역 선택">세부지역 선택</option> </select>
                </div>
          </div>

          <div>
                <div>
                  모임 장소 <br>
                  <input type="text"  name='thunderDetailVO.cbPlace' id=cbPlace>
                </div>

                <div>
                  모임 준비물<br>
                  <input type="text"  name='thunderDetailVO.cbSupplies' id=cbSupplies>
                </div>
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
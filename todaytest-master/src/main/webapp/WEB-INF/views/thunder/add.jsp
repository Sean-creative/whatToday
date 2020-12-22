<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- 작성자 : 김선우 -->

<%@include file="../includes/header.jsp"%>
<link rel="stylesheet" type="text/css" href="/resources/css/thunderAdd.css">
<link rel="stylesheet" type="text/css" href="/resources/css/kakaoMap.css">





  <section>
    <div id="container">


      <div class="section_header" style="margin: 0 auto;">
        <h2>번개 모임 개설</h2>
        <p>간단하게 어떤 모임인지 알려주세요</p>
      </div>


      <!-- ========왼쪽========== -->
      <div class="header_in3">
        <ul class="header_weekday">
        </ul>
      </div>




    

      <!-- ========중앙========== -->
      <div class="section_in" style="display : inline-block; overflow:hidden">
        <form action="/thunder/add" method="post" id="tag-form" enctype="multipart/form-data">
          <h6 class="form-stxt">*필수 입력사항&nbsp;&nbsp;</h6>
          <hr>
          <fieldset class="formContent">

            <div>
              <!-- 30자 제한 -->
              <label for="name" style="display:block;">모임명*</label>
              <input type="text" required="required" name='cbName' size="50">
            </div>


            <div>
              <div style="display:inline-block; width:300px;">
                <!-- date 타입을 비동기적으로(실시간으로) 계속 찍어줘야 할듯
  					ex) 1분차이로 현재의 시간이 과거가 될 수 도 있다. -->
                <!-- JS로 MIN과 MAX를 찍어주자 -->
                <label for="hp">모임 날짜*</label>
                <input type="datetime-local" required="required" name='thunderDetailVO.cbDate' id='cbDate'>
              </div>


              <div style="display:inline-block; width:300px;">
                <label for="request" class="class">모임 마감기간*</label>
                <input type="datetime-local" required="required" name='thunderDetailVO.cbAppPeriod' id='cbAppPeriod'>
              </div>
            </div>


            <div>
              <div style="display:inline-block; width:300px;">
                <label for="email">카테고리/분야*</label>
                <select name="cbCategory" required="required" id='category'></select>
              </div>


              <div style="display:inline-block; width:300px;">
                <label for="location">모임</label>
                <select name="cbSubcat" required="required" id="subcat">
                  <option value="모임 선택" selected>모임 선택
                </select>
              </div>
            </div>


            <div class="request">
              <label for="request" class="class" style="display:block;">모임 인원*</label>
              <input type="number" required="required" name='cbMbnum' min="1" max="1000000">
            </div>



            <div>
              <div style="display:inline-block; width:300px;">
                <label for="request" class="class">모임 지역*</label>
                <input type="text" required="required" readonly="readonly" name='thunderDetailVO.cbAddress' id='cbAddress'>
              </div>



              <div style="display:inline-block; width:300px;">
                <label for="request" class="class">모임 장소 *</label>
                <input type="text" required="required" readonly="readonly" name='thunderDetailVO.cbPlace' id='cbPlace'>
              </div>
            </div>


            <div class="request">
              <label for="request" class="class" style="display:block;">해시태그</label>
              <input type="hidden" value="" name="cbHashtag" id="rdTag" />
              <input type="text" id="tag" size="7" value="#" />
              <ul id="tag-list"></ul>
            </div>







            <div class="request">
              <label for="request" class="class" style="display:block;">모임 준비물</label>
              <input type="text" name='thunderDetailVO.cbSupplies' id='cbSupplies' size="50">
            </div>



            <div class="request">
              <label for="request" class="class" style="display:block;">모임소개</label>
              <textarea name='cbIntro' cols="100" rows="7" maxlength="300"></textarea>

            </div>




            <div class="request">
              <label for="request" class="class">썸네일 등록</label>
              <div class="select_img">
                <img class="thumbImg" src="logo.png" /> <br>
                <input type="file" id="gdsImg" name="file" />
              </div>
            </div>
          </fieldset>


          <hr>
          <fieldset class="agreebox">

            <div class="btn_faq">
              <button type="submit" class="btn_faq2">번개만들기</button>
              <button type="reset" onclick="alert('리셋되었습니다.')" class="btn_faq2">리셋 하기</button>
            </div>
          </fieldset>




          <!-- 지역 이름 정도만 컨트롤러에 보낸다. -->
          <input type='hidden' name='cbCity'>
          <input type='hidden' name='cbDistrict'>

          <input type='hidden' name='thunderDetailVO.cbLatitude' id='cbLatitude'>
          <input type='hidden' name='thunderDetailVO.cbLongitude' id='cbLongitude'>
        </form>




      </div>
      <!-- 중앙 끝  -->





       <!-- ========오른쪽========== -->
      <div style="display : inline-block; background-color : red; width:250px; height:1300px; ">

        <!-- 카카오 맵 영역 -->
        <div class="map_wrap">
        <div id="map"></div>
        <div id="menu_wrap" class="bg_white">
          <div class="option">
            <div>
              <form role="form" onsubmit="searchPlaces(); return false;">
                모임 장소 :
                <input type="text" value="종각역" id="keyword" size="15">
                <button type="submit">검색하기</button>
              </form>
            </div>
          </div>
          <hr>
          <ul id="placesList"></ul>
          <div id="pagination"></div>
        </div>
      </div>
        <!-- 카카오 맵 END -->
      </div>





    </div>
    <!-- 컨테이너 END -->
  </section>










<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- services와 clusterer, drawing 라이브러리 불러오기 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e19ea28cff4b871b68b2fabda7855cab&libraries=services,clusterer,drawing"></script>

<script type="text/javascript" src="/resources/js/kakaoMap.js"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>

<!-- 렌더링을 거의 마치고 JS를 해석 할 것  -->
<script type="text/javascript" src="/resources/js/thunderAdd.js"></script>

<%@include file="../includes/footer.jsp"%>


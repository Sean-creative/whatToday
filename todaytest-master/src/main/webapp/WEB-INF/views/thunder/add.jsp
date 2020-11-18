<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <!-- 작성자 : 김선우 -->

<%@include file="../includes/header.jsp"%>
 

    <!--  번개 모임 개설 -->
    <section id="wrap">
          <form action="/thunder/add" method="post">

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
                  <input type="datetime-local" name='thunderDetailVO.cbDate'>
                </div>
                <div>
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
                  <input type="number" name='cbMbnum'>
                </div>
              
                <div>
                  모집 신청기간<br>
                <input type="datetime-local" name='thunderDetailVO.cbAppPeriod'>
                </div>

                <div>
                  해시태그<br>
                  <input type="text" name='cbHashtag'>
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
                  <input type="text"  name='thunderDetailVO.cbPlace'>
                </div>

                <div>
                  모임 준비물<br>
                  <input type="text"  name='thunderDetailVO.cbSupplies'>
                </div>
          </div>
          <div style="margin-left: 470px">
                <button type="submit" onclick="alert('번개모임이 개설되었습니다.')">
                    번개 만들기 </button>
                <button type="reset" onclick="alert('리셋되었습니다.')">
		      리셋 하기 </button>
		  </div>
	
                </form>
    </section>

<%@include file="../includes/footer.jsp"%>


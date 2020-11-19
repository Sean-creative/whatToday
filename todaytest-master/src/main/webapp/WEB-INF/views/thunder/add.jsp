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
                    <option value="서울특별시" selected> 서울특별시
                    <option value="경기도"> 경기도
                  </select>
                </div>
                <div>
                  세부지역<br>
                  <select name="cbDistrict" id="district">
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
    <script>
    
    function inputCheck(){
    	var clubname = document.add.cbName;
    	var intro = document.add.cbIntro;
    	
    	var date = $('#cbDate').val();
    	
    	var category = document.add.cbCategory;
    	var subcat = document.add.cbSubcat;
    	var mbnum = document.add.cbMbnum;
    	var appPeriod = $('#cbAppPeriod').val();  
    	var hashtag = document.add.cbHashtag;
    	var city = document.add.cbCity;
    	var district = document.add.cbDistrict;
    	var place = $('#cbPlace').val(); 
    	var supplies = $('#cbSupplies').val();  
    	
  		console.log(mbnum.value);
    	
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
    	
 
    	alert('개설되었습니다.');
    	
    	
    }
    
                                  
    </script>
    

<%@include file="../includes/footer.jsp"%>


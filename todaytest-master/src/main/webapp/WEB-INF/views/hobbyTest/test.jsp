<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp"%>
<!-- 취미테스트_하드 코딩 버전 -->
<!DOCTYPE html>
<html>
<style>

#test{
    height:115vh;
    display: flex;
    justify-content: center;
    align-items: center;
}

.testbx{
    width: 950px;
    height: 700px;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
    text-align:center;  
    position: relative;
}

#testQuestions{
	margin : 125px;	
}
/* Hide all steps by default: */
.question {
  display: none;
  font-size: 20px;
}

.result {
  display: none;
}

#regularResult{
    display:flex;
    justify-content:space-evenly;
}

#thunderResult{
    display:flex;
    justify-content:space-evenly;
}

.testReuslt1{
    width:150px;
    height:150px;
    background-size: cover;
    border-radius: 50%;
}

.testReuslt2{
    width:150px;
    height:150px;
    background-size: cover;
    border-radius: 50%;
}

.testReuslt3{
    width:150px;
    height:150px;
    background-size: cover;
    border-radius: 50%;
}

#nextBtn{
position: absolute;
transform: translate(-50%, -50%);
right: 2px;
top: 350px;
}

#prevBtn{
float: left;
position: absolute;
transform: translate(50%, 50%);
left: 2px;
bottom: 350px;

}


/* Make circles that indicate the steps of the form: */
.step {
  height: 15px;
  width: 15px;
  margin: 0 2px;
  background-color: #ffaf31;
  border: none;  
  border-radius: 50%;
  display: inline-block;
  opacity: 0.5;
}

.step.active {
  opacity: 1;
}

/* Mark the steps that are finished and valid: */
.step.finish {
  background-color: #4CAF50;
}

</style>
<body>
<div id ="test">
	<div class="testbx">
		 <div id = "testQuestions">
		  <h1>취미 분석 테스트</h1><br>
		  <h3>당신의 취미를 찾아드립니다.</h3><br><br><br>
		  <!-- One "tab" for each step in the form: -->
		  
		  <div class="question">1. 당신은 사람들과 어울려 노는 것을 좋아하십니까? 
		  	<br><br><br>
		    <input type="radio" name="userResult1" value="Y" >YES
		    <input type="radio" name="userResult1" value="N" >NO
		  </div>
		  
		  <div class="question">2.당신은 야외에서 활동하는 것을 좋아하십니까? 
		  	<br><br><br>
		    <input type="radio" name="userResult2" value="Y" >YES
		    <input type="radio" name="userResult2" value="N" >NO
		  </div>
		  
		  <div class="question">3. 당신은 새로운 도전을 즐겨 하십니까? 
		  	<br><br><br>
		    <input type="radio" name="userResult3" value="Y" >YES
		    <input type="radio" name="userResult3" value="N" >NO
		  </div>
		  
		  <!-- 결과에 반영X -->
		  <div class="question">4. 당신은 계획적인 사람 입니까?
		  	<br><br><br>
		    <input type="radio" name="userResult4" value="Y" >YES
		    <input type="radio" name="userResult4" value="N" >NO
		  </div>
		  
		  <div class="result">
		  		<div id="regularResult">
					<div>
						<div class="testReuslt1" id="testReuslt1"></div>
						<p id="result1"></p>
					</div>
	
					<div>
						<div class="testReuslt2" id="testReuslt2"></div>
						<p id="result2"></p>
					</div>
					
					<div>
						<div class="testReuslt3"  id="testReuslt3"></div>
						<p id="result3""></p>
					</div>
				</div>
				<br><br><br>
				<div id="thunderResult">
					<div>
						<div class="testReuslt1" id="testReuslt4"></div>
						<p id="result4"></p>
					</div>
	
					<div>
						<div class="testReuslt2" id="testReuslt5"></div>
						<p id="result5"></p>
					</div>
					
					<div>
						<div class="testReuslt3" id="testReuslt6"></div>
						<p id="result6"></p>
					</div>
					
				</div>
		  </div>
		  
		  
		     
		    
	
		  
		  <!-- Circles which indicates the steps of the form: -->
		  <div id="steps" style="text-align:center;margin-top:40px;">
		    <span class="step"></span>
		    <span class="step"></span>
		    <span class="step"></span>
		    <span class="step"></span>
		  </div>
		 
		  
		  </div><!-- END <div id = "testQuestions"> -->
			<div id="prevBtn">
		     	<img src="/resources/img/back.png" width="50px" height="50px" onclick="nextPrev(-1)">
		     </div>
		    <div id="nextBtn">
		      <img src="/resources/img/next.png" width="50px" height="50px"  onclick="nextPrev(1)">
		    </div>
</div>
</div>
<script>
var currentTab = 0; // Current tab is set to be the first tab (0)
console.log(currentTab);
showTab(currentTab); // Display the current tab

function showTab(n) {
  var x = document.getElementsByClassName("question");
  x[n].style.display = "block";
  if (n == 0) {
    document.getElementById("prevBtn").style.display = "none";
  } 
  else {
	  document.getElementById("prevBtn").style.display = "inline";
  }
  fixStepIndicator(n);
  
}

function nextPrev(n) {
  var x = document.getElementsByClassName("question");
  x[currentTab].style.display = "none";
  var y = document.getElementsByClassName("result");
  currentTab = currentTab + n;
  if (currentTab == x.length) {
	  document.getElementById("prevBtn").style.display = "none";
	  document.getElementById("nextBtn").style.display = "none";
	  document.getElementById("steps").style.display = "none";
	  y[0].style.display = "block";
	  testResult();
	  return false;
  }
  showTab(currentTab);
}

function fixStepIndicator(n) {
	  var i, x = document.getElementsByClassName("step");
	  for (i = 0; i < x.length; i++) {
	    x[i].className = x[i].className.replace(" active", "");
	  }
	  x[n].className += " active";
	}
</script>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">

function testResult() {

	let test1 = document.getElementsByName('userResult1');
	let test2 = document.getElementsByName('userResult2');
	let test3 = document.getElementsByName('userResult3');
	
	var test1Result;
	var test2Result;
	var test3Result;
	
	if(test1[0].checked == true){
		test1Result = test1[0].value;
	}else
		test1Result = test1[1].value;

	if(test2[0].checked == true){
		test2Result = test2[0].value;
	}else
		test2Result = test2[1].value;
	
	if(test3[0].checked == true){
		test3Result = test3[0].value;
	}else
		test3Result = test3[1].value;
	
	let testResult = { "test1Result" : test1Result, "test2Result" : test2Result, "test3Result" : test3Result};
	console.log(testResult);

	$.ajax({
	    url: '/hobbyTest/testResult',
	    type: 'POST',  
	    dataType: 'json',  //서버로부터 내가 받는 데이터의 타입  
	    contentType : 'application/json; charset=utf-8;',//내가 서버로 보내는 데이터의 타입
	    data: JSON.stringify(testResult),
	    success: function(data){
	    	console.log("data: " + data);
	    	
	    	let r1Sub = data[0].subclass;
	    	let r1Cat = data[0].category;
	    	
	    	let r2Sub = data[1].subclass;
	    	let r2Cat = data[1].category;
	    	
	    	let r3Sub = data[2].subclass;
	    	let r3Cat = data[2].category;
	    	
	    	let tr1 = document.getElementById("testReuslt1");
	    	let r1 = document.getElementById("result1");
	    	
	    	let tr2 = document.getElementById("testReuslt2");
	    	let r2 = document.getElementById("result2");
	    	
	    	let tr3 = document.getElementById("testReuslt3");
	    	let r3 = document.getElementById("result3");
	    	
	    	let tr4 = document.getElementById("testReuslt4");
	    	let r4 = document.getElementById("result4");
	    	
	    	let tr5 = document.getElementById("testReuslt5");
	    	let r5 = document.getElementById("result5");
	    	
	    	let tr6 = document.getElementById("testReuslt6");
	    	let r6 = document.getElementById("result6");
	   
	    	showImageRegular(tr1, r1, r1Sub, r1Cat);
	    	showImageRegular(tr2, r2, r2Sub, r2Cat);
	    	showImageRegular(tr3, r3, r3Sub, r3Cat);
	    	
	    	showImageThunder(tr4, r4, r1Sub, r1Cat);
	    	showImageThunder(tr5, r5, r2Sub, r2Cat);
	    	showImageThunder(tr6, r6, r3Sub, r3Cat);
	
	    	
	    },
	    error: function (){        
	                      
	    }
	  });
	
	
	function showImageRegular(tr, r, sub, cat){
		resultImg(sub);
    	tr.style.backgroundImage = "url('" + img + "')";
    	tr.setAttribute('OnClick',"location.href='http://localhost:8088/regular/list?category=" + sub + "&subclass=" + cat + "'");
    	r.innerHTML=sub;
	}
	
	function showImageThunder(tr, r, sub, cat){
		resultImg(sub);
    	tr.style.backgroundImage = "url('" + img + "')";
    	tr.setAttribute('OnClick',"location.href='http://localhost:8088/thunder/list?category=" + sub + "&subclass=" + cat + "'");
    	r.innerHTML=sub;
	}
	
	function resultImg(sub){
		switch (sub) {
		case "등산":
			img = "/resources/img/subclass/hiking.jpg";
			break;
		case "산책/트래킹":
			img = "/resources/img/subclass/tracking.jpg";
			break;
		case "캠핑/백패킹":
			img ="/resources/img/subclass/camping.jpg";
			break;
		case "낚시":
			img = "/resources/img/subclass/fishing.jpg";
			break;
			
		case "뮤지컬/오페라":
			img = "/resources/img/subclass/musical.jpg";
			break;
		case "공연/연극":
			img = "/resources/img/subclass/performance.jpg";
			break;
		case "전시회":
			img = "/resources/img/subclass/exhibition.jpg";
			break;
		case "파티/페스티벌":
			img = "/resources/img/subclass/festival.jpg";
			break;
			
		case "자전거":
			img = "/resources/img/subclass/bicycle.jpg";
			break;
		case "배드민턴":
			img = "/resources/img/subclass/badminton.jpg";
			break;
		case "볼링":
			img = "/resources/img/subclass/bowling.jpg";
			break;
		case "헬스/크로스핏":
			img = "/resources/img/subclass/fitness.jpg";
			break;
		case "탁구":
			img = "/resources/img/subclass/pingpong.jpg";
			break;
		case "당구/포켓볼":
			img = "/resources/img/subclass/pocketball.jpg";
			break;
		case "축구/풋살":
			img = "/resources/img/subclass/soccer.jpg";
			break;
		case "농구":
			img = "/resources/img/subclass/basketball.jpg";
			break;
		case "야구":
			img = "/resources/img/subclass/baseball.jpg";
			break;
		case "스케이트/인라인":
			img = "/resources/img/subclass/skate.jpg";
			break;
			
		case "노래/보컬":
			img = "/resources/img/subclass/sing.jpg";
			break;
		case "기타/베이스":
			img = "/resources/img/subclass/guitar.jpg";
			break;
		case "피아노":
			img = "/resources/img/subclass/piano.jpg";
			break;
		case "랩/힙합/DJ":
			img = "/resources/img/subclass/hiphop.jpg";
			break;
		case "클래식":
			img = "/resources/img/subclass/classic.jpg";
			break;
			
		case "영어":
			img = "/resources/img/subclass/english.jpg";
			break;
		case "일본어":
			img = "/resources/img/subclass/japanese.jpg";
			break;
		case "중국어":
			img = "/resources/img/subclass/chinese.jpg";
			break;
		case "프랑스어":
			img = "/resources/img/subclass/french.jpg";
			break;
		case "스페인어":
			img = "/resources/img/subclass/spanish.jpg";
			break;
		case "러시아어":
			img = "/resources/img/subclass/russia.jpg";
			break;
			
		case "다트":
			img = "/resources/img/subclass/dart.jpg";
			break;
		case "보드게임":
			img = "/resources/img/subclass/boardGame.jpg";
			break;
		case "온라인게임":
			img = "/resources/img/subclass/onlineGame.jpg";
			break;
		case "마술":
			img = "/resources/img/subclass/magic.jpg";
			break;
		case "바둑":
			img = "/resources/img/subclass/goGame.jpg";
			break;
			
		default:
			break;
		}
	}
}


</script>
</body>
</html>
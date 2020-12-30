<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="/resources/css/hobbyTest/testBackImg.css">
	<link rel="stylesheet" href="/resources/css/hobbyTest/testSlides.css">
    <title>취미 분석 테스트</title>
</head>
<body>
<div class="bg-image"></div>
<div class="bg-text">

<div class="slideshow-container">
    <h1>취미 분석 테스트</h1>
    <p>당신의 취미를 찾아드립니다.</p><br><br>
    <form id="testUserResult" method="get" action="/hobbyTest/testResultAction">
    <div class="mySlides fade">
        <div class="question"><h2>1. 당신은 사람들과 어울려 노는 것을 좋아하십니까?</h2>
        <br><br>
        <label for="selectYes1"> YES</label><input type="radio" id ="selectYes1" name="userResult1" value="Y" onclick="plusSlides(1);">
        <label for="selectNo1"> NO</label><input type="radio" id ="selectNo1" name="userResult1" value="N" onclick="plusSlides(1);">
        <br><br><br>
        </div>
    </div>
    
    <div class="mySlides fade">
        <div class="question"><h2>2.당신은 야외에서 활동하는 것을 좋아하십니까? </h2>
        <br><br>
        <label for="selectYes2"> YES</label><input type="radio" id ="selectYes2" name="userResult2" value="Y" onclick="plusSlides(1);">
        <label for="selectNo2"> NO</label><input type="radio" id ="selectNo2" name="userResult2" value="N" onclick="plusSlides(1);">
        <br><br><br>
        </div>
    </div>
    
    <div class="mySlides fade">
        <div class="question"><h2>3. 당신은 새로운 도전을 즐겨 하십니까? </h2>
        <br><br>
        <label for="selectYes3"> YES</label><input type="radio" id ="selectYes3" name="userResult3" value="Y" onclick="plusSlides(1);">
        <label for="selectNo3"> NO</label><input type="radio" id ="selectNo3" name="userResult3" value="N" onclick="plusSlides(1);">
        <br><br><br>
        </div>
    </div>

    <div class="mySlides fade">
        <div class="question"><h2>4. 당신은 계획적인 사람 입니까?</h2>
        <br><br>
        <label for="selectYes4"> YES</label><input type="radio" id ="selectYes4" name="userResult4" value="Y" onclick="plusSlides(1);">
        <label for="selectNo4"> NO</label><input type="radio" id ="selectNo4" name="userResult4" value="N" onclick="plusSlides(1);">
        <br><br><br>
        </div>
    </div>
    </form>

    
    </div>
    <br><br>
    
    <div style="text-align:center">
      <span class="dot" onclick="currentSlide(1)"></span> 
      <span class="dot" onclick="currentSlide(2)"></span> 
      <span class="dot" onclick="currentSlide(3)"></span> 
      <span class="dot" onclick="currentSlide(4)"></span> 
    </div>
    <br>

</div>
</body>


<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
    var slideIndex = 1;
    showSlides(slideIndex);
    
    function plusSlides(n) {
      showSlides(slideIndex += n);
    }
    
    function currentSlide(n) {
    	checkedValue(n);
      	showSlides(slideIndex = n);
    }
    
    function showSlides(n) {
      var i;
      var slides = document.getElementsByClassName("mySlides");
      var dots = document.getElementsByClassName("dot");
      if (n > slides.length) {
    	  document.getElementById('testUserResult').submit();
   	  }
      if (n < 1) {slideIndex = slides.length}
      for (i = 0; i < slides.length; i++) {
          slides[i].style.display = "none";  
      }
      for (i = 0; i < dots.length; i++) {
          dots[i].className = dots[i].className.replace(" active", "");
      }
      slides[slideIndex-1].style.display = "block";  
      dots[slideIndex-1].className += " active";
     
    }
    
   function checkedValue(n){
	  let selectYes = document.getElementById("selectYes"+n);
 	  let selectNo = document.getElementById("selectNo"+n); 
	  let userResult = document.getElementsByName("userResult"+n); 
		  if(selectYes.checked == true){
			  console.log("yes");
			  userResult = userResult[0].value;
		  }
		  if(selectNo.checked == true){
			  console.log("no");
			  userResult = userResult[1].value;
		  }
   }
</script>
</html>

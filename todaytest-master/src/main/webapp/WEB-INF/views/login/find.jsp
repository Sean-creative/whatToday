<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>
<!-- 작성자: 김지영 -->
<!DOCTYPE html>
<html>
<head>
<script src="http://code.jquery.com/jquery-3.3.1.js"></script>
<link rel="stylesheet" href="/resources/css/findStyle.css">
</head>
<body>

<div class="leftcolumn">
  <p>아이디 찾기</p>
  <div class="input-container">
  	<label> 이름 </label>
    <input class="input-field" type="text" placeholder="Username" id="name" name="usrName">
  </div>

  <div class="input-container">
    <label>휴대전화 번호  </label>
    <input class="input-field" type="text" placeholder="Phonenumber"  id="phone" name="usrPhone">
  </div>

  <p id="resultId"></p>

  <button class="btn" type="button" onclick="checkId();"> 확인</button>

  </div>
  
<div class="rightcolumn">
  <p>비밀번호 찾기</p>
  <div class="input-container">
  	<label>이메일(아이디) </label>
    <input class="input-field" type="text" placeholder="Email" id="email" name="usrId">
  </div>

  <p id="resultPwd"></p>

  <button class="btn" type="button" onclick="checkPwd();"> 확인</button>
</div>



<script type="text/javascript">
function checkId(){
	name = $("#name").val();
	phone = $("#phone").val();
	
	var send = {"name" : name , "phone": phone};
	
	$.ajax({
	    url: 'find_id',
	    type: 'POST',  
	    dataType: 'text', //서버로부터 내가 받는 데이터의 타입
	    contentType : 'application/json; charset=utf-8;',//내가 서버로 보내는 데이터의 타입
	    data: JSON.stringify(send),
	    success: function(data){
	         if(data==-1){
	        	 document.getElementById('resultId').innerHTML = "<p class='answer'>아이디를 찾을 수 없습니다.</p>";
	         }else{
	        	 document.getElementById('resultId').innerHTML = "<p class='answer'>아이디는 " + data + "입니다.</p>";
	         }
	    },
	    error: function (){        
	                      
	    }
	  });
}
</script>


<script type="text/javascript">
function checkPwd(){
	email = $("#email").val();
	
	$.ajax({
	    url: 'find_pwd',
	    type: 'POST',  
	    dataType: 'text', //서버로부터 내가 받는 데이터의 타입
	    contentType : 'text/plain; charset=utf-8;',//내가 서버로 보내는 데이터의 타입
	    data: email,
	    
	    success: function(data){
	         if(data==-1){
	        	 document.getElementById('resultPwd').innerHTML = "<p class='answer'>비밀번호를 찾을 수 없습니다.</p>";
	         }else{
	        	 document.getElementById('resultPwd').innerHTML = "<p class='answer'>비밀번호는 " + data + "입니다.</p>";
	         }
	    },
	    error: function (){        
	                      
	    }
	  });
}
</script>
</body>
</html>
<%@ include file="../includes/footer.jsp"%>
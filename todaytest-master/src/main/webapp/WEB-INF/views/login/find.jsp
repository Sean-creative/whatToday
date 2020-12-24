<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../includes/slimHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/resources/css/memberFind.css">
    <title>아이디/비밀번호찾기</title>
</head>
<body>
    <div id="todofind">
        <div id="centro">
            <div class="lef1">
                <p class="idpwd">가입 시 입력한 정보로 아이디를 찾아보세요.</p>
                <div>
                    <input type="text" placeholder="이름을 입력해주세요." id="name" name="usrName">
                </div>
                <div>
                    <input type="text" placeholder="휴대폰 번호 입력" id="phone" name="usrPhone">
                </div>
                <p id="resultId"></p>
                <div>
                    <button class="btn" type="button" onclick="checkId();"> 확인</button>
                </div>

                <div id="membership">
                    <p>아직 회원이 아니세요?</p>
                    <p><a href="">회원가입 > </a></p>
                </div>
            </div>

            <div class="rig1">
                <p class="idpwd">가입 시 입력한 정보로 비밀번호를 찾아보세요.</p>
                <div>
                    <input type="email" placeholder="이메일을 입력해주세요." id="email" name="usrId">
                </div>
                <p id="resultPwd"></p>
				<div>
  					<button class="btn" type="button" onclick="checkPwd();"> 확인</button>
                </div>

                <div id="membership">
                    <p>아직 회원이 아니세요?</p>
                    <p><a href="">회원가입 > </a></p>
                </div>

            </div>
        </div>
    </div>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script type="text/javascript">
function checkId(){
	let name = $("#name").val();
	let phone = $("#phone").val();

	
	// 이름 : 한글만 2~4글자
	const namePattern = /^[가-힣]{2,4}$/;
	// 핸드폰 번호 : 010-1234-1234
	const phonePattern = /^\d{3}\d{3,4}\d{4}$/;
	
	if(!name){
        alert("이름을 입력하세요.");
        return false;
    }
	
	if(namePattern.test(name) == false){
		alert("한글만 2~4글자");
		return false;
	}
	
	if(!phone){
        alert("핸드폰번호를 입력하세요.");
        return false;
    }
	
	if(phonePattern.test(phone) == false){
	    	alert("핸드폰 번호 : 01012341234");
	    	return false;
	}
	
	
	let send = {"name" : name , "phone": phone};
	
	$.ajax({
	    url: 'find_id',
	    type: 'POST',  
	    dataType: 'text', //서버로부터 내가 받는 데이터의 타입
	    contentType : 'application/json; charset=utf-8;',//내가 서버로 보내는 데이터의 타입
	    data: JSON.stringify(send),
	    success: function(data){
	         if(data){
	        	 document.getElementById('resultId').innerHTML = "아이디는 <span id='answer'>" + data + "</span>입니다.";
	         }else{
	        	 document.getElementById('resultId').innerHTML = "<span id='answer'>아이디를 찾을 수 없습니다.</span>";
	         }
	    },
	    error: function (){        
	                      
	    }
	  });
}

function checkPwd(){
	email = $("#email").val();
	
	if(!email){
        alert("이메일을 입력하세요.");
        return false;
    }
	
	$.ajax({
	    url: 'find_pwd',
	    type: 'POST',  
	    dataType: 'text', //서버로부터 내가 받는 데이터의 타입
	    contentType : 'text/plain; charset=utf-8;',//내가 서버로 보내는 데이터의 타입
	    data: email,
	    
	    success: function(data){
	    	 console.log("data: " + data);
	         if(data==1){
	        	 document.getElementById('resultPwd').innerHTML = "<p class='answer'>비밀번호를 메일로 발송하였습니다.</p>";
	         }else if(data==0){
	        	 document.getElementById('resultPwd').innerHTML = "<p class='answer'>비밀번호를 찾을 수 없습니다.</p>";
	         }else{
	        	 document.getElementById('resultPwd').innerHTML = "<p class='answer'>비밀번호를 받으실 메일 주소를 다시 입력해주세요</p>";
	         }
	    },
	    error: function (){        
	                      
	    }
	  });
}
</script>
</body>
</html>
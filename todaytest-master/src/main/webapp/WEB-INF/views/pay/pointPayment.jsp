<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 카카오 포인트 결제 페이지 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
</head>
<body>
	<div>
		<p>포인트 결제하기</p>
    	<p>현재포인트 </p>
		<label>
			<input type="radio" name="cp_item" value="10000"><span>10,000원</span></label>
		<p  style="color: #ac2925; margin-top: 30px">50명이상 모임개설 10,000포인트</p>
        <button type="button" id="charge_point">결 제 하 기</button>
 </div>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<!-- ### 포인트 결 제 창 ### -->
<script>
    	$('#charge_point').click(function () {
		let money = $('input[name="cp_item"]:checked').val();
    		 $.ajax({
                url: "/pay/point", 
             	type: 'POST',  
         	    dataType: 'text', //서버로부터 내가 받는 데이터의 타입
         	    contentType : 'text/plain; charset=utf-8;',//내가 서버로 보내는 데이터의 타입
                data: money,
                success: function(){ 
                	window.close(); 
                },
    		 	error: function (){ }
             });
    		
        });
</script>
</body>
</html>
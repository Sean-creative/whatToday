<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 포인트 결제 페이지 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
</head>
<body>
 <div class="card-body bg-white mt-0 shadow">
                <p style="font-weight: bold">카카오페이 현재 사용가능</p>
                <label class="box-radio-input"><input type="radio" name="cp_item" value="5000"><span>5,000원</span></label>
                <label class="box-radio-input"><input type="radio" name="cp_item" value="50000"><span>50,000원</span></label>
                <p  style="color: #ac2925; margin-top: 30px">카카오페이의 최소 충전금액은 5,000원이며 <br/>최대 충전금액은 50,000원 입니다.</p>
                <button type="button" class="btn btn-lg btn-block  btn-custom" id="charge_kakao">충 전 하 기</button>
 </div>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<!-- ### T E S T ### -->
<script>
    	$('#charge_kakao').click(function () {
		let money = $('input[name="cp_item"]:checked').val();
    		 $.ajax({
                url: "/pay/complete", //충전 금액값을 보낼 url 설정
             	type: 'POST',  
         	    dataType: 'text', //서버로부터 내가 받는 데이터의 타입
         	    contentType : 'text/plain; charset=utf-8;',//내가 서버로 보내는 데이터의 타입
                data: money
             });
        });
    
</script>
</body>
</html>
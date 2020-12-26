<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 포인트 결제 페이지 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카카오 페이 결제</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<link rel="stylesheet" href="/resources/css/kakaoPayPayment.css">
</head>
<body>
<div id="kakaoPaybox">
<div id="imgBanner">
    <a href="/index/main"> <img src="/resources/img/logo.png" alt="logo"width="80px"></a>
</div>
<div>
    <p id="myPointHist">내 포인트 내역 > </p>
    <div id="myPoint"> ${userPoint }p </div>
    <div class="bar"></div><br>

    <p id="chargeTitle">충전금액 선택</p>
</div>

<div id = "chargeBox">
    <table>
        <thead>
            <tr>
                <th>충전금액</th>
                <th>수수료</th>
                <th>총 결제금액</th>
            </tr>
        </thead>
            <tr>
                <td class="point"><label class="box-radio-input"><input type="radio" name="cp_item" value="5000"><span>5,000원</span></label></td>
                <td>부가세10% , 결제처리수수료 10%</td>
                <td>6,000원</td>
            </tr>

            <tr>
                <td class="point"><label class="box-radio-input"><input type="radio" name="cp_item" value="10000"><span>10,000원</span></label></td>
                <td>부가세10% , 결제처리수수료 10%</td>
                <td>12,000원</td>
            </tr>

            <tr>
                <td class="point"><label class="box-radio-input"><input type="radio" name="cp_item" value="20000"><span>20,000원</span></label></td>
                <td>부가세10% , 결제처리수수료 10%</td>
                <td>24,000원</td>
            </tr>

            <tr>
                <td class="point"><label class="box-radio-input"><input type="radio" name="cp_item" value="30000"><span>30,000원</span></label></td>
                <td>부가세10% , 결제처리수수료 10%</td>
                <td>36,000원</td>
            </tr>

            <tr>
                <td class="point"><label class="box-radio-input"><input type="radio" name="cp_item" value="40000"><span>40,000원</span></label></td>
                <td>부가세10% , 결제처리수수료 10%</td>
                <td>48,000원</td>
            </tr>

            <tr>
                <td class="point"><label class="box-radio-input"><input type="radio" name="cp_item" value="50000"><span>50,000원</span></label></td>
                <td>부가세10% , 결제처리수수료 10%</td>
                <td>60,000원</td>
            </tr>
    </table>
    <div id="payBtn">
        <button type="button" id="kakaopayCharge">카카오페이 결제</button>
    </div>
</div>


<div id = warnTitle>
    <p id="warnLetter">유의사항</p>
    <ul>
        <li>포인트 적립 및 사용처의 변경은 사전 고지 없이 내부 사정에 따라 변경될 수 있습니다.</li>
        <li>포인트의 유효기간은 포인트 지급 경로에 따라 다를 수 있습니다.</li>
        <li>한번 사용하신 포인트에 대해서는 철회가 불가능합니다.</li>
        <li>계정 정보 이전 시에 포인트 이전은 불가능합니다.</li>
    </ul>
</div>
</div>

<script>
    $('#kakaopayCharge').click(function () {
        // getter
        var IMP = window.IMP;
        IMP.init('imp27258746');
        var money = $('input[name="cp_item"]:checked').val();
        console.log(money);

        IMP.request_pay({
            pg: 'kakao',
            merchant_uid: 'merchant_' + new Date().getTime(),

            name: '오늘 뭐하지 포인트 결제',
            amount: money,
            buyer_email: 'iamport@siot.do',
            buyer_name: '사용자',
            buyer_tel: '010-1234-5678',
            buyer_addr: '서울시 종로구',
            buyer_postcode: '123-456'
        }, function (rsp) {
            console.log(rsp);
            if (rsp.success) {
                var msg = '결제가 완료되었습니다.';
                msg += '고유ID : ' + rsp.imp_uid;
                msg += '상점 거래ID : ' + rsp.merchant_uid;
                msg += '결제 금액 : ' + rsp.paid_amount;
                msg += '카드 승인번호 : ' + rsp.apply_num;
                $.ajax({
                    url: "/pay/complete", //충전 금액값을 보낼 url 설정
                	type: 'POST',  
            	    dataType: 'text', //서버로부터 내가 받는 데이터의 타입
            	    contentType : 'text/plain; charset=utf-8;',//내가 서버로 보내는 데이터의 타입
            	    data: money,
                    success: function(){ 
                    	window.close(); 
                    },
        		 	error: function (){ }
                });
            } else {
                var msg = '결제에 실패하였습니다.';
                msg += '에러내용 : ' + rsp.error_msg;
            }
            alert(msg);
            //document.location.href="/user/mypage/home"; //alert창 확인 후 이동할 url 설정
        });
    });
</script>
</body>
</html>
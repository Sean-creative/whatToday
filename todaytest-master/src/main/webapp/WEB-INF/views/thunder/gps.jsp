<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Just GPS</title>
</head>
<body>
    
    <form action="/thunder/list" id="gpsForm" method="get">    
    	<input type="hidden" name="userLatitude" >    
    	<input type="hidden" name="userLongitude">
    	
    	
    	<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum}"/>'>
    	<input type='hidden' name='amount' value='<c:out value="${cri.amount}"/>'>    	    
    	
    	<input type='hidden' name='category' value='<c:out value="${cri.category}"/>'>
    	<input type='hidden' name='subclass' value='<c:out value="${cri.subclass}"/>'>
    	<input type='hidden' name='city' value='<c:out value="${cri.city}"/>'>
    	<input type='hidden' name='district' value='<c:out value="${cri.district}"/>'>
    	
    	
    	<input type='hidden' name='searchBy' value='<c:out value="${cri.searchBy}"/>'>
    	<input type='hidden' name='keyword' value='<c:out value="${cri.keyword}"/>'>
    	<input type='hidden' name='orderBy' value='<c:out value="${cri.orderBy}"/>'>
		
		  	    
    </form>
    
    
    
    
    
    <!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script>
    /**
     * 비동기적으로 현재 위치를 알아내어 지정된 요소에 출력한다.
     */
    function whereami() {
        // 이 객체를 getCurrentPosition() 메서드의 세번째 인자로 전달한다.
        var options = {
            // 가능한 경우, 높은 정확도의 위치(예를 들어, GPS 등) 를 읽어오려면 true로 설정
            // 그러나 이 기능은 배터리 지속 시간에 영향을 미친다.
            enableHighAccuracy: true, // 대략적인 값이라도 상관 없음: 기본값

            // 위치 정보가 충분히 캐시되었으면, 이 프로퍼티를 설정하자,
            // 위치 정보를 강제로 재확인하기 위해 사용하기도 하는 이 값의 기본 값은 0이다.
            maximumAge: 30000,     // 5분이 지나기 전까지는 수정되지 않아도 됨

            // 위치 정보를 받기 위해 얼마나 오랫동안 대기할 것인가?
            // 기본값은 Infinity이므로 getCurrentPosition()은 무한정 대기한다.
            timeout: 15000    // 15초 이상 기다리지 않는다.
        }

        if(navigator.geolocation) // geolocation 을 지원한다면 위치를 요청한다.
            navigator.geolocation.getCurrentPosition(success, error, options);
        else
            // elt.innerHTML = "이 브라우저에서는 Geolocation이 지원되지 않습니다.";

        // geolocation 요청이 실패하면 이 함수를 호출한다.
        function error(e) {
            // 오류 객체에는 수치 코드와 텍스트 메시지가 존재한다.
            // 코드 값은 다음과 같다.
            // 1: 사용자가 위치 정보를 공유 권한을 제공하지 않음.
            // 2: 브라우저가 위치를 가져올 수 없음.
            // 3: 타임아웃이 발생됨.
            // elt.innerHTML = "Geolocation 오류 "+e.code +": " + e.message;
        }


        // geolocation 요청이 성공하면 이 함수가 호출된다.
        function success(pos) {

            console.log(pos); // [디버깅] Position 객체 내용 확인

            // 항상 가져올 수 있는 필드들이다. timestamp는 coords 객체 내부에 있지 않고,
            // 외부에서 가져오는 필드라는 점에 주의하다.
            var msg = "당신은 " +
                new Date(pos.timestamp).toLocaleString() + "에 " +
                " 위도 " + pos.coords.latitude +
                " 경도 " + pos.coords.longitude + "에서 "+
                " 약 " + pos.coords.accuracy + " 미터 떨어진 곳에 있습니다.";

                latitude = pos.coords.latitude;
                longitude = pos.coords.longitude;
                
                console.log(latitude, longitude);
                
                $("input[name='userLatitude']").val(latitude);
                $("input[name='userLongitude']").val(longitude);
                
                console.log(msg);
            // elt.innerHTML = msg;     // 모든 위치 정보를 출력한다.
        }
    }
    whereami();
    let formObj = $("#gpsForm");
    
    setTimeout(function() {
    	formObj.submit();	  
    	}, 2000);

           
    </script>
</body>
</html>

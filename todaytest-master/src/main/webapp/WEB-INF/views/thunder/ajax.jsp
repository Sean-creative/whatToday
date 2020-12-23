<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Just GPS</title>



<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
	function test() {
		$.ajax({
			url : "ajax_result02",
			type : "GET",
			success:function(data) {
				$("#result").text(data);
				console.log("성공")
				},
			error:function() {console.log("실패")}
		})		
	}
	
	
	timerId = setInterval(test, 3000);
	console.log(timerId);

	


</script>
</head>
<body>

	zzzzzzzzz
    <button onclick="test()"> 클릭 </button>
    <label id="result">0</label>
    
     

</body>
</html>

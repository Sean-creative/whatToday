<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 취미테스트_하드 코딩 버전 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h1>1. 당신은 사람들과 어울려 노는 것을 좋아하십니까?</h1>
	<input type="radio" name="test1" value="Y">YES
	<input type="radio" name="test1" value="N">NO

	<h1>2.당신은 야외에서 활동하는 것을 좋아하십니까?</h1>
	<input type="radio" name="test2" value="Y">YES
	<input type="radio" name="test2" value="N">NO

	<h1>3.당신은 새로운 도전을 즐겨 하십니까?</h1>
	<input type="radio" name="test3" value="Y">YES
	<input type="radio" name="test3" value="N">NO


	<button type="submit" class="btn" onclick="testResult();">결과</button>

	<p id="result"></p>

	<script src="http://code.jquery.com/jquery-3.3.1.js"></script>
	<script type="text/javascript">
function testResult() {
	
	
	let test1 = document.getElementsByName('test1');
	let test2 = document.getElementsByName('test2');
	let test3 = document.getElementsByName('test3');
	
	let test1Result;
	let test2Result;
	let test3Result;
	
	
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
	    url: 'testResult',
	    type: 'POST',  
	    dataType: 'json',  //서버로부터 내가 받는 데이터의 타입  
	    contentType : 'application/json; charset=utf-8;',//내가 서버로 보내는 데이터의 타입
	    data: JSON.stringify(testResult),
	    success: function(data){
	    	console.log("data: " + data);
	    	console.log(data);
	    	$.each(data, function(key, value){
	    		console.log("category: " + value.category);
	    		console.log("subclass: " + value.subclass);
	    		
	    		//localhost:8080/regular/list?category=아웃도어/여행&subclass=산책/트래킹
	    		let str = document.createElement("a");
	    		let br = document.createElement("br");
	    		str.setAttribute("href", `http://localhost:8080/regular/list?category=\${value.category}&subclass=\${value.subclass}`);
	    		str.innerText = value.subclass;

	    		let result  = document.getElementById('result');
	    		result.appendChild(str);
	    		result.appendChild(br);

	    		
	    	});
	    },
	    error: function (){        
	                      
	    }
	  });
}

</script>
</body>
</html>
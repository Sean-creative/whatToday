<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
    <!-- multiple attr 가 없다면 단일 이미지만 선택한다. -->
<div class='uploadDiv'>
	<input type='file' id="uploadBtn" name='uploadFile' accept="image/jpeg, image/jpg, image/png">
</div>
 
    <!-- 해당 위치 안에 이미지가 쌓이게 된다. -->
    <div id="preview">
    </div>
</body>
<script src="https://code.jquery.com/jquery-3.5.1.min.js" integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>

<script type="text/javascript">
$(document).ready(
		
	    function() {
	        // 태그에 onchange를 부여한다.
	        $('input[name=uploadFile]').change(function() {
	                addPreview($(this)); //preview form 추가하기
	               	fileUpload();
	    	});
	    // image preview 기능 구현
	    // input = file object[]
	    function addPreview(input) {
	       
	                var file = input[0].files[0];
	                var reader = new FileReader();
	                reader.onload = function (img) {
	                    //div id="preview" 내에 동적코드추가.
	                    //이 부분을 수정해서 이미지 링크 외 파일명, 사이즈 등의 부가설명을 할 수 있을 것이다.
	                    $("#preview").empty();
	                    $("#preview").append(
	                        "<img src=\"" + img.target.result + "\"\/>"
	                    );
	                };
	                
	                reader.readAsDataURL(file);
	            }
	    
	    var regex = new RegExp("(.*?)\.(exe|sh|zip|alz|cell|pptx|doc|hwp)$");
		var maxSize = 5242880; //5MB
		var cloneObj = $(".uploadDiv").clone();
		var uploadBtn = $("#uploadBtn");
		
		
		function checkExtension(fileName, fileSize){
			if(fileSize>= maxSize){
				alert("파일 사이즈 초과");
				return false;
			}
			
			if(regex.test(fileName)){
				alert("해당 종류의 파일은 업로드할 수 없습니다.");
				return false;
			}
			return true;
		}
		
		function fileUpload(){
        var formData = new FormData();
		var inputFile = $("input[name='uploadFile']");
		var files = inputFile[0].files[0];

		
		console.log(files);
		if(!checkExtension(files.name,files.size)){
			return false;
		}
		
		formData.append("uploadFile",files);
		
		$.ajax({
			url: '/mypage/uploadFormAction',
				processData: false,
				contentType: false,
				data: formData,
				type: 'POST',
				dataType:'json',
				success: function(result){
					console.log(result);

				}
		});
		}
		});

</script>

</body>
</html>
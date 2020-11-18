<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp" %>

<style>
	*{
		margin:0;
		padding:0;
	}
	#body {
		margin: auto;
		width: 1000px;
	}
	#upper {
        background-color: grey;
        width: 100%;
        height: 50px;
	}
	#left {
        background-color: yellowgreen;
        width: 33.333%;
        height: 100%;
		display: inline-block;
		font-size: 20px;
		text-align: center;
		line-height: 50px;
    }
    #center {
        background-color: skyblue;
        width: 33.333%;
        height: 100%;
		display: inline-block;
		font-size: 20px;
		text-align: center;
		line-height: 50px;
    }
    #right {
        background-color: yellow;
        width: 33.333%;
        height: 100%;
		display: inline-block;
		font-size: 20px;
		text-align: center;
		line-height: 50px;
    }
    #bodymain {
        width: 100%;
	}
	#clubboard {
  		font-family: Arial, Helvetica, sans-serif;
 		border-collapse: collapse;
  		width: 100%;
    }		
	#clubboard td, #clubboard th {
  		border: 1px solid #ddd;
  		padding: 8px;
	}
	#clubboard th {
  		padding-top: 12px;
  		padding-bottom: 12px;
  		text-align: center;
  		background-color:whitesmoke;
	}
	#createBtn {
	border: none;
	background-color: #f44336;
  	color: white;
  	padding: 13px 30px;
  	text-align: center;
  	font-size: 14px;
  	margin: 4px 2px;
  	cursor: pointer;
  	float: right;
	}
	.pullright {
	text-align: center;
	}

	.pullright .pagination {
  	display: -webkit-inline-box;
	}

	.pullright .pagination a {
  	color: black;
  	float: left;
  	padding: 8px 16px;
  	text-decoration: none;
	}
	.pullright .pagination .paginate_button {
		display: inline-block;
	}
</style>
<body>

<div id="body">
	<div id=upper>
		<div id="left">정보
		</div><div id="center">게시판
		</div><div id="right">채팅
		</div>
	</div><div id=bodymain>
			
			<form role="form" action="/regular/boardadd" method="post">
				<div class="form-group">
					<label>제목</label> <input class="form-control" name='cbBdTitle'>
				</div>
				
				<div class="form-group">
					<label>내용</label>
					<textarea class="form-control" rows="5" name='cbBdContent'></textarea>
				</div>
				
				<div class="form-group">
					<label>작성자</label>
					<input class="form-control" name='cbBdWriter'>
				</div>
				
				<button type="submit" class="btn btn-default">작성</button>
				<button type="button" class="btn btn-default">취소</button>
			</form>
			
			</div>
</div>	
</body>

<%@include file="../includes/footer.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file = "../../includes/header.jsp" %>

<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/mypage.css' />?after">

<nav id="nav">
<div class ="menu">
    <ul>
        <li>
            <form action="/mypage/main" method="get">
                <button class="btn1" type="submit">마이페이지</button>
            </form>
        </li>
            <li>
        <div class="dropdown">
            <button type="button" class="dropbtn" style="color: yellow;">모임관리</button>
            <div class="dropdown-content">
            <ul>
                <li>
                <form action="/mypage/myclub/main" method="get">
            	<button type="submit">모임관리홈</button>
        		</form>
                </li>
                <li>                <form action="/mypage/myclub/main" method="post">
            	<button type="submit">만남개설</button>
        		</form></li>
                <li>                <form action="/mypage/myclub/userManage" method="get">
            	<button type="submit">회원관리</button>
        		</form></li>

                
            </ul>
            </div>
        </div>
        </li>
    <li>
        <form action="/mypage/auth_edit" method="get">
            <button type="submit">회원정보수정</button>
        </form>
    </li>
    <li>
        <form action="/mypage/password" method="get" >
            <button type="submit">비밀번호수정</button>
        </form>
    </li>
    <li>
        <form action="/mypage/auth_leave" method="get">
            <button type="submit">회원탈퇴하기</button>
        </form>
        
        </li>
    </ul>

</div>
</nav>
<section id="wrap">
	<select name="clubList" id="clubList">
	</select>
	<div id="memberList">
	<table id="memberTable">
    
    <tbody>
    
    </tbody>
</table>
	
	</div>
</section>



<script type="text/javascript" src="/resources/js/club.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	let number = <c:out value="${usrNum}"/>;
	let clubList = $("#clubList")
	let memberTable = $("#memberTable tbody");
	let memList = [];
	
	clubService.getLeaderClubList({cbLeaderNum:number},function(club){
		let str = "";
		for(let i = 0; i < club.length; i++){
			str += "<option value='"+club[i].cbNum+"'>"+"["+club[i].cbType+"]"+club[i].cbName+"</option>";
		}
		clubList.append(str);
		let cbNum = $("#clubList option:selected").val();
		getClubManageMemList(cbNum);
	})
	
	$("#clubList").on("change",function(){
		let cbNum = $("#clubList option:selected").val();
		getClubManageMemList(cbNum);
	})
	
	 const getClubManageMemList = function(e){ 
		 $.ajax({
	           type:"GET",
	           url:"/mypage/clubmanage/getClubManageMemList/"+e+".json",          
	           dataType:"JSON",
	           success : function(list) {
	        	   console.log(list);
	        	   
	        	   let str = "";
	        	   memList = [];
	        	   memberTable.empty();
	        	   str += "<thead><tr><th>이름</th><th>성별</th><th>생일</th><th>신청일</th><th>회원상태</th></tr></thead>"

	        	   for(let i = 0; i < list.length; i++){
	        		   if(number == list[i].usrNum){
	        			   continue;
	        		   }
	        		   	memList.push(list[i]);
	        			str += "<tr>";
	        			str += "<td>"+list[i].usrName+"</td>";
	        			str += "<td>"+list[i].userVO.usrGender+"</td>";
	        			str += "<td>"+list[i].userVO.usrBirth+"</td>";
	        			str += "<td>"+list[i].cbAppDate+"</td>";
	        			if(list[i].cbMbStResult == '승인대기'){
	        				str += "<td><select name='cbMbStResult' id='cbMbStResult'><option value='"+list[i].cbMbStResult+"'>"+list[i].cbMbStResult+"</option><option value='가입승인'>가입승인</option><option value='승인거부'>승인거부</option></td>";
	        			}else if(list[i].cbMbStResult == '가입승인'){
	        				str += "<td><select name='cbMbStResult' id='cbMbStResult'><option value='"+list[i].cbMbStResult+"'>"+list[i].cbMbStResult+"</option><option value='모임추방'>모임추방</option>";
	        			}
	        				
	        			str += "</tr>"; 			
	        	   }
	        	   
	        	   memberTable.append(str);

	           },
	           complete : function(list) {
	           },
	           error : function(xhr, status, error) {
	                 alert("에러발생");
	           }
		});
		};
		
		const changeClubMemState = function(e){
			$.ajax({
				url: "/mypage/clubmanage/changeClubMemState",
				type:"PUT",
				data: JSON.stringify({usrNum:e.usrNum,cbNum:e.cbNum,cbName:e.cbName,cbType:e.cbType,cbMbStResult:e.cbMbStResult}),
				dataType: "json",
				contentType : "application/json; charset=utf-8",
				success: function(data){ 
				
				},
				complete : function(list) {
					let cbNum = $("#clubList option:selected").val();
					getClubManageMemList(cbNum);
		           }
				});
			};
				
				
 		$(document).on("change", "select[name=cbMbStResult]", function(){
 			let index = $("select[name=cbMbStResult]").index(this);
 			let status = $("select[name=cbMbStResult]").eq(index).val();
 			memList[index].cbMbStResult = status;
 			changeClubMemState(memList[index]);
 			
 		});
		

});
</script>

    <%@include file = "../../includes/footer.jsp" %>
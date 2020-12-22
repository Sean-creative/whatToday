<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file = "../../includes/header.jsp" %>
<link id="myCss" rel="stylesheet" type="text/css" href="<c:url value='/resources/css/mypage.css' />?after">
<nav id="navMenu">
<div class ="mypageMenu">
    <ul>
        <li>
            <form action="/mypage/main" method="get">
                <button class="btn1" type="submit">마이페이지</button>
            </form>
        </li>
            <li>
        <div class="dropdown2">
            <button type="button" class="dropbtn"  style="color: yellow;">모임관리</button>
            <div class="dropdown-content2">
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
            	<button type="submit"  style="color: orange;">회원관리</button>
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
        <form action="/mypage/password" method="get">
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
<section id="wrapInfo">
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
	let type;
	
	clubService.getLeaderClubList({cbLeaderNum:number},function(club){
		let str = "";
		for(let i = 0; i < club.length; i++){
			str += "<option value='"+club[i].cbNum+"' data-cbname='"+club[i].cbName+"' data-cbtype='"+club[i].cbType+"'>"+"["+club[i].cbType+"]"+club[i].cbName+"</option>";
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
	        	  
	        	   str += "<thead><tr><th>이름</th><th>성별</th><th>생일</th><th>신청일/가입일</th><th>회원상태</th></tr></thead>"

	        	   for(let i = 0; i < list.length; i++){
	        		   if(number == list[i].usrNum){
	        			   str += "<td>"+list[i].usrName+"</td>";
	        			   str += "<td>"+list[i].userVO.usrGender+"</td>";
	        			   str += "<td>"+list[i].userVO.usrBirth+"</td>";
	        			   str += "<td>"+list[i].cbAppDate+"</td>";
	        			   str += "<td>모임장</td>";
	        			   continue;
	        		   }
	        		   	memList.push(list[i]);
	        			str += "<tr>";
	        			str += "<td>"+list[i].usrName+"</td>";
	        			str += "<td>"+list[i].userVO.usrGender+"</td>";
	        			str += "<td>"+list[i].userVO.usrBirth+"</td>";
	        			str += "<td>"+list[i].cbJoinStateUpdateDate+"</td>";
	        			if(list[i].cbJoinStateResult == '승인대기'){
	        				str += "<td><select name='cbJoinStateResult' id='cbJoinStateResult'><option value='"+list[i].cbJoinStateResult+"'>"+list[i].cbJoinStateResult+"</option><option value='가입승인'>가입승인</option><option value='승인거부'>승인거부</option></td>";
	        			}else if(list[i].cbJoinStateResult == '가입승인'){
	        				str += "<td><select name='cbJoinStateResult' id='cbJoinStateResult'><option value='"+list[i].cbJoinStateResult+"'>"+list[i].cbJoinStateResult+"</option><option value='모임추방'>모임추방</option>";
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
		
		const changeClubMemStatePlus = function(e){
			$.ajax({
				url: "/mypage/clubmanage/changeClubMemStatePlus",
				type:"PUT",
				data: JSON.stringify({usrNum:e.usrNum,cbNum:e.cbNum,cbName:e.cbName,cbType:e.cbType,cbMbStResult:e.cbJoinStateResult}),
				dataType: "json",
				contentType : "application/json; charset=utf-8",
				success: function(data){ 
				
				},
				complete : function(list) {
					console.log(e);
					console.log("insert 직전");
					insertClubMember(e);
		           }
				});
			};
		const changeClubMemStateMinus = function(e){
			$.ajax({
				url: "/mypage/clubmanage/changeClubMemStateMinus",
				type:"PUT",
				data: JSON.stringify({usrNum:e.usrNum,cbNum:e.cbNum,cbName:e.cbName,cbType:e.cbType,cbMbStResult:e.cbJoinStateResult}),
				dataType: "json",
				contentType : "application/json; charset=utf-8",
				success: function(data){ 
				
				},
				complete : function(list) {
					insertClubJoinHistory(e);
					let cbNum = $("#clubList option:selected").val();
					getClubManageMemList(cbNum);
		           }
				});
			};
			
		const insertClubJoinHistory = function(e){
			console.log(e);
			let socData = e;
			$.ajax({
				url: "/mypage/clubmanage/insertClubJoinHistory",
				type:"POST",
				data: JSON.stringify({usrNum:e.usrNum,cbNum:e.cbNum,cbName:e.cbName,cbType:e.cbType,cbJoinStateResult:e.cbJoinStateResult}),
				dataType: "json",
				contentType : "application/json; charset=utf-8",
				success: function(data){
					
				},
				complete : function(list) {
					console.log(socData.usrId);
					console.log(socData.cbName);
					
					if(socket.readyState != 1){
						return;
					}
					
				    socket.send(socData.userVO.usrId+","+"["+socData.cbType+"]"+socData.cbName+"에 가입되셨습니다."); //타겟, 내용.
				    
		           }
				});
			};
			
			
			const insertClubMember = function(e){
				$.ajax({
					url: "/mypage/clubmanage/insertClubMember",
					type:"POST",
					data: JSON.stringify({usrNum:e.usrNum,usrName:e.usrName,cbNum:e.cbNum,cbName:e.cbName,cbType:e.cbType,cbJoinStateResult:e.cbJoinStateResult}),
					dataType: "json",
					contentType : "application/json; charset=utf-8",
					success: function(data){
						
					},
					complete : function(list) {
						insertClubJoinHistory(e);
						let cbNum = $("#clubList option:selected").val();
						getClubManageMemList(cbNum);
			           }
					});
				};
			
				
				
 		$(document).on("change", "select[name=cbJoinStateResult]", function(){
 			let index = $("select[name=cbJoinStateResult]").index(this);
 			let status = $("select[name=cbJoinStateResult]").eq(index).val();
 			
 			let data = $("#clubList option:selected").data();
 			console.log(data);
 			console.log(memList[index]);
 			memList[index].cbJoinStateResult=status;
 			console.log(memList[index].cbJoinStateResult);
 			
			if(status == '가입승인'){
				changeClubMemStatePlus(memList[index]); 
				alert("가입승인하셨습니다.");
 			} else if (status == '승인거부'){
 				insertClubJoinHistory(memList[index]);
 				alert("승인거부하셨습니다.");
 			} else if (status == '모임추방'){
 				changeClubMemStateMinus(memList[index]); 
 				alert("모임추방하셨습니다.");
 			}
 	
 		});
		

});
</script>

    <%@include file = "../../includes/footer.jsp" %>
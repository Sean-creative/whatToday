<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp" %>
<link rel="stylesheet" href="../resources/css/clubAddStyle.css">
	
<h3 style="text-align:center"> 기본정보(필수)</h3>
<form id="register" action="/regular/add" method="post">

    <input type="hidden" id="cbLeaderNum" name="cbLeaderNum" value ="${usrNum}"/>
    <input type="hidden" id="cbType" name="cbType" value ="정기"/>
    <input type="hidden" id="cbLeaderName" name="cbLeaderName" value ="${usrName}"/>
	<label for="cbCategory">카테고리/분야</label>
		<select id="cbCategory" name="cbCategory">
			<option>아웃도어/여행</option>
			<option>문화/공연/축제</option>
			<option>운동/스포츠</option>
			<option>음악/악기</option>
			<option>외국/언어</option>
			<option>게임/오락</option>
			<option>기타</option>
		</select>
	<label for="cbSubcat">모임</label>
		<select id="subcate" name="cbSubcat">
			<option>등산</option>
			<option>캠핑/백패킹</option>
			<option>자전거</option>
			<option>배드민턴</option>
			<option>마술</option>
			<option>영어</option>
			<option>노래/보컬</option>
		</select><br>
	<label for="cbName">모임명</label>
		<input type="text" id="club" name="cbName"><br>
	<label for="cbCity">지역</label>
		<select id="city" name="cbCity">
			<option>서울특별시</option>
			<option>경기도</option>
		</select>
	<label for="cbDistrict">세부지역</label>
		<select id="subcity" name="cbDistrict">
			<option>용산구</option>
			<option>동대문구</option>
			<option>마포구</option>
			<option>성남시</option>
			<option>안산시</option>
			<option>수원시</option>
			<option>가평군</option>
		</select> 
	<label for="cbMbNum">정원</label>
		<input type="text" id="num" name="cbMbNum"><br>
	<label for="cbMakeDate">개설일</label>
		<input id="date" name="cbMakeDate" value='<fmt:formatDate pattern = "yyyy/MM/dd" value="${club.cbMakeDate}"/>'>
	<label for="cbHashtag">해시태그</label>
		<input type="text" id="hash" name="cbHashtag" value="#"><br>
	<label for="cbIntro">한줄소개</label>
		<input type="text" id="info" name="cbIntro"> <br>
	<label for="cbDetailContent">모임 상세내용(필수)</label><br>
		<textarea name="cbDetailContent" rows="10" cols="100"></textarea><br>
	<input type="file" name="cbFile"> 
		<input type="submit" value="개설하기">
</form>

<%@include file="../includes/footer.jsp" %>
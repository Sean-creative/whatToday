
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!-- 작성자 : 김선우 -->
<%@include file="../includes/header.jsp"%>
<link rel="stylesheet" type="text/css" href="/resources/css/thunder.css">

<!--  번개 모임 개설 -->
<section id="wrap">
	<form role="form" action="/thunder/modify" method="post" name="modify">

		<div>
			<div>
				모임명<br> <input type="text" name='cbName'
					value='<c:out value="${clubVO.cbName}" />'>
			</div>

		</div>


		<div style="float: left; margin-right: 50px">
			<div style="margin: 2px 0px">
				<img src="/resources/img/thunderImg.png" width="110" height="110"
					alt="번개대표사진">
			</div>
			<br>

			<button type="button">사진변경</button>

		</div>


		<div>
			<div>
				모임 날짜<br> <input type="datetime-local"
					name='thunderDetailVO.cbDate' id=cbDate
					value='<c:out value="${clubVO.thunderDetailVO.cbDate}" />'>
			</div>
			<div>

				카테고리/분야<br>
				<script type="text/javascript">
					/* 외부 JS에서 JSTL이 적용되지 않아서, 내부스크립트의 var를 써서 해결 */
					var cg = '${clubVO.cbCategory}';
					var sc = '${clubVO.cbSubcat}';
					var ct = '${clubVO.cbCity}';
					var dt = '${clubVO.cbDistrict}';
				</script>
				<select name="cbCategory" id=category></select>
			</div>

			<div>
				모임<br> <select name="cbSubcat" id="subcat"></select>
			</div>
		</div>


		<div>
			<div>
				모임 인원<br> <input type="number" name='cbMbnum' min="1"
					max="1000000" value='<c:out value="${clubVO.cbMbnum}"/>'>
			</div>

			<div>
				모임 마감기간<br> <input type="datetime-local"
					name='thunderDetailVO.cbAppPeriod' id=cbAppPeriod
					value='<c:out value="${clubVO.thunderDetailVO.cbAppPeriod}" />'>
			</div>

			<div>
				해시태그<br> <input type="text" name='cbHashtag'
					value='<c:out value="${clubVO.cbHashtag}" />'>
			</div>
		</div>


		<div>
			<div>
				지역 <br> <select name="cbCity" id="city"></select>
			</div>
			<div>
				세부지역<br> <select name="cbDistrict" id="district"></select>
			</div>
		</div>

		<div>
			<div>
				모임 장소 <br> <input type="text" name='thunderDetailVO.cbPlace'
					id=cbPlace
					value='<c:out
						value="${clubVO.thunderDetailVO.cbPlace}" />'>
			</div>

			<div>
				모임 준비물<br> <input type="text" name='thunderDetailVO.cbSupplies'
					id=cbSupplies
					value='<c:out value="${clubVO.thunderDetailVO.cbSupplies}" />'>
			</div>
		</div>



		<div>
			모임소개<br>
			<!-- 300자 제한 -->
			<textarea name='cbIntro' cols="100" rows="7" maxlength="300"><c:out
					value="${clubVO.cbIntro}" /></textarea>
		</div>

		<div style="margin-left: 470px">
			<button type="submit" data-oper='modify' class="btn btn-default">
				Modify</button>

			<button type="submit" data-oper='remove' class="btn btn-danger">
				Remove</button>

			<button type="submit" data-oper='list' class="btn btn-info">
				List</button>
		</div>

		<input type='hidden' id='cbNum' name='cbNum'
			value='<c:out value="${clubVO.cbNum}"/>'> <input
			type='hidden' name='pageNum' value='<c:out value="${cri.pageNum}"/>'>
		<input type='hidden' name='amount'
			value='<c:out value="${cri.amount}"/>'> <input type='hidden'
			name='category' value='<c:out value="${cri.category}"/>'> <input
			type='hidden' name='subclass'
			value='<c:out value="${cri.subclass}"/>'> <input
			type='hidden' name='city' value='<c:out value="${cri.city}"/>'>
		<input type='hidden' name='district'
			value='<c:out value="${cri.district}"/>'> <input
			type='hidden' name='keyword' value='<c:out value="${cri.keyword}"/>'>
	</form>
</section>



<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- 렌더링을 거의 마치고 JS를 해석 할 것  -->
<script type="text/javascript" src="/resources/js/thunderModify.js"></script>

<%@include file="../includes/footer.jsp"%>
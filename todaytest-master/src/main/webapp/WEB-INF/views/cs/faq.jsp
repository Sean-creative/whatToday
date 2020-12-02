<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ include file="../includes/header.jsp"%>

<link rel="stylesheet" href="<c:url value='../resources/css/boardStyle2.css?after'/>">

<div class="ntc">
<div class="bcoran">
	<a href="/cs/faq">자주묻는질문 </a>
	<a href="/cs/inquire">1:1 문의사항  </a>
	<a href="/cs/notice">공지사항</a>
</div>

<h4>자주묻는 질문입니다.</h4>
<p>FAQ</p>

	<c:forEach items="${faqContent}" var="faq">
	
	<button class="collapsible">
		<span class="cleft"><c:out value="${faq.faqNum}" /></span>
		<c:out value="${faq.faqTitle}" />
	</button>
		<div class="content">
		  	<p>내용 <c:out value="${faq.faqContent}"/> </p>
		</div>
	 </c:forEach> 
</div>

<script>

var coll = document.getElementsByClassName("collapsible");
var i;

for (i = 0; i < coll.length; i++) {
  coll[i].addEventListener("click", function() {
    this.classList.toggle("active");
    var content = this.nextElementSibling;
    if (content.style.maxHeight){
      content.style.maxHeight = null;
    } else {
      content.style.maxHeight = content.scrollHeight + "px";
    }
  });
}
	  
</script>
<%@ include file="../includes/footer.jsp"%>
</body>
</html>
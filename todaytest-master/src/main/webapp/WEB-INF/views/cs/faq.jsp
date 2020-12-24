<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ include file="../includes/header.jsp"%>

<link rel="stylesheet" href="<c:url value='../resources/css/boardStyle2.css?after'/>">

<%-- <div class="ntc">
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
</div> --%>

	<div class="s-visual">
		<div class="s-visual-in">
			<h2>자주묻는질문</h2>
			<h4>FAQ</h4>
		</div>
    </div>
    
    <div class="notimenu">
        <div class="notisubmenu">
            <a href="/cs/notice">공지사항 </a>
            <a href="/cs/faq">자주묻는질문 </a>
            <a href="/cs/inquire">문의사항 </a>
        </div>
    </div>

 <div id="faq">
 	<c:forEach items="${faqContent}" var="faq">
        <button class="accordion">
            <div class="question">Q</div>
            <span><c:out value="${faq.faqTitle}" /></span>
        </button>
        
        <div class="panel">
        <p><c:out value="${faq.faqContent}"/></p>
        </div>
    </c:forEach>    
</div>        

<script>
        var acc = document.getElementsByClassName("accordion");
        var i;
        
        for (i = 0; i < acc.length; i++) {
          acc[i].addEventListener("click", function() {
            this.classList.toggle("active");
            var panel = this.nextElementSibling;
            if (panel.style.maxHeight) {
              panel.style.maxHeight = null;
            } else {
              panel.style.maxHeight = panel.scrollHeight + "px";

            } 
          });
        }

        </script>
<%@ include file="../includes/footer.jsp"%>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSTL</title>
</head>
<body>
	
	<%request.setCharacterEncoding("UTF-8"); %>
	<fmt:requestEncoding value="UTF-8" />


	<%-- 컨트롤러에서 request를 통해 보내준 Date 객체를 받아서 출력 --%>
	<fmt:formatDate value="${ day }"/> <br/>
	<fmt:formatDate value="${ day }" type="date"/> <br/>
	<fmt:formatDate value="${ day }" type="time"/> <br/>
	<fmt:formatDate value="${ day }" type="both"/> <br/>
	
	<br/><br/>
	
	<fmt:formatDate value="${ day }" type="both" dateStyle="short"/> <br/>
	<fmt:formatDate value="${ day }" type="both" dateStyle="medium"/> <br/>
	<fmt:formatDate value="${ day }" type="both" dateStyle="long"/> <br/>
	<fmt:formatDate value="${ day }" type="both" dateStyle="full"/> <br/>

	<br/><br/>

	<fmt:formatDate value="${ day }" type="both" dateStyle="short" timeStyle="short"/> <br/>
	<fmt:formatDate value="${ day }" type="both" dateStyle="short" timeStyle="medium"/> <br/>
	<fmt:formatDate value="${ day }" type="both" dateStyle="short" timeStyle="long"/> <br/>
	<fmt:formatDate value="${ day }" type="both" dateStyle="short" timeStyle="full"/> <br/>
		
	<br/><br/>
	
	<fmt:formatDate value="${ day }" pattern="yyyy년 MM월 dd일"/> <br/>
	
	<br/><br/>
	
	<%-- 숫자 관련 --%>
	
	<fmt:formatNumber value="100000" groupingUsed="true"/> <br/>
	<fmt:formatNumber value="100000" groupingUsed="false"/> <br/>
	
	<br/><br/>
	
	<fmt:formatNumber value="1000000" type="number"/> <br/>
	
	<br/><br/>
	
	<fmt:formatNumber value="100.25" type="currency" currencySymbol="\\"/> <br/>
	<fmt:formatNumber value="100.25" type="currency" currencySymbol="$"/> <br/>
	
	<br/><br/>
	
	<fmt:formatNumber value="0.3" type="percent"/> <br/>
	<fmt:formatNumber value="100.1234" pattern=".0"/> <br/>
	
	<br/><br/>
	
	<fmt:timeZone value="GMT">
		GMT 영국 : <fmt:formatDate value="${day}" type="both"/>
	</fmt:timeZone>
	<br/>
	<fmt:timeZone value="GMT-8">
		GMT-8 뉴욕 : <fmt:formatDate value="${day}" type="both"/>
	</fmt:timeZone>
	
	
	<br/><br/>
	
	
	<fmt:parseNumber value="10000.2222" var="result" integerOnly="true"/>
	result : ${ result }
	
	
</body>
</html>
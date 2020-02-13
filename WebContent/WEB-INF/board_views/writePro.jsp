<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="style.css" rel="stylesheet" type="text/css">
</head>
<c:if test="${wriCheck == false}">
	<script>
		alert("접근 오류.")
		window.location.href="/JSP/member/loginForm.win";
	</script>
</c:if>
<c:if test="${wriCheck == true}">
	<c:redirect url="/board/list.be"/>
</c:if>

<body>
	
</body>
</html>
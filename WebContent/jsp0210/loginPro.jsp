<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>LoginPro page</h1>
	
	<c:if test="${check == false}">
		<script>
			alert("아이디 또는 비밀번호 오류!!");
			history.go(-1);
		</script>
	</c:if>
	
	<c:if test="${check == true}">
		<c:redirect url="/main.love"/>
	</c:if>
</body>
</html>
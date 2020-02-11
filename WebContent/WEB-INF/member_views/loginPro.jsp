<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>loginPro</title>
</head>

<c:if test="${check == false}">
	<script>
		alert("아이디 또는 비밀번호를 잘 못 기입하셨습니다.");
		history.go(-1);
	</script>
</c:if>
<c:if test="${check == true }">
	<c:redirect url="/member/main.win"/>
</c:if>

<body>

</body>
</html>
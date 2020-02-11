<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>signup pro</title>
</head>

<c:if test="${check == false}">
	<script>
		alert("접근 오류.");
		window.location.href="/JSP/member/main.win";
	</script>
</c:if>
<c:if test="${check == true }">
	<script>
		alert("가입 완료 !");
		window.location.href="/JSP/member/main.win";
	</script>
</c:if>
<body>

</body>
</html>
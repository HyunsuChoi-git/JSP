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
<c:if test="${admCheck == true}">
	<c:if test="${result == 1}">
		<script>
			alert("회원 삭제 완료!");
			window.location.href="/JSP/member/admin_member.win";
		</script>
	</c:if>
	<c:if test="${result == 0}">
		<script>
			alert("회원 삭제 실패");
			history.go(-1);
		</script>
	</c:if>
</c:if>


</body>
</html>
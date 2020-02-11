<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원정보 수정/탈퇴</title>
	<link href="/JSP/jsp0211/style.css" rel="stylesheet" type="text/css" >
</head>

<c:if test="${check == false }" >
	<script type="text/javascript">
		alert("로그인 후 이용 가능한 페이지입니다.");
		window.location.href="/JSP/member/loginForm.win";
	</script>
</c:if>
<c:if test="${check == true }" >
<body>
	<br />
	<h2 align="center"> 수정 / 탈퇴 페이지 </h2>
	<table>
		<tr>
			<td><a href="/JSP/member/modifyForm.win">정보수정</a></td>
		</tr>
		<tr>
			<td><a href="/JSP/member/deleteForm.win">회원탈퇴</a></td>
		</tr>
		<tr>
			<td><a href="/JSP/member/main.win">메인으로</a></td>
		</tr>
	</table>

</body>
</c:if>

</html>
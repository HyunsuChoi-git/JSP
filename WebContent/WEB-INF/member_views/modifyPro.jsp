<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link href="/JSP/jsp0211/style.css" rel="stylesheet" type="text/css" >
</head>

<c:if test="${check == false}">
	<script>
		alert("잘못된 접근입니다.");
		window.location.href="/JSP/member/main.win";
	</script>
</c:if>
<c:if test="${check == true}">
<body>
	<br />
	<h1 align="center">회원 정보 수정</h1>
	<table>
		<tr>
			<td> <b>회원정보가 수정되었습니다.</b><br /> </td>
		</tr>
		<tr>
			<td>
				<button onclick="window.location.href='/JSP/member/main.win'" > 메인으로 </button>
			</td>
		</tr>
	</table>
</body>
</c:if>

</html>







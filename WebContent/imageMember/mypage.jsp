<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="style.css" rel="stylesheet" type="text/css" />
</head>
<%
	//세션이 있거나 세션은 없지만 쿠키가 있을 경우 진행.
	
	String id = (String)session.getAttribute("sId");
	
	
%>
<body>
	<h1 align="center">마이페이지</h1>
	<table>
		<tr>
			<td><%= id %>님의 마이페이지입니다.</td>
		</tr>
		<tr>
			<td>
				<button onclick="window.location.href='modifyForm.jsp'">회정정보수정</button>
				<button onclick="window.location.href='deleteForm.jsp'">회원탈퇴</button><br/>
				<button onclick="window.location.href='main.jsp'">메인으로</button>
			</td>
		</tr>
	</table>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="style.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<h1 align="center">Main</h1>

<%
	String sId = (String)session.getAttribute("sId");
	//세션이 있는 경우
	if(sId != null){
	%>
		<table>
			<tr>
				<td><%= sId %> 님 환영합니다.</td>
			</tr>
			<tr>
				<td>
					<button onclick="window.location.href='modifyForm.jsp'">회정정보수정</button>
					<button onclick="window.location.href='deletForm.jsp'">회원탈퇴</button><br/>
					<button onclick="window.location.href='logout.jsp'">로그아웃</button>
				</td>
			</tr>
		</table>
	<%	
	}else{
	//세션이 없는 경우, 쿠키있으면 loginPro.jsp로 넘기기
		Cookie[] coo = request.getCookies();
		for(Cookie c : coo){
			if(c.getName().equals("cId")) response.sendRedirect("loginPro.jsp");
		}
%>
	<table>
		<tr>
			<td>환영합니다.</td>
		</tr>
		<tr>
			<td>
				<button onclick="window.location.href='loginForm.jsp'">로그인</button>
				<button onclick="window.location.href='signinForm.jsp'">회원가입</button>
			</td>
		</tr>
	</table>

<% } %>
</body>
</body>
</html>
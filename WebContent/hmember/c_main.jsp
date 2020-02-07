<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="hmemberStyle.css" rel="stylesheet" type="text/css" />

</head>
<body>
	<h1>Main page</h1>
<%
String id = (String)session.getAttribute("sId");

if(id != null){
%>
	<table>
		<tr>
			<td><%=id %>님 환영합니다!</td>
		</tr>
		<tr>
			<td>
				<input type="button" value="마이페이지" onclick="window.location.href='c_mypage.jsp'"/>
				<input type="button" value="로그아웃" onclick="window.location.href='c_logout.jsp'"/>
			</td>
		</tr>
	</table>
<%		
}else{ 
	//쿠키가 있을 경우 loginPro페이지로 넘겨서 로그인상태로 전환
	Cookie[] coo = request.getCookies();
	for(Cookie c : coo){
		if(c.getName().equals("cId")) response.sendRedirect("b_loginPro.jsp");
	}
%>
	<table>
	<tr>
		<td>로그인이 필요합니다.</td>
	</tr>
	<tr>
		<td>
			<input type="button" value="로그인" onclick="window.location.href='b_login.jsp'"/>
			<input type="button" value="회원가입" onclick="window.location.href='a_signin.jsp'"/>
		</td>
	</tr>
</table>
<%
}
%>

</body>
</html>
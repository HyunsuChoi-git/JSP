<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="style.css" rel="stylesheet" type="text/css" />
<%
if(session.getAttribute("sId") == null){
	response.sendRedirect("c_main.jsp");
}
%>
<%
	//세션 쿠키 삭제
	session.invalidate();
	
	Cookie[] coo = request.getCookies();
	for(Cookie c : coo){
		if(c.getName().equals("cId")){
			c.setMaxAge(0);
			response.addCookie(c);
		}
		if(c.getName().equals("cPw")){
			c.setMaxAge(0);
			response.addCookie(c);
		}
		if(c.getName().equals("cAuto")){
			c.setMaxAge(0);
			response.addCookie(c);
		}
	}
	
%>
</head>
<body>
	<br/>
	<table>
		<tr>
			<td colspan="2" align="center">로그아웃이 완료되었습니다.</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="button" value="메인으로" onclick="window.location.href='c_main.jsp'"/>
			</td>
		</tr>
	</table>
</body>
</html>
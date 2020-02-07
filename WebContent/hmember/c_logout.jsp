<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="hmemberStyle.css" rel="stylesheet" type="text/css" />
</head>

<%
	String id = (String)session.getAttribute("sId");
	if(id == null){
		
%>
<script>
		alert("비정상적인 접근입니다.");
		window.location.href="c_main.jsp";
</script>
<% 				
	}else{
		session.invalidate();
		Cookie[] coo = request.getCookies();
		for(Cookie c : coo){
			if(c.getName().equals("cId")) {
				c.setMaxAge(0);
				response.addCookie(c);
			}
			if(c.getName().equals("cPw")) {
				c.setMaxAge(0);
				response.addCookie(c);
			}
			if(c.getName().equals("cAt")) {
				c.setMaxAge(0);
				response.addCookie(c);
			}
		}
	}
%>
<body>
	<br/>
	<br/>
	<br/>
	<table>
		<tr>
			<td colspan="2">로그아웃이 완료되었습니다.</td>
		</tr>
		<tr>
			<td colspan="2"><button onclick="window.location.href='c_main.jsp'">메인으로</button></td>
		</tr>
	</table>	
</body>		
</html>
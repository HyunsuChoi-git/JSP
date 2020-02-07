<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="style.css" rel="stylesheet" type="text/css" />
<%
	String sId = (String)session.getAttribute("sId");
	
	session.invalidate();
	
	Cookie[] coo = request.getCookies();
	for(Cookie c : coo){
		if(c.getName().equals("cId")){
			c.setMaxAge(0);
			response.addCookie(c);
		}
	}
	
%>
<body>
<br/>
	<table>
		<tr>
			<td>
				로그아웃이 완료되었습니다.<br/>
				<button onclick="window.location.href='main.jsp'">메인으로</button>
			</td>
		</tr>
	</table>

</body>
</html>
<%@page import="web.bmember.model.HDAO"%>
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
String sId = (String)session.getAttribute("sId");
String cId = null;
Cookie[] coo = request.getCookies();
for(Cookie c : coo){
	if(c.getName().equals("cId")) cId = c.getValue();
}
if(sId != null || cId != null){ %>
	<script>
		alert("비정상적인 접근입니다.");
		window.location.href="c_main.jsp";
	</script>
<% }else{%>

	<% request.setCharacterEncoding("UTF-8"); %>
	<jsp:useBean id="dto" class="web.bmember.model.HDTO"/>
	<jsp:setProperty property="*" name="dto"/>
	<%
		HDAO dao = new HDAO();
		dao.insert(dto);
	%>

	<body>
		<h1>Sign In</h1>
		<table>
			<tr>
				<td colspan="2" align="center"> 회원가입이 완료되었습니다.</td>
			</tr>
			<tr>
				<td><button onclick="window.location.href='c_main.jsp'">메인으로</button></td>
			</tr>
		</table>
	</body>

<%} %>
</html>
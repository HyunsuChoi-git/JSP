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
request.setCharacterEncoding("UTF-8");
String id = (String)session.getAttribute("sId");

if(id != null){ %>

	<jsp:useBean id="dto" class="web.bmember.model.HDTO"/>
	<jsp:setProperty property="*" name="dto"/>
<% 
	dto.setId(id);
	
	HDAO dao = new HDAO();
	dao.modify(dto);
%>
<body>
	<h1>회원 정보 수정</h1>
	<table>
		<tr>
			<td colspan="2"><%=id %>님의 정보가 수정되었습니다.</td>
		</tr>
		<tr>
			<td colspan="2"><button onclick="window.location.href='c_main.jsp'">메인으로</button></td>
		</tr>
	</table>

<% } else{ %>
	<script>
		alert("비정상적인 접근입니다.");
		window.location.href="c_main.jsp";
	</script>
<% } %>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="style.css" rel="stylesheet" type="text/css" />

<%
	String id = (String)session.getAttribute("sId");
	String pw = null, auto = null;
	if(id == null) {
		Cookie[] coo = request.getCookies();
		for(Cookie c : coo){
			if(c.getName().equals("cId")) id = c.getValue();
			if(c.getName().equals("cPw")) pw = c.getValue();
			if(c.getName().equals("cAuto")) auto = c.getValue();
			if(id == null || pw == null || auto == null){%>
				alert("로그인이 필요한 페이지입니다.");
				window.location.href="b_login.jsp";			
			<% }else{
				session.setAttribute("sId", id);
			}
		}
	}
%>
</head>
<body>
	<br />
	<h1 align="center">마이페이지</h1>
	<table>
		<tr>
			<td clospan="2" slign="center"><%=id %>님의 마이페이지입니다.</td>
		</tr>
		<tr>
			<td clospan="2" slign="center">
				<input type="button" value="회원정보수정" onclick="window.location.href='d_modify.jsp'" />
				<input type="button" value="회원탈퇴" onclick="window.location.href='e_delete.jsp'" />
			</td>
		</tr>
	</table>

</body>
</html>
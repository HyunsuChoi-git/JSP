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
	Cookie[] coo = request.getCookies();
	String cPw = null, cAt = null;
	for(Cookie c : coo){
		if(c.getName().equals("cId")){
			id = c.getValue();
			session.setAttribute("sId", id);
		}
		if(c.getName().equals("cPw")) cPw = c.getValue();
		if(c.getName().equals("cAt")) cAt = c.getValue();
	}
	if(cPw == null && cAt == null){
%>
<script>
		alert("로그인 후 이용 가능한 페이지입니다.");
		window.location.href="c_main.jsp";
</script>
<%
	}
}
%>

<body>
	<h1>My Page</h1>
	<table>
		<tr>
			<td><%=id %>님의 마이페이지입니다.</td>
		</tr>
		<tr>
			<td>
				<input type="button" value="회원정보수정" onclick="window.location.href='d_modify.jsp'"/>
				<input type="button" value="회원탈퇴" onclick="window.location.href='e_delete.jsp'"/>
			</td>
		</tr>
	</table>

</body>
</html>
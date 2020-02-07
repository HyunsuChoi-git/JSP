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
	String id = (String)session.getAttribute("sId");
	if(id != null){   %>
		<script>
			alert("이미 로그인이 되어있는 상태입니다.");
			window.location.href="c_main.jsp";
		</script>	
	<%}else{
	%>
		<body>
			<br />
			<h1 align="center">로그인</h1>
			<form action="b_loginPro.jsp" method="post">
			<table>
				<tr>
					<td>아이디</td>
					<td><input type="text" name="id" autofocus/></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="pw" /></td>
				</tr>
				<tr>
					<td colspan="2" align="conter">
					<input type="checkbox" name="auto" />자동로그인 <br/>
					<input type="submit" value="로그인"/>			
					<input type="button" value="회원가입" onclick="window.location.href='a_signin.jsp'"/>
					</td>
				</tr>
			</table>
			</form>
		
		</body>
	<%} %>
</html>
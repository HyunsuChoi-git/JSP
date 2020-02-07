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
	//세션이 있으면 : 이미 로그인되어있는 상태입니다. 메인
	//세션없지만 쿠키가 있으면 : 이미 로그인되어있는 상태입니다. 메인
	//세션도 쿠키도 없을 때 진행

	String sId = (String)session.getAttribute("sId");
	String cId = null;
	if(sId != null){ %>
 		<script>
 			alert("이미 로그인되어있는 상태입니다.");
 			window.location.href="e_main.jsp";
 		</script>	
<%	}else{
		Cookie[] coo = request.getCookies();
		for(Cookie c : coo){
			if(c.getName().equals("cId")){ 
				cId = c.getValue();
				session.setAttribute("sId", cId);
			%>
 			<script>
 				alert("이미 로그인되어있는 상태입니다.");
 				window.location.href="b_loginPro.jsp";
 			</script>	
<%			}
		}
	}
%>
<body>
	<br/>
	<h1>로 그 인</h1>
	<form action="b_loginPro.jsp" method="post">
		<table>
			<tr>
				<td>아이디</td>
				<td><input type="text" name="id" autofocus/></td>
			</tr>
			<tr>
				<td>패스워스</td>
				<td><input type="password" name="pw" /></td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="checkbox" name="auto"/>자동 로그인 <br/>
					<input type="submit" value="로그인"/>
					<input type="button" value="회원가입" onclick="window.location.href='a_signinForm.jsp'"/>				
				</td>
			</tr>
		</table>
	</form>
</body>
</html>
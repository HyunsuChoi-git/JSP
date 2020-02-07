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
	if(session.getAttribute("sId") == null){
		String cId = null;
		Cookie[] coo = request.getCookies();
		for(Cookie c : coo){
			if(c.getName().equals("cId")){ 
				cId = c.getValue();
			}
		}	
		if(cId != null){
			session.setAttribute("sId", cId);
		}else{
%>
			<script>
				alert("로그인이 필요합니다.");
				window.location.href="c_main.jsp";
			</script>
<%
		}
	}
%>
<body>
	<h1>회원탈퇴</h1>
	<table>
		<form action="e_deletePro.jsp" method="post">
			<tr>
				<td colspan="2">비밀번호를 입력해주세요.</td>
			</tr>
			<tr>
				<td><input type="password" name="pw" size="16"/></td>
			</tr>
			<tr>
				<td>
				<input type="submit" value="탈퇴하기"/>
				<input type="button" value="메인으로" onclick="window.location.href='c_main.jsp'"/>					
				</td>
			</tr>
		</form>
	</table>

</body>
</html>
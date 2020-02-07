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
	//세션이 있는 경우
	//세션은 없지만 쿠키가 있는 경우 진행
	
	//세션 없으면 경고창 -->메인
	
	String sId = (String)session.getAttribute("sId");
	String cId = null;
	Cookie[] coo = request.getCookies();
	
	for(Cookie c : coo){
		if(c.getName().equals("cId")) cId = c.getValue(); 
	}
	if(sId == null && cId == null){
%>
		<script>
			alert("로그인 후 이용하능한 페이지입니다.");
			window.location.href='e_main.jsp';
		</script>
<%  }else if(sId == null && cId != null){
		session.setAttribute("sId", cId);
		response.sendRedirect("d_deleteForm.jsp");
	}else{ %>

<body>
	<br/>
	<br/>
	<br/>
	<br/>

	<br/>
		<form action = "e_deletePro.jsp">
			<table>
				<tr>
					<td>회원탈퇴를 위해 패스워드를 입력하세요.<br /><br />
					<input type="password" name="pw" autofocus/></td>
				</tr>
				<tr>
					<td>
					<input type="button" value="뒤로가기" onclick="history.go(-1)"/>
					<input type="submit" value="탈퇴하기"/>
					</td>
				</tr>
			</table>
		</form>
</body>		
		
<% 	}%>

</html>
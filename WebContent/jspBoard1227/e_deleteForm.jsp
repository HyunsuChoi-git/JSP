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

	String num = request.getParameter("num");
%>
<body>
	<form action="e_deletePro.jsp" method="post">
		<input type="hidden" name="num" value="<%=num %>"/> 
		<table>
			<tr>
				<td>비밀번호를 입력하세요.<br/>
				<input type="password" name="pw" />
				</td>
			</tr>		
			<tr>
				<td>
				<input type="submit" value="삭제" />
				<input type="button" value="취소" onclick="history.go(-1)"/>
				</td>
			</tr>
		</table>
	</a></form>
	

</body>
</html>
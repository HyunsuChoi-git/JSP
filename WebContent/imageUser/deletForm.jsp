<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="style.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<h1 align="center">회원탈퇴</h1>
	<form action="deletePro.jsp" method="post">
		<table>
			<tr>
				<td>비밀번호를 입력하세요.<br/>
				<input type="password" name="pw"/>
				</td>
			</tr>
			<tr>
				<td>
					<input type="submit" value="탈퇴하기"/>
					<input type="button" value="메인으로" onclick="window.location.href='main.jsp'"/>
				</td>
			</tr>
		</table>
	</form>

</body>
</html>
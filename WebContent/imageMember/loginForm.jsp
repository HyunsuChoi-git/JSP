<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="style.css" rel="stylesheet" type="text/css" />
</head>
<!-- 세션이 없는 경우.
	세션이 존재하면 경고창 띄운 후 main.jsp로 넘기기
	세션은 없지만 쿠키가 존재하면 경고창 띄운 후 loginPro.jsp로 넘기기 -->
<body>
	<h1 align="center">로그인</h1>
	<form action="modifyPro.jsp" method="post">
		<table>
			<tr>
				<td>아이디</td>
				<td><input type="text" name="id" autofocus /></td>
			</tr>
			<tr>
				<td>패스워드</td>
				<td><input type="password" name="pw" /></td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="checkbox" name="auto" />자동로그인 <br/>
					<input type="submit" value="로그인" />
					<input type="button" value="회원가입" onclick="window.location.href='signinForm.jsp'" />
				</td>
			</tr>
		</table>
	</form>

</body>
</html>
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
<body>
	<h1 align="center">회원가입</h1>
	<form name="signIn" action="signinPro.jsp" method="post"
		enctype="multipart/form-data">
		<table>
			<tr>
				<td>아이디 *</td>
				<td><input type="text" name="id" autofocus /> <input
					type="button" value="중복검사" onclick="idCheck()" /></td>
			</tr>
			<tr>
				<td>비밀번호 *</td>
				<td><input type="password" name="pw" /></td>
			</tr>
			<tr>
				<td>비밀번호 확인*</td>
				<td><input type="password" name="pw2" /></td>
			</tr>
			<tr>
				<td>이름 *</td>
				<td><input type="text" name="name" /></td>
			</tr>
			<tr>
				<td>생년월일</td>
				<td><input type="text" name="birth" placeholder="YYYY-MM-DD" /></td>
			</tr>
			<tr>
				<td>Email</td>
				<td><input type="text" name="email" /></td>
			</tr>
			<tr>
				<td>프로필사진</td>
				<td><input type="file" name="img" /></td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="가입" /> <input
					type="reset" value="재입력" /></td>
			</tr>
		</table>
	</form>

</body>
</html>
<%@page import="web.upload1230.model.ImageDTO"%>
<%@page import="web.upload1230.model.ImageDAO"%>
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
	//세션이 있는 경우 진행
	//세션이 없고 쿠키만 있는 경우 세션 만들고 진행
	//세션 쿠키 다 없으면 경고창 띄우고 메인으로
	String sId = (String)session.getAttribute("sId");
	
	ImageDAO dao = ImageDAO.getImageDAO();	
	ImageDTO user = dao.getUser(sId);
%>
<body>
	<h1 align="center">회원정보 수정</h1>
	<form action="modifyPro.jsp" method="post" enctype="multipart/form-data">
		<table>
			<tr>
				<td>아이디 *</td>
				<td><%= sId %></td>
			</tr>
			<tr>
				<td>비밀번호 *</td>
				<td><input type="password" name="pw" value="<%= user.getPw() %>"/></td>
			</tr>
			<tr>
				<td>비밀번호 확인*</td>
				<td><input type="password" name="pw2" /></td>
			</tr>
			<tr>
				<td>이름 *</td>
				<td><%= user.getName() %></td>
			</tr>
			<tr>
				<td>생년월일</td>
				<td><input type="text" name="birth" value="<%= user.getBirth() %>" /></td>
			</tr>
			<tr>
				<td>Email</td>
				<td><input type="text" name="email" value="<%= user.getEmail() %>"/></td>
			</tr>
			<tr>
				<td>프로필사진</td>
				<td><img src="/web/save/<%= user.getImg() %>" width="100px"/> <br/>
				<input type="file" name="img" /></td>
			</tr>
			<tr>
				<td colspan="2"><input type="submit" value="수정" /> 
				<input type="reset" value="재입력" />
				<input type="button" value="취소" onclick="history.go(-1)"/>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>
<%@page import="web.jspBoard1227.model.BoardDTO"%>
<%@page import="web.jspBoard1227.model.BoardDAO"%>
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
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("pageNum");

BoardDAO dao = new BoardDAO();
BoardDTO article = dao.getArticle(num);

%>
<body>
<h1>수정하기</h1>
<form action="d_modifyPro.jsp" method="post">
	<input type="hidden" name="num" />
	<input type="hidden" name="pageNum" />
	
	<table>
		<tr>
			<td>제목</td>
			<td align="left">
			<input type="text" name="subject" value="<%=article.getSubject()%>"/></td>
		</tr>
		<tr>
			<td>닉네임</td>
			<td align="left"><%=article.getWriter()%></td>
		</tr>
		<tr>
			<td>이메일</td>
			<td align="left"><input type="text" name="email" value="<%=article.getEmail() %> " /></td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td align="left"><input type="password" name="pw" /></td>
		</tr>
		<tr>
			<td colspan="2">내용</td>
		</tr>
		<tr>
			<td colspan="2"><textarea rows="20" cols="80"><%=article.getContent()%></textarea></td>
		</tr>
		<tr>
			<td colspan="2" align="right">
				<input type="submit" value="수정" /> 
				<input type="button" value="뒤로가기" onclick="history.go(-1)"/> 
			</td>
		</tr>
	</table>
</form>
</body>
</html>
<%@page import="web.jspBoard1226.model.BoardDTO"%>
<%@page import="web.jspBoard1226.model.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 수정</title>
<link href="style.css" rel="stylesheet" type="text/css" />
</head>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");

	//DB에서 전체 가져와서 수정할 수 있는 것만 수정할 수 있도록 해주기
	BoardDAO dao = new BoardDAO();
	BoardDTO article = dao.getArticle(num);
%>
<body>
	<br/>
	<h1 align="center">글 수정</h1>
	
	<form action="modifyPro.jsp" method="post">
		<%-- 위 초기화한 데이터 hidden타입으로 넘겨주기--%>
		<input type="hidden" name="num" value="<%= num %>"/>
		<input type="hidden" name="pageNum" value="<%=pageNum %>" />
		
		<table>
			<tr>
				<td> 작성자 </td>
				<td align="left"><input type="text" name="writer" value="<%=article.getWriter()%>"/></td>
			</tr>
			<tr>
				<td> 제  목 </td>
				<td align="left"><input type="text" name="subject" value="<%=article.getSubject()%>"/></td>
			</tr>
			<tr>
				<td> 이메일 </td>
				<td align="left"><input type="text" name="email" value="<%=article.getEmail()%>"/></td>
			</tr>
			<tr>
				<td colspan="2"> 내  용 </td>
			</tr>
			<tr>
				<td colspan="2" align="justify"><textarea rows="20" cols="70" name="content"><%=article.getContent() %></textarea></td>
			</tr>
			<tr>
				<td> 비밀번호 </td>
				<td align="left"><input type="password" name="pw"/></td>
			</tr>
			<tr>
				<td colspan="2" align="right">
					<input type="submit" value="수정"/>
					<input type="reset" value="재작성"/>
					<input type="button" value="돌아가기" onclick="window.location.href='list.jsp?pageNum=<%=pageNum%>'"/>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>
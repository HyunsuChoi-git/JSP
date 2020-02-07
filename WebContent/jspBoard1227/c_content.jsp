<%@page import="java.text.SimpleDateFormat"%>
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
 //넘어온 num 으로 db에 접속하여 글 꺼내오는거얍!
 
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	BoardDAO dao = new BoardDAO();
	BoardDTO article = dao.getArticle(num);
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
%>
<body>
	<h1>게시판</h1>
	<table>
		<tr>
			<td colspan="2"><%=article.getSubject() %></td>
		</tr>
		<tr>
			<td><%=article.getWriter() %></td>
			<td><%= sdf.format(article.getReg())%></td>
		</tr>
		<tr>
			<td colspan="2"><%=article.getContent() %></td>
		</tr>
		<tr>
			<td colspan="2">
			<button onclick="window.location.href='d_modifyForm.jsp?num=<%= num%>&pageNum=<%= pageNum%>'">수정하기</button>
			<button onclick="window.location.href='e_deleteForm.jsp?num=<%= num%>'">삭제하기</button>
			</td>
		</tr>
		<tr>
			<td colspan="2">
			<button onclick="window.location.href='b_writeForm.jsp?num=<%= num%>&ref=<%= article.getRef()%>&re_step=<%= article.getRe_step()%>&re_level=<%= article.getRe_level()%>'">답글</button>
			<button onclick="window.location.href='a_list.jsp?pageNum=<%= pageNum%>'">목록</button>
			</td>
		</tr>
	</table>
</body>
</html>
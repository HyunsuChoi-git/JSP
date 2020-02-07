<%@page import="web.jspBoard1226.model.BoardDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="web.jspBoard1226.model.BoardDAO"%>
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
	//글 하나에 해당하는 내용 뿌려주기
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");  //몇 번째 페이지에서 넘어온 것인 지.
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	//DB에서 글의 고유번호로 내용 꺼내와서 DTO에 담기
	BoardDAO dao = new BoardDAO();
	BoardDTO article = dao.getArticle(num);
	
%>
<body>
	<br/>
	<h1 align="center"> content </h1>
	
	<table>
		<tr>
			<td colspan="2"><b><%=article.getSubject() %></b></td>
		</tr>
		<tr>
			<td colspan="2"><%=article.getContent() %></td>
		</tr>
		<tr>
			<td>post by <a href="mailto:<%=article.getEmail()%>"><%=article.getWriter() %></a> at 
			<%=sdf.format(article.getReg()) %>
			</td>
			<td>조회수 <%=article.getReadcount() %></td>
		</tr>
		<tr>
			<td colspan ="2">
				<button onclick="window,location.href='modifyForm.jsp?num=<%=num%>&pageNum=<%=pageNum%>'"> 수  정 </button>
				<button onclick="window.location.href='deleteForm.jsp?num=<%=num%>&pageNum=<%=pageNum%>'"> 삭  제 </button>
				<%-- 답글버튼 처리 : num,ref,re_step,re_level --%>
				<button onclick="window.location.href='writeForm.jsp?num=<%=num%>&ref=<%=article.getRef()%>&re_step=<%=article.getRe_step()%>&re_level=<%=article.getRe_level()%>'"> 답  글 </button>
				<% if(pageNum == null){ %>
					<button onclick="window.location.href='list.jsp'"> 리스트 </button>
				<% }else{ %>
					<button onclick="window.location.href='list.jsp?pageNum=<%=pageNum%>'"> 리스트 </button>
				<% } %>
			</td>
		</tr>
	</table>
	

</body>
</html>
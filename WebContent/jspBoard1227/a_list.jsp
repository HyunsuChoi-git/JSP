<%@page import="web.jspBoard1227.model.BoardDTO"%>
<%@page import="web.jspBoard1227.model.BoardDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
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

	// 1. 기본세팅
	String pageNum = null;
	if (request.getParameter("pageNum") == null) { pageNum = "1"; }
	else { pageNum = request.getParameter("pageNum"); }

	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	int pageSize = 10;
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize + 1;
	int endRow = currentPage * pageSize;
	int count = 0;
	int number = 0;
	
	BoardDAO dao = new BoardDAO();

	// 2. 전체 글 갯수 가져와서 count에 세팅
	count = dao.articleCount();

	// *이전페이지 글 갯수를 제외한 맨 윗번호 number에 넘겨주기
	number = count - (currentPage - 1) * pageSize ;
%>
<body>	
	<br/>
	<h1>현수의 두번째 게시판</h1>
	<table>
		<tr>
			<td colspan="6" align="right"><button onclick="window.location.href='b_writeForm.jsp'">글쓰기</button></td>
		</tr>
		<tr>
			<td>No.</td>
			<td>제목</td>
			<td>글쓴이</td>
			<td>작성일</td>
			<td>조회수</td>
			<td>IP</td>
		</tr>
	<%	
		if(count != 0){
		
			// 3. 원하는 범위만큼의 게시글 리스트 받아오기
			List articleList = null;
			articleList = dao.articleList(startRow, endRow);
			
			for(int i = 0; i < articleList.size(); i++){
				BoardDTO article = (BoardDTO)articleList.get(i);
	%>		
				<tr>
					<td><%= number-- %></td>
					<td><a href="c_content.jsp?num=<%=article.getNum()%>&pageNum=<%=pageNum%>"><%= article.getSubject()%></a></td>
					<td><%= article.getWriter()%></td>
					<td><%= sdf.format(article.getReg())%></td>
					<td><%= article.getReadcount()%></td>
					<td><%= article.getIp()%></td>
				</tr>						
			
	<%		}
		}else{
	%>
			<tr>
				<td colspan="6">작성된 글이 없습니다.</td>
			</tr>
	<%
		}
	%>
	</table>
	</body>
</html>
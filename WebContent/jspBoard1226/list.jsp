<%@page import="web.jspBoard1226.model.BoardDTO"%>
<%@page import="web.jspBoard1226.model.BoardDAO"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<link href="style.css" rel="stylesheet" type="text/css" />
</head>

<%
	//# 한 페이지에 보여줄 게시글 수와 시간 출력시 포맷 설정해주는 객체 생성
	int pageSize = 10;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	//게시글 페이지 정보 담기.
	//게시글 하단에 목록 페이지번호 누를 때마다 pageNum 파라미터를 던져주는 것을
	//여기서 꺼내기.
	String pageNum = "null";
	
	if(request.getParameter("pageNum") != null){
		pageNum = request.getParameter("pageNum");
	}else{
		pageNum = "1";
	}
	
	//처음 게시판 페이지에 접근했을 때는 pageNum을 파라미터로 전달받을 수 없기 때문에 1로 세팅.
	// else(pageNum == null){
	//	pageNum = "1";
	//}
	
	//# 현재 페이지에 보여줄 게시글의 시작과 긑 등등 정보를 세팅
	
	//현재 페이지
	int currentPage = Integer.parseInt(pageNum);	
	//페이지 시작글 번호
	int startRow = (currentPage - 1) * pageSize + 1;
	//페이지 끝글 번호
	int endRow = currentPage * pageSize;
	//DB에 있는 게시글 총 개수 담을 변수, 0으로 초기화
	int count = 0;
	//게시판에 글 번호를 뿌려줄 변수 (DB에 있는 글 고유번호가 아님, 게시판에서 보여줄 글 번호)
	int number = 0;
	
	//# 게시판 글 가져오기
	List articleList = null;
	BoardDAO dao = new BoardDAO();
	
	///////////////////////////
	String sel = request.getParameter("sel");
	String search = request.getParameter("search");
	
	if(sel != null && search != null){  // 글 검색으로 검색한 경우와 일반 리스트 if 문으로 나눠주기
		//검색어와 관련된 글의 갯수를 뽑아오고
		count = dao.getSearchArtucleCount(sel, search);
		//존재하면 해당하는 글을 페이지뷰어에 맞게 가져오는 것
		if(count >0){
			articleList = dao.getSearchArticlesList(startRow, endRow, sel, search);
		}
		
	}else{
		
		//전체 글 갯수 가져오기
		count = dao.getArticleCount();
		//글이 하나라도 있으면 글 가져오기
		if(count > 0){
			//현재 페이지에서 보여줘야 할 시작글번호~ 끝글 번호까지 가져오기
			articleList = dao.getArticlesList(startRow, endRow);
		}
		
	}
	
	//////////////////////////////
	
	
	//게시판에 뿌려줄 글 번호 담기
	number = count - (currentPage - 1) * pageSize;    //이전페이지의 글갯수 빼고 담아주기.
%>
<body>
	<br/>
	<h1 align="center"> 게시판</h1>
	
	<%-- 게시글이 0개 일 때 --%>
<%	if(count == 0){ %>
	<table>
		<tr>
			<td colspan="6" align="right">
				<button onclick="window.location.href='writeForm.jsp'">글쓰기</button>
			</td>
		</tr>
		<tr>
			<td>No.</td>
			<td>제목</td>
			<td>작성자</td>
			<td>날짜</td>
			<td>조회수</td>
			<td>IP주소</td>
		</tr>
		<tr>
			<td colspan="6">게시글이 없습니다.</td>
		</tr>
	</table>	
<%  }else{ %>
	
	<%-- 게시글이 존재할 때 --%>
	<table>
		<tr>
			<td colspan="6" align="right">
				<button onclick="window.location.href='writeForm.jsp'">글쓰기</button>
			</td>
		</tr>
		<tr>
			<td>No.</td>
			<td>제목</td>
			<td>작성자</td>
			<td>날짜</td>
			<td>조회수</td>
			<td>IP주소</td>
		</tr>
<% 		for(int i = 0; i < articleList.size(); i++){
			BoardDTO article = (BoardDTO)articleList.get(i);
%>			
			<tr>
				<td><%=number-- %></td>
				<td>
					<%
						//답글은 제목 들여쓰기 해주기
						int wid = 0;
						if(article.getRe_level() > 0){
							wid = 8*(article.getRe_level()); %>
							<img src="img/tabImg.PNG" width="<%=wid %>" /> <%--배경색으로 들여쓰기 --%>
							<img src="img/replyImg.png" width="10" /> 
					<%	}  %>
					<a href="content.jsp?num=<%=article.getNum()%>&pageNum=<%=currentPage%>"><%=article.getSubject() %>
				</a></td>
				<td><a href="mailto:<%=article.getEmail()%>"><%=article.getWriter() %></a></td>
				<td><%=sdf.format(article.getReg()) %></td>
				<td><%=article.getReadcount() %></td>
				<td><%=article.getIp() %></td>
			</tr>
<%		
		}
	}
%>
	</table>
	<br/>
<%-- 페이지 뷰어 설정 (pageNum) --%>

	<div align="center">
	<% 
		if(count > 0){
			//10페이지 씩 끊어서 나타내기
			
			//1. 총 몇페이지 나오는 지 계산하기
			int pageCount = count/pageSize + (count % pageSize == 0 ? 0 : 1);   //10개씩 한페이지로 묶고 나머지 값은, 존재하면 한페이지 더, 0이면 X
			//2. 보여줄 페이지 번호의 갯수 지정 (10페이지씩 끊어 보여주기로 했기 때문에)
			int pageBlock = 10;
			//3. 현재 위치한 페이지에서 페이지 뷰어 첫번째 숫자가 무엇인지 찾기.
			int startPage = (int)(currentPage/pageBlock)*pageBlock +1;
			//4. 마지막에 보여지는 페이지뷰어에 페이지 개수가 10 미만일 경우 마지막 페이지 번호가 endPage되도록 설정
			int endPage = startPage + pageBlock - 1;
			if(endPage > pageCount) endPage = pageCount;
			
			//6. startPage가 10보다 크면 '<' 보여주기
			if(startPage > pageBlock) { %>
				<a href="list.jsp?pageNum=<%=startPage-pageBlock%>"> &lt; </a>	
		  <%}
			//7. 뒷페이지가 더 있을 경우 '>' 보여주기
			if(endPage < pageCount){%>
		  		<a href="list.jsp?pagsNum=<%=startPage+pageBlock%>"> &gt; </a>
		  <%}
			
			
			//5. 페이지번호 반복해서 뿌려주기
			for(int i = startPage; 1 <= endPage; i++){ %>
				<a href="list.jsp?pageNum=<%=i %>"> &nbsp; <%= i %> &nbsp; </a>
				
		  <%}
		}
	%>
	
	<!-- 검색기능 -->
	<br/><br/>
	<form action = "list.jsp" method="post" >
		<select name="sel">
			<option value="writer">작성자</option>
			<option value="content">내용</option>
		</select>
		<input type="text" name="search" />
		<input type="submit" value="검색" />
		
	</form>
	</div>



</body>
</html>
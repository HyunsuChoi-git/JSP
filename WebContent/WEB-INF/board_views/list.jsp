<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>게시판</title>
	<link href="/JSP/jsp0212/style.css" rel="stylesheet" type="text/css">
</head>

<body>
	<br />
	<h1 align="center"> 게시판 </h1>
	<c:if test="${check == false}">
	<table>
		<tr>
			<td> 로그인 원하시면 버튼을 누르세요 <br />
				<button onclick="window.location.href='/JSP/member/loginForm.win'" >로그인</button>
			</td>
		</tr>
		<tr>
			<td>
				<a href="/JSP/member/signupForm.win" > 회원가입 </a>
			</td>
		</tr>
	</table>
	</c:if>
	<c:if test="${check == true}">
	<table>
		<tr>
			<td>${sessionScope.memId }님 환영합니다.<br />
				<button onclick="window.location.href='/JSP/member/logout.win'" >로그아웃</button>
				<button onclick="window.location.href='/JSP/member/modify.win'" >회원정보 변경</button>
			</td>
		</tr>
	</table>
	</c:if>
	<br /><br />
	<div align="center">
	<button onclick="window.location.href='/JSP/member/main.win'" >메인</button>
	<button onclick="window.location.href='/JSP/board/list.be'" >게시판</button>
	</div>
	<br /><br />
	<%-- 게시글 없을때 --%>
	<c:if test="${count == 0 }">
	
	<table>
		<c:if test="${check == true}">
		<tr>
			<td><button onclick="window.location='/JSP/board/writeForm.be'" > 글쓰기 </button></td>
		</tr>
		</c:if>
		<tr>
			<td align="center"> 게시글이 없습니다. </td>
		</tr>
	</table>
	</c:if>
	<%-- 게시글 있을때 --%>
	<c:if test="${count > 0 }">
	<table>
		<c:if test="${check == true}">
		<tr>
			<td colspan="6" align="right">
				<button onclick="window.location='/JSP/board/writeForm.be'" > 글쓰기 </button>
			</td>
		</tr>
		</c:if>
		<tr>
			<td>No.</td>
			<td>제   목</td>
			<td>작성자</td>
			<td>시   간</td>
			<td>조회수</td>
			<td>IP주소</td>
			<c:if test="${admin != null}">
			<td>삭제하기</td>
			</c:if>
		</tr>
		<c:forEach var="article" items="${articleList}">
			<tr>
				<td>${number}</td>
				<c:set var="number" value="${number-1}"/>
				<td align="left">
				<c:set var="wid" value="0"/>
				<c:if test="${article.re_level > 0}">
					<c:set var="wid" value="${8*(article.re_level)}"/>
					<img src="/JSP/jsp0212/img/tabImg.PNG" width="${wid}" /> <%--배경색으로 들여쓰기 효과 --%>
					<img src="/JSP/jsp0212/img/replyImg.png" width="10" />		
				</c:if>
					<a href="/JSP/board/content.be?num=${article.num }&pageNum=${currentPage}">${article.subject}</a>
				</td>
				<td><a href="mailto:${article.email}">${article.writer}</a></td>
				<td>${sdf.format(article.reg)}</td>
				<td>${article.readcount}</td>
				<td>${article.ip}</td>
				<c:if test="${admin != null}">
				<td><button onclick="window.location.href='/JSP/board/deleteForm.be?num=${article.num }&pageNum=${currentPage}'">삭제하기</button></td>
				</c:if>
			</tr>
		</c:forEach>
	</table>
	</c:if>
	<br />
	<%-- 검색기능 --%>
	<div align="center">
		<form action="/JSP/board/list.be" method="post">
			<select name="sel">
				<option value="subject">제목</option>
				<option value="writer">글쓴이</option>
				<option value="content">내용</option>
			</select>
			<input type="text" name="select" />
			<input type="submit" value="검색" />
		</form>
	</div>
	<br/>
	<%-- 목록의 페이지 번호 뷰어 설정 --%>
	<div align="center">
	<c:if test="${count > 0}">
		<!-- 정수만 가져오는 integerOnly 기능을 사용하기위해 res변수는 fmt태그로 처리한 것임. -->
		<fmt:parseNumber var="res" value="${count/pageSize}" integerOnly="true"/>
		<c:set var="pageCount" value="${res + (count % pageSize == 0 ? 0 : 1)}" />
		<c:set var="pageBlock" value="10" />
		<fmt:parseNumber var="res2" value="${currentPage/pageBlock}" integerOnly="true"/>
		<c:set var="startPage" value="${res2 * pageBlock + 1}" />
		<c:set var="endPage" value="${startPage + pageBlock - 1}" />
		<c:if test="${endPage > pageCount}" >
			<c:set var="endPage" value="${pageCount}" />
		</c:if>
		
		<c:if test="${startPage > pageBlock}">
			<a href="/JSP/board/list.be?pageNum=${startPage - pageBlock}" > &lt; </a>
		</c:if>
		
		<c:forEach var="i" begin="${startPage}" end="${endPage}" step="1">
			<a href="/JSP/board/list.be?pageNum=${i}" class="nums"> &nbsp; ${i} &nbsp; </a>
		</c:forEach>
		
		<c:if test="${endPage < pageCount}">
			<a href="/JSP/board/list.be?pageNum=${startPage + pageBlock}" > &gt; </a>
		</c:if>
	</c:if>
	</div>
	
</body>
</html>










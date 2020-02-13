<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="/JSP/jsp0211/style.css" rel="stylesheet" type="text/css">
</head>
<c:if test="${admCheck == false}">
	<script>
		alert("접근 오류.")
		window.location.href="/JSP/member/main.win";
	</script>
</c:if>
<c:if test="${admCheck == true}">
<body>
	<br />
	<h1 align="center"> 관리자 페이지 </h1>
	<h2 align="center"> 회원 리스트 </h2>
	<table>
		<tr>
			<td>관리자님 환영합니다.<br />
				<button onclick="window.location.href='/JSP/member/logout.win'" >로그아웃</button>
			</td>
		</tr>
	</table>
	<br /><br />
	<div align="center">
	<button onclick="window.location.href='/JSP/member/admin_member.win'" >회원 리스트</button>
	<button onclick="window.location.href='/JSP/board/list.be'" >게시판</button>
	</div>
		<br /><br />
	<%-- 회원 없을때 --%>
	<c:if test="${count == 0 }">
	
	<table>
		<tr>
			<td align="center"> 회원이 없습니다. </td>
		</tr>
	</table>
	</c:if>
	<%-- 게시글 있을때 --%>
	<c:if test="${count > 0 }">
	<table>
		<tr>
			<td>No.</td>
			<td>아이디</td>
			<td>이  름</td>
			<td>생  일</td>
			<td>이메일</td>
			<td>가입날짜</td>
			<td>삭제</td>
		</tr>
		<c:forEach var="member" items="${allMembers}">
			<tr>
				<td>${number}</td>
				<c:set var="number" value="${number-1}"/>
				<td align="left">${member.id}</td>
				<td>${member.name}</td>
				<td>${member.birth}</td>
				<td>${member.email}</td>
				<td>${sdf.format(member.reg)}</td>
				<td>
				<c:if test="${member.id != 'admin'}">
					<button onclick="window.location.href='/JSP/member/admin_deleteForm.win?id=${member.id}'">삭제하기</button>
				</c:if>	
				</td>
			</tr>
		</c:forEach>
	</table>
	</c:if>
	<br />
	<%-- 검색기능 --%>
	<div align="center">
		<form action="/JSP/member/admin_member.win" method="post">
			<select name="sel">
				<option value="id">아이디</option>
				<option value="name">이  름</option>
				<option value="email">이메일</option>
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
</c:if>
</html>
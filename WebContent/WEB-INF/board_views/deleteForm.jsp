<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>글 삭제</title>
	<link href="/JSP/jsp0212/style.css" rel="stylesheet" type="text/css">
</head>
<c:if test="${wriCheck == false}">
	<script>
		alert("접근 오류.")
		window.location.href="/JSP/member/main.win";
	</script>
</c:if>
<c:if test="${admCheck == true}">
	<br />
	<h1 align="center"> delete article (관리자용) </h1>
		<table>
			<tr>
				<td>삭제하시겠습니까?</td>
			</tr>
			<tr>
				<td>
					<button onclick="window.location.href='/JSP/board/deletePro.be?num=${num}&pageNum=${pageNum}'">삭제하기</button>
					<button onclick="window.location.href='/JSP/board/list.be?num=${num}&pageNum=${pageNum}'">취소</button>
				</td>
			</tr>
		</table>
	</form>
</c:if>
<body>
<c:if test="${wriCheck == true && admCheck == false}">
	<br />
	<h1 align="center"> delete article </h1>
	<form action="/JSP/board/deletePro.be?pageNum=${pageNum}" method="post">
		<%-- 글 고유 번호 숨겨서 넘기기 --%>
		<input type="hidden" name="num" value="${num}" />
		<table>
			<tr>
				<td>삭제를 원하시면 비밀번호를 입력하세요.</td>
			</tr>
			<tr>
				<td><input type="password" name="pw" /></td>
			</tr>
			<tr>
				<td>
					<input type="submit" value="삭제" />
					<input type="button" value="취소" onclick="window.location='/JSP/board/list.be?pageNum=${pageNum}'"/>
				</td>
			</tr>
		</table>
	</form>
</c:if>
</body>
</html>
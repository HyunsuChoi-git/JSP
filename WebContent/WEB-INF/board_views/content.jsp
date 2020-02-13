<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>글 내용</title>
	<link href="/JSP/jsp0212/style.css" rel="stylesheet" type="text/css">
</head>

<body>
	<br />
	<h1 align="center"> content </h1>
	
	<table>
		<tr>
			<td colspan="2"><b>${article.subject}</b></td>
		</tr>
		<tr>
			<td colspan="2"><textarea rows="20" cols="70" readonly>${article.content}</textarea> </td>
		</tr>
		<tr>
			<td>posted by <a href="mailto:${article.email}">${article.writer}</a> 
			at ${sdf.format(article.getReg())}</td>
			<td>${article.readcount} viewed</td>
		</tr>
		<tr>
			<td colspan="2">
				<c:if test="${memCheck == true}">
					<c:if test="${wriCheck == true}" >
					<button onclick="window.location='/JSP/board/modifyForm.be?num=${num}&pageNum=${pageNum}'">수   정</button>
					<button onclick="window.location='/JSP/board/deleteForm.be?num=${num}&pageNum=${pageNum}'">삭   제</button>
					</c:if>
					<%-- 답글버튼처리 : num,ref,re_step,re_level DB에서 받은정보 보내주면서 이동 --%>
					<button onclick="window.location='/JSP/board/writeForm.be?num=${num}&ref=${article.ref}&re_step=${article.re_step}&re_level=${article.re_level}'">답   글</button>
				</c:if>
				<button onclick="window.location='/JSP/board/list.be?pageNum=${pageNum}'" >리스트</button>
			</td>
		</tr>
	</table>
	
</body>
</html>
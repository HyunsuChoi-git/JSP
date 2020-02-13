<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>글 수정</title>
	<link href="/JSP/jsp0212/style.css" rel="stylesheet" type="text/css">
</head>

<c:if test="${wriCheck == false}" >
	<script>
		alert("접근 오류.")
		window.location.href="/JSP/member/main.win";
	</script>
</c:if>
<c:if test="${wriCheck == true}" >
<body>
	<br />
	<h1 align="center"> 글 수정 </h1>
	<form action="/JSP/board/modifyPro.be?pageNum=${pageNum}" method="post">
		<%-- 숨겨서 글 속성에 관련된 데이터 전송 --%>
		<input type="hidden" name="num" value="${num}" />
		<input type="hidden" name="writer" value="${article.writer}" />
		<input type="hidden" name="email" value="${article.email}" />
		<table>
			<tr>
				<td> 작성자 </td>
				<td align="left"> 
					${article.writer} 
				</td>
			</tr>
			<tr>
				<td> 제   목 </td>
				<td align="left">
					<input type="text" name="subject" value="${article.subject}"/> 
				</td>
			</tr>
			<tr>
				<td> e-mail </td>
				<td align="left"> 
					${article.email}
				</td>
			</tr>
			<tr>
				<td> 내   용 </td>
				<td> <textarea rows="20" cols="70" name="content">${article.content}</textarea> </td>
			</tr>
			<tr>
				<td> 비밀번호 </td>
				<td align="left"> <input type="password" name="pw" /> </td>
			</tr>
			<tr>
				<td colspan="2" align="right">
					<input type="submit" value="저장" />
					<input type="reset" value="재작성" />
					<input type="button" value="리스트보기" onclick="window.location='/JSP/board/list.be?pageNum=${pageNum}'" />
				</td>
			</tr>
		</table>
	</form>

</body>
</c:if>
</html>
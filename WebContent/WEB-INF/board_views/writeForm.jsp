<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>게시글 작성</title>
	<link href="/JSP/jsp0212/style.css" rel="stylesheet" type="text/css">
</head>
<c:if test="${memCheck == false}">
	<script>
		alert("로그인 후 이용 가능한 페이지입니다.")
		window.location.href="/JSP/member/loginForm.win";
	</script>
</c:if>
<c:if test="${memCheck == true}">
<body>
	<br />
	<h1 align="center"> 글 작성 </h1>
	<form action="/JSP/board/writePro.be" method="post">
		<%-- 숨겨서 글 속성에 관련된 데이터 전송 --%>
		<input type="hidden" name="num" value="${num}" />
		<input type="hidden" name="ref" value="${ref}" />
		<input type="hidden" name="re_step" value="${re_step}" />
		<input type="hidden" name="re_level" value="${re_level}" />
		<input type="hidden" name="writer" value="${member.id}"/>
		<input type="hidden" name="email" value="${member.email}"/>
		<input type="hidden" name="pw" value="${member.pw}"/>
		<table>
			<tr>
				<td> 작성자 </td>
				<td align="left"> ${member.id} </td>
			</tr>
			<tr>
				<td> 제   목 </td>
				<td align="left"> 
					<c:if test="${num == 0}">
					<input type="text" name="subject" /> 
					</c:if>
					<c:if test="${num != 0}">
					<input type="text" name="subject" value="[답글]"/>
					</c:if>
				</td>
			</tr>
			<tr>
				<td> e-mail </td>
				<td align="left"> ${member.email} </td>
			</tr>
			<tr>
				<td> 내   용 </td>
				<td> <textarea rows="20" cols="70" name="content"></textarea> </td>
			</tr>
			<tr>
				<td colspan="2" align="right">
					<input type="submit" value="저장" />
					<input type="reset" value="재작성" />
					<input type="button" value="리스트보기" onclick="window.location='/JSP/board/list.be'" />
				</td>
			</tr>
		</table>
	</form>
</body>
</c:if>
</html>
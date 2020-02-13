<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="/JSP/jsp0211/style.css" rel="stylesheet" type="text/css">
</head>
<body>
<c:if test="${admCheck == true}">
	<br />
	<h1 align="center"> 회원 삭제 </h1>
		<table>
			<tr>
				<td>'${id}' 를/을 삭제하시겠습니까?</td>
			</tr>
			<tr>
				<td>
					<button onclick="window.location.href='/JSP/member/admin_deletePro.win?id=${id}'">삭제하기</button>
					<button onclick="window.location.href='/JSP/member/admin_member.win'">취소</button>
				</td>
			</tr>
		</table>
	</form>
</c:if>
<c:if test="${admCheck == false}">
	<script>
		alert("접근 오류.")
		window.location.href="/JSP/member/main.win";
	</script>
</c:if>

</body>
</html>
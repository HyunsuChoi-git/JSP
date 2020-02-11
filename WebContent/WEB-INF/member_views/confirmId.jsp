<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>ID 중복확인</title>
	<link href="/JSP/member/style.css" rel="stylesheet" type="text/css">
</head>

<c:if test="${checkS == false }">
	<script>
		alert("잘못된 접근입니다.");
		window.location.href="/JSP/member/main.win";
	</script>
</c:if>
<c:if test="${check == true }">

<body>
	<table>
		<tr>
			<td>${ id }는 이미 사용중인 아이디입니다.  </td>
		</tr>
	</table> <br /><br />
	<form action="/JSP/member/confirmId.win" method="post">
		<%-- 다시 id 입력해서 중복되는지 조회할 수 있는 입력 form 만들기 --%>
		<table>
			<tr>
				<td>다른 아이디를 선택하세요. <br />
					<input type="text" name="id" />
					<input type="submit" value="ID중복확인" />
				</td>
			</tr>
		</table>
	</form>
</body>
</c:if>

<c:if test="${check == false }">
<body>
	<table>
		<tr>
			<td>입력하신 ${ requestScope.id }는 사용가능한 아이디입니다. <br />
				<input type="button" value="닫기" onclick="setId()"/>
			</td>
		</tr>
	</table>
</body>
	<script>
		function setId() {
			opener.document.inputForm.id.value="${ requestScope.id }";
			self.close();
		}
	</script>
</c:if>

</html>







<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body >
		
	<table width="600" border="1">
		<tr>
			<td colspan="2">
				<jsp:include page="ex_includeHeader.jsp" flush="false"/>
			</td>
		</tr>
		<tr>
			<td>
				<jsp:include page="ex_includeSide.jsp" flush="false" />
			</td>
			<td height="300">
				<h2>안녕 여긴 메인페이지야</h2>
			</td>
		</tr>
		<tr>
			<td colspan="2">
			<jsp:include page="ex_includeFooter.jsp" flush="false" />
			</td>
		</tr>
	</table>
</body>
</html>
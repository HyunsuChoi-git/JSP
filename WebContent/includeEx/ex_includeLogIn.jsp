<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
 <% request.setCharacterEncoding("UTF-8");  %>
<body>
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
				<form action="ex_includeMain.jsp" method="post">
					<table border="1" width="400">
						<tr>
							<td>아이디 :</td>
							<td><%=request.getParameter("id")%></td>
						</tr>
						<tr>
							<td>비밀번호 :</td>
							<td><%=request.getParameter("pw")%></td>
						</tr>
						<tr>
							<td>이름 :</td>
							<td><%=request.getParameter("name")%></td>
						</tr>
						<tr>
							<td>연락처 :</td>
							<td><%=request.getParameter("phon")%></td>
						</tr>
						<tr>
							<td>생일</td>
							<td><%=request.getParameter("birth")%></td>
						</tr>
						<tr>
							<td>성별</td>
							<td>
								<%
									String gender = request.getParameter("gender");
									if (gender != null) {
										if (gender.equals("남자")) {
								%> <input type="radio" name="gender"
								value="남자" checked />남자 <%
 	} else {
 %> <input type="radio"
								name="gender" value="여자" checked />여자 <%
 	}
 	}
 %>
							</td>
						</tr>
						<tr rowspan="2">
							<td colspan="2"><input type="submit" value="가입완료!" /></td>
						</tr>
						</form>
					</table>
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
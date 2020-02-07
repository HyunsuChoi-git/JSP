<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Calendar" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
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
			<td>
				<table>
					<form action="ex_includeLogIn.jsp" method="post">
						<tr>
							<td>아이디 : </td>
							<td><input type ="text" name="id" autofocus /></td>
						</tr>
						<tr>
							<td>비밀번호 : </td>
							<td><input type ="password" name="pw" /></td>
						</tr>
						<tr>
							<td>이름 : </td>
							<td><input type ="text" name="name" size="6" /></td>
						</tr>
						<tr>
							<td>연락처 :</td>
							<td><input type ="text" name="phon" size="14" placeholder="000-0000-0000" /></td>
						</tr>
						<tr>
							<td>생일</td>
							<td><input type ="text" name="birth" size="14" placeholder="yyyy-mm-dd" /></td>
						</tr>
						<tr>
							<td>성별</td>
							<td><input type ="radio" name="gender" value="남자" checked />남자
							<input type ="radio" name="gender" value="여자" />여자</td>
						</tr>
						<tr rowspan="2">
							<td colspan="2"><input type ="submit" value="가힙!" /></td>					
						</tr>											
					</form>				
				</table>
			</td>
		</tr>
		<tr>
			<td colspan="2">
			<jsp:include page="ex_includeFooter.jsp" flush="false" />
			<% Calendar cal = Calendar.getInstance();
			request.setAttribute("today", cal); %>
			
			
			</td>
		</tr>
	</table>
</body>
</html>
<%@page import="web.member.model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="style.css" rel="stylesheet" type="text/css" />
</head>

<body>
	<%
		String id = (String) session.getAttribute("sId");
		String pw = request.getParameter("pw");

		///////////로그인 확인절차 
		String auto = null;
		if (id == null) {
			Cookie[] coo = request.getCookies();
			for (Cookie c : coo) {
				if (c.getName().equals("cId"))
					id = c.getValue();
				if (c.getName().equals("cPw"))
					pw = c.getValue();
				if (c.getName().equals("cAuto"))
					auto = c.getValue();
				if (id == null || pw == null || auto == null) {
	%>
	<script>
		alert("로그인이 필요한 페이지입니다.");
		window.location.href = "b_login.jsp";
	</script>
	<%
		} else {
					session.setAttribute("sId", id);
				}
			}
		} else {

			////////////

			MemberDAO dao = new MemberDAO();

			int a = dao.delete(id, pw);

			if (a == 1) {
				//세션, 쿠키 삭제
				session.invalidate();
				Cookie[] coo = request.getCookies();
				for (Cookie c : coo) {
					if (c.getName().equals("cId")) {
						c.setMaxAge(0);
						response.addCookie(c);
					}
					if (c.getName().equals("cPw")) {
						c.setMaxAge(0);
						response.addCookie(c);
					}
					if (c.getName().equals("cAuto")) {
						c.setMaxAge(0);
						response.addCookie(c);
					}
				}
	%>
	<h1 align="center">회원탈퇴</h1>
	<table method="post">
		<tr>
			<td colspan="2" align="center">탈퇴가 완료되었습니다.<br /> <input
				type="button" value="메인으로"
				onclick="window.location.href='c_main.jsp'" />
			</td>
		</tr>
	</table>
	<%
		}
		}
	%>

</body>
</html>
<%@page import="web.member.model.MemberDTO"%>
<%@page import="web.member.model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="style.css" rel="stylesheet" type="text/css" />
    <script>
        //유효성 검사
        function check(){
             if(!document.signIn.pw.value){
                alert("비밀번호를 입력하세요.");
                return false;
            }
            if(!document.signIn.pw2.value){
                alert("비밀번호 확인을 입력하세요.");
                return false;
            }
            var inputs = document.signIn;
            if(inputs.pw.value != inputs.pw2.value){
               alert("비밀번호가 일치하지 않습니다.")
                return false;
            }
        }
    </script>
</head>
<%
String id = (String)session.getAttribute("sId");
MemberDAO dao = new MemberDAO();
MemberDTO dto= dao.getMember(id);
%>

<body>
	<% 
	String pw = null, auto = null;
	if(id == null) { 
		Cookie[] coo = request.getCookies();
		for(Cookie c : coo){
			if(c.getName().equals("cId")) id = c.getValue();
			if(c.getName().equals("cPw")) pw = c.getValue();
			if(c.getName().equals("cAuto")) auto = c.getValue();
			if(id == null || pw == null || auto == null) {%>
				<script>
				alert("로그인이 필요한 페이지입니다.");
				window.location.href="b_login.jsp";			
				</script>
			<% }else{
				session.setAttribute("sId", id);
			}
		}
	}else{ %>
	<br />
	<h1 align="center">회원 정보 수정</h1>
	<form name="signIn" action="d_modifyPro.jsp" onsubmit="return check()" method="post">
	<table>
		<tr>
			<td>아이디 * </td>
			<td align="left"> <%=dto.getId()%></td>
		</tr>
		<tr>
			<td>비밀번호 *</td>
            <td><input type="password" name="pw" value="<%=dto.getPw()%>" /></td>
		</tr>
		<tr>
			<td>비밀번호 확인*</td>
            <td><input type="password" name="pw2" autofocus/></td>
		</tr>		
		<tr>
			<td>이름 * </td>
			<td align="left"> <%=dto.getName()%></td>
		</tr>
		<tr>
			<td>생년월일 </td>
			<td><input type="text" name="birth" value="<%=dto.getBirth()%>" /></td>
		</tr>
		<tr>
			<td>Email </td>
			<td><input type="text" name="email" value="<%=dto.getEmail()%>" /></td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="submit" value="수정" />
				<input type="button" value="돌아가기" onclick="window.location.href='c_main.jsp'"/>
			</td>
		</tr>
	</table>
	</form>
<%	} %>
</body>
</html>
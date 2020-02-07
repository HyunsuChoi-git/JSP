<%@page import="web.bmember.model.HDTO"%>
<%@page import="web.bmember.model.HDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	body {
		background-color: #e9e9ec;
	}
	h1 {
		background-color:#aebdea ;
		width : 400px;
		margin : auto;
		margin-top : 60px;
		color : azure;
		text-align: center;
        font-size: 35px;
        padding-bottom: 10px;
	}
	table {
		background-color: #e5e5ff;
		margin : auto;
		margin-top : 40px;
		color : #292b2c;
		border: 1px solid #e5e5ff;
		padding : 10px;
		padding-left: 30px; 
		padding-right: 30px;
	}
	tr {
		line-height: 230%;
	}
	td {
		width : 150px;
	}
	button {
		background-color: azure;
		margin-top : 30px;
		border : 1px solid azure; 
		border-radius: 3px;
		padding : 3px;
		padding-left : 5px;
		padding-right : 5px;
		font-size : 15px; 
		color: #77878F; 
		FONT-FAMILY: 맑은 고딕,verdana; 
	}
	input {
		background-color: azure;
		margin-top : px;
		border : 1px solid azure; 
		border-radius: 3px;
		padding : 2px;
		padding-left : 5px;
		padding-right : 5px;
		font-size : 15px; 
		color: #77878F; 
		FONT-FAMILY: 맑은 고딕,verdana; 
	}
	.font {
		margin-left : 100px;		
	}
</style>
<script type="text/javascript">
//유효성 검사 메소드
	function check(){
	     if(!document.modify.pw.value){
	        alert("비밀번호를 입력하세요.");
	        return false;
	    }
	    if(!document.modify.pw2.value){
	        alert("비밀번호 확인을 입력하세요.");
	        return false;
	    }
	    var inputs = document.modify;
	    if(inputs.pw.value != inputs.pw2.value){
	       alert("비밀번호가 일치하지 않습니다.")
	        return false;
	    }
	}

</script>

</head>
<% 
String id = (String)session.getAttribute("sId");
String cPw = null, cAt = null;

if(id != null){	
HDAO dao = new HDAO();
HDTO dto = dao.getUser(id);

%>
<body>
	<h1>회원 정보 수정</h1>
	<form name="modify" action="d_modifyPro.jsp" onsubmit="return check()" method="post">
		<table>
			<tr>
				<td>아이디</td>
				<td><%=dto.getId()%></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" name="pw" size="16" value="<%=dto.getPw()%>"/></td>
			</tr>
			<tr>
				<td>비밀번호 확인</td>
				<td><input type="password" name="pw2" size="16" /></td>
			</tr>
			<tr>
				<td>이름</td>
				<td><%=dto.getName()%></td>
			</tr>
			<tr>
				<td>성별</td>
				<td><input type="radio" name="gender" value="<%=dto.getGender()%>" checked /><%=dto.getGender()%>
				<% if(dto.getGender().equals("남자")){ %>
					<input type="radio" name="gender" value="여자"/> 여자
				<% }else{ %>
					<input type="radio" name="gender" value="남자"/> 남자
				<% } %>
				</td>
			</tr>
			<tr>
				<td>생년월일</td>
				<td><input type="text" name="birth" size="16" value="<%=dto.getBirth()%>"/></td>
			</tr>
			<tr>
				<td>주소</td>
				<td><input type="text" name="addr" size="40" value="<%=dto.getAddr()%>"/></td>
			</tr>
			<tr>
				<td>전화번호</td>
				<td><input type="text" name="phon" size="16" value="<%=dto.getPhon()%>"/></td>
			</tr>
			<tr>
				<td>이메일</td>
				<td><input type="text" name="email" size="20" value="<%=dto.getEmail()%>"/></td>
			</tr>
			<tr>
				<td>SNS 수신동의</td>
				<td>
				<input type="checkbox" name="sns1" value="e-mail"
				<% 
					if(dto.getSns1() != null){ %>
						checked
				<% 	}
				%> /> e-mail
                <input type="checkbox" name="sns2" value="SMS"
                <% 
					if(dto.getSns2() != null){ %>
						checked
				<% 	}
				%>/> SNS
				</td>
			</tr>
			<tr rowspan="2">
				<td colspan="2" align="center">
					<input type="submit"  value="수정" />
					<input type="button"  value="되돌아가기" onclick="window.location.href='c_main.jsp'"/>
				</td>
			</tr>
		</table>
	</form>
</body>
<%
}else{
	Cookie[] coo = request.getCookies();
	for(Cookie c : coo){
		if(c.getName().equals("cId")){
			id = c.getValue();
			session.setAttribute("sId", id);
			response.sendRedirect("d_modify");
		}
		if(c.getName().equals("cPw")) cPw = c.getValue();
		if(c.getName().equals("cAt")) cAt = c.getValue();
	}
	if(cPw == null && cAt == null){
		if(cPw == null || cAt == null){
		%>
				<script>
				alert("로그인 후 이용 가능한 페이지입니다.");
				window.location.href="c_main.jsp";		
				</script>
		<%
		}
	}
}
%>

</html>
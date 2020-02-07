<%@page import="web.bmember.model.HDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="hmemberStyle.css" rel="stylesheet" type="text/css" />
</head>
<body>
<%
	String id = request.getParameter("id");
	if(id != null) {
		HDAO dao = new HDAO();
		boolean b = dao.checkId(id);
		
		if(b){
%>
			<table>
				<tr>
					<td>
						이미 존재하는 아이디입니다. <br/><br/>
						<input type="text" name="id" />
						<input type="button" value="중복검사" onclick="window.location.href='f_checkId'"/>
					</td>
				</tr>
			</table>
<%
		}else{
%>
		<table>
			<tr>
				<td>
					사용하실 수 있는 아이디입니다. <br/><br/>
					<input type="button" value="완료" onclick="close()"/>				
				</td>
			</tr>
		</table>
		<script>
			function close(){
				opner.document.Sign_In.id.value="<%= id %>";
				self.close();	
			}
		</script>
<% 
		}
	}else{
%>
		<script>
			alert("비정상적인 접근입니다.");
			window.location.href="c_main.jsp";
		</script>
<% 
	}
%>
</body>
</html>
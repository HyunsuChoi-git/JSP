<%@page import="web.jsp0101.model.M0101DAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="style.css" rel="stylesheet" type="text/css" />
</head>
<%
	//세션없고, 쿠키도 없을 때만 진행
	String sId = (String)session.getAttribute("sId");
	String cId = null;
	Cookie[] coo = request.getCookies();
	if(coo != null){
		for(Cookie c : coo){
			if(c.getName().equals("cId")) cId = c.getValue();
		}
	}
	String id = request.getParameter("id"); 
	System.out.println(sId+ cId+ id);
	
	if(sId == null && cId == null && id != null ){ 
	
		M0101DAO dao = new M0101DAO();	
		boolean b = dao.checkId(id);
		if(!b){ %>
			<body>
				<form>
					<table>
						<tr>
							<td>
								사용할 수 있는 아이디입니다. <br/>
								<input type="button" value="닫기" onclick="setId()"/> 
							</td>
						</tr>
					</table>
				</form>
					<script>
						function setId(){
							opener.document.signin.id.value="<%= id%>";
							self.close();
						}
					</script>
		<%}else{%>		
				<form action="f_popup.jsp" method="post">
					<table>
						<tr>
							<td>
								이미 등록된 아이디입니다. <br/>
								<input type="text" name="id" autofocus/>
								<input type="submit" value="중복확인" />  
							</td>
						</tr>
					</table>
				</form>
				
				
			</body>
		<% }	
 	}else{ %>
	<script>
		alert("접근 오류");
		window.location.href="e_main.jsp";
	</script>
<%	
}%>

</html>
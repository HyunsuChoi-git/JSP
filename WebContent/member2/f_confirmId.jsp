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
<%--중복확인 팝업 만들기 --%>

<% ///////////////////////// 로그인 상태에서 접근 할 경우
String sId = (String)session.getAttribute("sId");
String pw = null, auto = null;
if(sId != null){
%>
	<script>
		alert("이미 로그인 된 상태입니다.");
		window.location.href="c_main.jsp";
	</script>
<% 	
}else{
	//새션이 존재하지 않으나 쿠키가 존재하면 로그인프로페이지로 이동하여 세션생성
	Cookie[] coo = request.getCookies();
	for(Cookie c : coo){
		if(c.getName().equals("cId")) sId = c.getValue();
		if(c.getName().equals("cPw")) pw = c.getValue();
		if(c.getName().equals("cAuto")) auto = c.getValue();
	}
	if(sId != null && pw != null && auto != null){ %>
		<script>
			alert("로그인이 되어있는 상태입니다.");
			window.location.href="b_loginPro.jsp";
		</script>		
<%	}
}	
/////////////////////////////////////////////

	request.setCharacterEncoding("UTF-8");
	
	//주소 뒤에 붙혀온 파라미터 받기
	String id = request.getParameter("id");
	
///////회원가입 란을 거치지 않고 그냥 이 창에 접근 했을 경우. (로그인 상태가 아닐 때)
	if(id == null){ %>
		<script>
			alert("잘못된 경로입니다.");
			window.location.href="c_main.jsp";
		</script>		
<% 	}
/////////////////////////////////////////////
	
	
	//DB 연결하여 ID가 존재하는 지 확인하기
	MemberDAO dao = new MemberDAO();
	boolean check = dao.confirmId(id);
	
	// check == false 일 경우 DB에 존재하지 않는 아이디
	// check == true 일 경우 이미 존재하는 아이디
	if(check){ %>		
		<body>
		<br/>
		<br/>
			<form action="f_confirmId.jsp" method="post">
				<table> <%-- 다시 id 를 입력할 수 있는 입력폼 --%>
					<tr>
						<td><%=id %>는 이미 사용중인 아이디입니다. <br/>
						<input type="text" name="id" />
						<input type="submit" value="ID중복확인" /></td>
					</tr>
				</table>
			</form>
		</body>
	<% }else{ %>
		<body>
			<br/>
			<br/>		
			<table>
				<tr>
					<td><%=id %>는 사용가능한 아이디 입니다. <br/>
					<input type="button" value="닫기" onclick="setId()"/>
					</td>
				</tr>
			</table>
		</body>		
		<script>
		 	function setId(){
		 		//signin페이지의 id 기입 input태그에 위에서 검사한 input적용 시키기
		 		opener.document.signIn.id.value="<%=id%>";
		 		//팝업창 화면 닫기
		 		self.close();
		 	}
		</script>
<% 	}%>
</html>

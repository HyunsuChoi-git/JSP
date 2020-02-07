<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	1.<br/>
	<h2>기존 자바코드  :  <%=request.getAttribute("num") %></h2>
	<h2>기존 자바코드  :  <%=request.getAttribute("id") %></h2>
	<h2>EL : ${ requestScope.num }</h2>
	<h2>EL : ${ requestScope.name }</h2>
	
	<br/>
	2.
	<h2>기존  : <%= request.getAttribute("data") %></h2>
	<h2>EL  :  ${data}</h2>
	<br/>
	
	
	3.<br/>
	<%-- <h2>기본  :  <%=(Integer)request.getAttribute("age")+10 %></h2>  --%>
	<h2>EL  :  ${age + 10}</h2>
	<h2>EL  :  ${age + "10"}</h2>
	<%-- <h2>EL  :  ${age+"Hello" }</h2> --%>
	<h2>EL  :  ${age;"Hello" }</h2>
	
	<br/>
	4.
	<h2>num = ${num }</h2>
	<!-- request와 session의 이름이 동일하기 때문에 request 값을 먼저 가져온다. -->
	<h2>memId = ${memId }</h2>

	<h2>num = ${sessionScope.num }</h2>
	<h2>num = ${sessionScope.memId }</h2>
	
	
	<br/>
	5.
	<h2>arr  :  ${arr}</h2>
	<h2>arr  :  ${arr[0]}</h2>
	<h2>arr  :  ${arr[1]}</h2>
	<h2>arr  :  ${arr[2]}</h2>
	<h2>arr  :  ${arr[3]}</h2>
	<h2>arr  :  ${arr[4]}</h2>
	
	
	<br/>
	6.
	<h2>list  :  ${list}</h2>
	<h2>list  :  ${list.get(0)}</h2> 
	<h2>list  :  ${list[1]}</h2>  <!-- 이것도 됨!! -->
	
	
	<br/>
	7.
	<h2>vo  :  ${vo}</h2>
	<h2>vo  :  ${vo.getId()}</h2>
	<h2>vo  :  ${vo.id}</h2>  <!-- 이것두 됨!! -->
	<h2>vo  :  ${vo.name}</h2> 
	<h2>vo  :  ${vo.age}</h2> 
	
    <br/>
    8. param 으로 넘어온 값 출력
    
    <h2>id  :  ${requestScope.id}</h2>
    <h2>pw  :  ${requestScope.pw}</h2>
    <h2>id  :  <%=request.getAttribute("id") %></h2>
    <h2>pw  :  <%=request.getAttribute("pw") %></h2>
	
</body>
</html>
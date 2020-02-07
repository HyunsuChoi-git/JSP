<%@page import="web.jsp0207.mvc.TestVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	 #1. 변수 선언 <br/>
	<c:set var="id" value="hera" />
	<c:set var="name">헤라</c:set>
	<h2>id : ${id}</h2>
	<h2>name : ${name}</h2>
	
	 #2. 변수 삭제 <br/>
	<c:remove var="id" />
	<c:remove var="name" />
	<h2>id : ${id}</h2>
	<h2>name : ${name}</h2>
	
	 #3. if  <br/>
	<c:set var="num" value="100" />
	<c:if test="${num >= 100}">
		<h2>${num}은 100보다 크거나 같다.</h2>
	</c:if>
	<c:if test="${num < 100}">
		<h2>${num}은 100보다 작다.</h2>
	</c:if>
	
	#4. choose <br/>
	<c:choose>
		<c:when test="${num > 100}">
			<h2>100보다 크다.</h2>
		</c:when>
		<c:when test="${num < 100}">
			<h2>100보다 작다.</h2>
		</c:when>
		<c:otherwise>
			<h2>100과 같다.</h2>
		</c:otherwise>
	</c:choose>
	
	
	#5. forEach : 반복문 (업그레이드for문) <br/>
	<c:set var="arr" value="<%=new int[]{1,2,3,4,5} %>" />
	<c:forEach var="i" items="${arr}">
		<h2>${i}</h2>
	</c:forEach>
	
	
	<% for(int i = 0; i < 10; i++){
		System.out.println(i);
	} %>
	<c:forEach var="i" begin="0" end="9" step="1">
		${i}
	</c:forEach>
	<br/>
	
	<%-- 구구단 2단 부터 9단 출력 --%>
	
	<c:forEach var="i" begin="2" end="9" step="1">
		<c:forEach var="j" begin="1" end="9" step="1">
			${i} X ${j} = ${i*j} <br/>	
		</c:forEach>
	</c:forEach>
	
	<c:forEach var="i" begin="2" end="9" step="1">
		<h5>${i}단</h5>
		<c:forEach var="j" begin="1" end="9" step="1">
			${i}X${j}=${i*j} 
		</c:forEach>
	</c:forEach>
	
	<c:forEach var="i" items="${arr}" varStatus="status">
		<h2> ${status.count} : ${status.index} : ${status.current} </h2>
	</c:forEach>
	
	#6. forToken : 구분기호(delims)로 items를 끊어주는 태그
	<c:forTokens var="a" items="a,b,c,d,e,f,g" delims=",">
		${a} 
	</c:forTokens>
	
	<c:url var="u" value="test.jsp">
		<c:param name="id" value="hera2" />
		<c:param name="pw" value="1234" />
	</c:url>
	
	<c:redirect url="${u}"/>
	
	
	<c:out value="${num}" />
	
</body>
</html>
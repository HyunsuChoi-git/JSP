<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script>
	/*jquery 방식. 
	# 페이지에 접근하면 바로 실행됨
	1. 함수로 묶기
	$(function(){
		alert("jquery function");
	})
	
	2. 문서를 불러 jquery로 묶기
	$(document).ready(function(){
		alert("jQuery ready");
	})
	
	# 버튼 누르면 실행되도록 하기
	*/
	$(document).ready(function(){
		//무조건 바로 실행되는 영역
		$("input").click(function(){
			// input 버튼을 클릭했을 때 실행되는 영역
			alert("jquery btn clicked!!!");
		});
	})
	
	
	
	/*기존 script 방식*/
	function test(){
		alert("test!!");
	}
</script>
</head>
<body>
	
	<input type="button" value="btnJS" onclick="test()" />
	<input type="button" value="btnJQuery" onclick="test()" />
	
</body>
</html>
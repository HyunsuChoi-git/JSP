<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script>
	$(document).ready(function(){
		$("button").click(function(){
			$("img").attr("src", "main5.jpg");
		});
		
		
	});
</script>
</head> 
<body>
	<button>클릭클릭</button>
	<br/><br/>
	<img src="main2.jpg" />
</body>
</html>
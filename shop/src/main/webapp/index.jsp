<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%=session.getAttribute("user")%><!-- customer / employee -->
	<br>
	<%=session.getAttribute("id")%><!-- 로그인 아이디 -->
	<br>
	<%=session.getAttribute("name")%><!-- 로그인 이름  -->
	<br>
	
</body>
</html>
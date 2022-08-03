<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
 <%	
	
	if (session.getAttribute("user") == null) {
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		System.out.println("없음");
		return;
	}
 //
%>   
    
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
	<a href="<%=request.getContextPath()%>/logout.jsp">로그아웃</a>
	
</body>
</html>
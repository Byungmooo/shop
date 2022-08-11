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
 <fieldset>
 <h1>회원 정보</h1>
 	<table>
		<h2><%=session.getAttribute("user")%></h2><!-- customer / employee -->
		<hr>
		<p><%=session.getAttribute("name")%> 님 반갑습니다!</p><!-- 로그인 이름  -->
		<hr>
		<p>LoginID : <%=session.getAttribute("id")%></p><!-- 로그인 아이디 -->
		<hr>

	<br>
	</table>
	<a href="<%=request.getContextPath()%>/logout.jsp"><button>로그아웃</button></a>
	<a href="<%=request.getContextPath()%>/removeIdForm.jsp"><button>회원 탈퇴</button></a>
	<a href="<%=request.getContextPath()%>/admin/adminIndex.jsp"><button>관리자페이지</button></a>
</fieldset>
</body>
</html>
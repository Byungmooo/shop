<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
if (session.getAttribute("user") == null && session.getAttribute("active").equals("Y")) {
	response.sendRedirect(request.getContextPath() + "/adminIndex.jsp");
	System.out.println("없음");
	return;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>adminIndex</title>
</head>
<body>
	<h3>Admin Index</h3>
	<hr>
	<div>
		<a href="<%=request.getContextPath()%>/admin/adminIndex.jsp"><button>홈으로</button></a>
		<!-- index -->
		<a href="<%=request.getContextPath()%>/admin/employeeList.jsp"><button>사원관리</button></a>

		<a href="<%=request.getContextPath()%>/admin/adminGoodsList.jsp"><button>상품관리</button></a>
		<!-- 상품목록 / 동록 / 수정(품절) / 삭제(장바구니, 주문이 없는 경우) -->

		<a href="<%=request.getContextPath()%>/admin/adminCustomerList.jsp"><button>고객관리</button></a>
		<!-- 고객목록 / 강제탈퇴 / 비번수정(전달구현 x) -->

		<a href="<%=request.getContextPath()%>/admin/adminOrderList.jsp"><button>주문관리</button></a>
		<!-- 주문목록 / 수정 -->

		<a href="<%=request.getContextPath()%>/admin/adminNoticeList.jsp"><button>공지관리</button></a>
		<!-- 공지 CRUD -->
		<a href="<%=request.getContextPath()%>/logout.jsp"><button>로그아웃</button></a>
		<!-- 로그아웃 -->
	</div>
	<hr>

	<!-- 메인내용 -->
	<h1>사원관리</h1>
	<div>
		<!-- 사원목록, acticve값 수정 -->
	</div>
</body>
</html>
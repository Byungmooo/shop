<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="service.*" %>
<%@ page import="java.util.*" %>
<%
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	
	OrdersService ordersService = new OrdersService();
	
	Map<String, Object> map = ordersService.getOrdersOne(orderNo);
	
	if(map == null) {
		response.sendRedirect(request.getContextPath() + "/admin/adminGoodsList.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<div>
			<h3>OrdersOne</h3>
		</div>
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

		<div>
	
			<div>
				<table border="1">
					<tr>
						<th>ORDER_NO</th>
						<td><%=map.get("orderNo")%></td>
					</tr>
					<tr>
						<th>CUSTOMER_ID</th>
						<td><%=map.get("customerId")%></td>
					</tr>
					<tr>
						<th>GOODS_NAME</th>
						<td><%=map.get("goodsName")%></td>
					</tr>
					<tr>
						<th>GOODS_PRICE</th>
						<td><%=map.get("goodsPrice")%> (원)</td>
					</tr>
					<tr>
						<th>ORDERS_STATE</th>
						<td><%=map.get("orderState")%></td>
					</tr>
					<tr>
						<th>ORDERS_DATE</th>
						<td><%=map.get("createDate")%></td>
					</tr>
				</table>
			</div>
		</div>
		<div>
			<a href="<%=request.getContextPath()%>/"><button>UPDATE</button></a> 
			<a href="<%=request.getContextPath()%>/"><button>DELETE</button></a>	
		</div>
	</div>
</body>
</html>
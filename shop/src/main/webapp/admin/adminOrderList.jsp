<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="service.*"%>
<%@ page import="vo.*"%>
<%
	request.setCharacterEncoding("utf-8");

	if (session.getAttribute("user") == null && session.getAttribute("active").equals("Y")) {
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		System.out.println("없음");
		return;
	}	

	// 현재 페이지
	int currentPage = 1;
	int lastPage;
	if (request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	// 화면에 띄울 페이지수
	final int ROW_PER_PAGE = 10;
	
	// list값 및 lastPage 계산
	OrdersService ordersService = new OrdersService();
	List<Map<String, Object>> list = new ArrayList<>();
	
	list = ordersService.getOrdersList(ROW_PER_PAGE, currentPage);
	// lastPage = goodsService.getGoodsLastPage(ROW_PER_PAGE);
	
	// 페이지 번호에 필요한 변수 계산
	// int startPage = ((currentPage - 1) / ROW_PER_PAGE) * ROW_PER_PAGE + 1;
	// int endPage = (((currentPage - 1) / ROW_PER_PAGE) + 1) * ROW_PER_PAGE;
	
	
	if(list == null) {
		response.sendRedirect(request.getContextPath() + "/admin/adminIndex.jsp");
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
	<div >
		<div >
			<h3>ORDER</h3>
		</div>
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
		<div >	
			<div >
				<table border="1">
					<thead>
						<tr>
							<th>ORDER_NO</th>
							<th>CUSTOMER_ID</th>
							<th>GOODS_NAME</th>
							<th>ORDER_PRICE</th>
							<th>ORDER_ADDRESS</th>
							<th>ORDER_STATE</th>
							<th>ORDER_DATE</th>
						</tr>
					</thead>
					<tbody>
					<%
						for(Map<String, Object> m : list) {
					%>
							<tr>
								<td><a href="<%=request.getContextPath()%>/admin/ordersOne.jsp?orderNo=<%=m.get("orderNo")%>"><%=m.get("orderNo")%></a></td>
								<td><a href="<%=request.getContextPath()%>/admin/customerOrderList.jsp?customerId=<%=m.get("customerId")%>"><%=m.get("customerId")%></a></td>
								<td><%=m.get("goodsName")%></td>
								<td><%=m.get("orderPrice")%></td>
								<td><%=m.get("orderAddr")%></td>
								<td>
									<form action="<%=request.getContextPath()%>/admin/updateOrdersStateAction.jsp" method="post">
										<input type="hidden" name="orderNo" value="<%=m.get("orderNo")%>">
										<select name="orderState">
											<%
												if(m.get("orderState").equals("입금전")) {
											%>
													<option value="입금전" selected="selected">입금전</option>
													<option value="배송준비중">배송준비중</option>
													<option value="배송중">배송중</option>
													<option value="배송완료">배송완료</option>
											<%
												} else if(m.get("orderState").equals("배송준비중")) {
											%>
													<option value="입금전">입금전</option>
													<option value="배송준비중" selected="selected">배송준비중</option>
													<option value="배송중">배송중</option>
													<option value="배송완료">배송완료</option>
											<%
												} else if(m.get("orderState").equals("배송중")) {
											%>
													<option value="입금전">입금전</option>
													<option value="배송준비중">배송준비중</option>
													<option value="배송중" selected="selected">배송중</option>
													<option value="배송완료">배송완료</option>
											<%
												} else {
											%>
													<option value="입금전">입금전</option>
													<option value="배송준비중">배송준비중</option>
													<option value="배송중">배송중</option>
													<option value="배송완료" selected="selected">배송완료</option>
											<%
												}
											%>					
										</select>
									<button type="submit">UPDATE</button>
									</form>
								</td>
								<td><%=m.get("createDate")%></td>
							</tr>
					<%	
						}
					%>
				</table>
			</div>
		</div>
		<div>
			<!-- <input type="text"> -->
			<a href="<%=request.getContextPath()%>/admin/addGoodsForm.jsp" ><button>INSERT</button></a>
		</div>
		
		<%-- <div>
		<!-- 페이지 -->
			<ul class="pagination justify-content-center">
				<!-- 이전  -->
				<%
					if(currentPage > 1) {
				%>	
						<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/admin/adminGoodsList.jsp?currentPage=<%=currentPage-1%>">이전</a></li>
				<%
					}
				%>
				
				<!-- 페이지번호 -->
				<%
					for (int i = startPage; i <= endPage; i++) {
						if (lastPage < endPage) {
	        				endPage = lastPage;
	    				}
				%>
						<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/admin/adminGoodsList.jsp?currentPage=<%=i%>"><%=i%></a></li>
				<%
					}
				%>
				<!-- 다음 -->
				<%
					if(currentPage < lastPage) {
				%>	
						<li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/admin/adminGoodsList.jsp?currentPage=<%=currentPage+1%>">다음</a></li>
				<%
					}
				%>
			</ul>
		</div> --%>
	</div>
</body>
</html>
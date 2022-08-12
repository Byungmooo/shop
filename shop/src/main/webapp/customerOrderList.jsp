<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="service.*"%>
<%@ page import="vo.*"%>
<%
	request.setCharacterEncoding("utf-8");

	if (session.getAttribute("loginEmployee") == null && session.getAttribute("active").equals("Y") || request.getParameter("customerId") == null) {
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		System.out.println("없음");
		return;
	}	

	// 파라미터
	String customerId = request.getParameter("customerId");
	int currentPage = 1;
	int lastPage;
	if (request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.print(customerId + " <-- customerId");
	
	// 화면에 띄울 페이지수
	final int ROW_PER_PAGE = 10;
	
	// list값 및 lastPage 계산
	OrdersService ordersService = new OrdersService();
	List<Map<String, Object>> list = new ArrayList<>();
	
	list = ordersService.getOrdersListByCustomer(customerId, ROW_PER_PAGE, currentPage);
	// lastPage = goodsService.getGoodsLastPage(ROW_PER_PAGE);
	
	// 주문자 이름
	String name = list.get(0).get("customerName").toString();
	
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
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<style>
	ul li {list-style-type: none; margin-bottom: 50px; margin-top: 50px;}
</style>
</head>
<body>
	<div class="container text-center">
		<div class="jumbotron text-center">
			<h1><%=session.getAttribute("user")%></h1>
			<h3>ORDER - <%=name%> 님의 주문내역</h3>
		</div>
		<div style="margin-bottom: 20px; position: relative; left: 450px;">
			<a href="<%=request.getContextPath()%>/index.jsp" class="btn btn-dark">HOME</a>
			<a href="<%=request.getContextPath()%>/logout.jsp" class="btn btn-dark">LOGOUT</a>
		</div>
		<div class="row">
			<div class="col-sm-2">
				<ul>
					<li><a href="<%=request.getContextPath()%>/admin/adminIndex.jsp" class="btn btn-dark">사원관리</a></li>
					
					<li><a href="<%=request.getContextPath()%>/admin/adminGoodsList.jsp" class="btn btn-dark">상품관리</a></li>
					<!-- 상품목록 / 동록 / 수정(품절) / 삭제(장바구니, 주문이 없는 경우) -->
					
					<li><a href="<%=request.getContextPath()%>/admin/adminCustomerList.jsp" class="btn btn-dark">고객관리</a></li>
					<!-- 고객목록 / 강제탈퇴 / 비번수정(전달구현 x) -->
					
					<li><a href="<%=request.getContextPath()%>/admin/adminOrdersList.jsp" class="btn btn-dark">주문관리</a></li>
					<!-- 주문목록 / 수정 -->
					
					<li><a href="<%=request.getContextPath()%>/admin/adminNoticeList.jsp" class="btn btn-dark">공지관리</a></li>
					<!-- 공지 CRUD -->
				</ul>
			</div>		
			<div class="col-sm-10">
				<table class="table table-bordered">
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
								<td><a href="<%=request.getContextPath()%>/admin/ordersOne.jsp?ordersNo=<%=m.get("ordersNo")%>"><%=m.get("ordersNo")%></a></td>
								<td><%=m.get("customerId")%></td>
								<td><%=m.get("goodsName")%></td>
								<td><%=m.get("ordersPrice")%></td>
								<td><%=m.get("ordersAddr")%></td>
								<td>
									<form action="<%=request.getContextPath()%>/admin/updateOrdersStateAction.jsp" method="post">
										<input type="hidden" name="ordersNo" value="<%=m.get("ordersNo")%>">
										<select name="ordersState">
											<%
												if(m.get("ordersState").equals("입금전")) {
											%>
													<option value="입금전" selected="selected">입금전</option>
													<option value="배송준비중">배송준비중</option>
													<option value="배송중">배송중</option>
													<option value="배송완료">배송완료</option>
											<%
												} else if(m.get("ordersState").equals("배송준비중")) {
											%>
													<option value="입금전">입금전</option>
													<option value="배송준비중" selected="selected">배송준비중</option>
													<option value="배송중">배송중</option>
													<option value="배송완료">배송완료</option>
											<%
												} else if(m.get("ordersState").equals("배송중")) {
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
									<button type="submit" class="btn btn-dark">UPDATE</button>
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
			<a href="<%=request.getContextPath()%>/admin/addGoodsForm.jsp" class="btn btn-dark" style="position: relative; left: 450px;">INSERT</a>
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
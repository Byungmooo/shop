<%@page import="java.util.*"%>
<%@page import="service.OrdersService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>

<%
       	if(session.getAttribute("user") == null){
       		response.sendRedirect(request.getContextPath() + "/loginForm.jsp?errorMsg=Not logged in");
       		return;
       	} else if(session.getAttribute("user") != null && "customer".equals((String)session.getAttribute("user"))) {
       		// 관리자가 아닌경우 막기
       		response.sendRedirect(request.getContextPath() + "/index.jsp?errorMsg=No permission");
       	}
		
		// 값 받기
		String customerId = request.getParameter("customerId");
		
		// 페이징
		int currentPage = 1; // 현재페이지
		final int ROW_PER_PAGE = 10; // 묶음

		if(request.getParameter("currentPage") != null){
			// 받아오는 페이지가 있다면 현재페이지변수에 담기
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		// 메서드를 위한 객체생성
		OrdersService ordersService = new OrdersService();
		
		// 마지막페이지 구하는 메서드
		int lastPage = ordersService.lastPage(ROW_PER_PAGE);
		
		// 숫자페이징
		int startPage = ((currentPage - 1) / ROW_PER_PAGE) * ROW_PER_PAGE + 1; // 페이지 시작
		int endPage = startPage + ROW_PER_PAGE - 1; // 페이지 끝
		
		// endPage 와 lastPage 비교
		endPage = Math.min(endPage, lastPage);
		
		// 리스트
		List<Map<String, Object>> list = ordersService.getOrdersListByCustomer(customerId, ROW_PER_PAGE, currentPage);
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
		<h1><%=customerId%>님의 주문관리</h1>
		<%
			if(request.getParameter("errorMsg") != null){
		%>
			<span><%=request.getParameter("errorMsg")%></span>
		<%
			}
		%>
		<table border="1">
	            		<thead>
		            		<tr>
		            			<th>주문번호</th>
		            			<th>상품번호</th>
		            			<th>상품명</th>
		            			<th>주문수량</th>
		            			<th>주문가격</th>
		            			<th>배송지</th>
		            			<th>주문상태</th>
		            			<th>주문일자</th>
		            			<th>수정일자</th>
		            		</tr>
	            		</thead>
	            		<tbody>
		            		<%
		            			for(Map<String, Object> m : list){
		            		%>
				            		<tr>
				            			<td>
				            				<a href="<%=request.getContextPath()%>/admin/adminOrdersListByorderNo.jsp?orderNo=<%=m.get("orderNo")%>">
				            					<%=m.get("orderNo")%>
				            				</a>
				            			</td>
				            			<td><%=m.get("goodsNo")%></td>
				            			<td><%=m.get("goodsName")%></td>
				            			<td><%=m.get("orderQuantity")%></td>
				            			<td><%=m.get("orderPrice")%></td>
				            			<td><%=m.get("orderAddr")%></td>
				            			<td>	
				            			
				            				<form action="<%=request.getContextPath()%>/admin/updateOrderState.jsp" method="post">
				            					<input name="orderNo" value="<%=m.get("orderNo")%>">
				            					<input name="path" value="adminOrdersListById.jsp?customerId=<%=customerId%>">
					            				<select name="orderState">
					            					<option value="<%=m.get("orderState")%>"><%=m.get("orderState")%></option>
					            					<option value="결제완료">결제완료</option>
					            					<option value="상품준비중">상품준비중</option>
					            					<option value="배송준비중">배송준비중</option>
					            					<option value="배송중">배송중</option>
					            					<option value="배송완료">배송완료</option>
					            					<option value="취소">취소</option>
					            				</select>
					            				<button type="submit" class="btn">변경</button>
				            				</form>
				            				
				            			</td>
				            			<td><%=m.get("createDate")%></td>
				            			<td><%=m.get("updateDate")%></td>
				            		</tr>
			            	<%
		            			}
		            		%>
	
	            		</tbody>
	           </table>		
		
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="service.*" %>
<%
	request.setCharacterEncoding("utf-8");

	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	String orderState = request.getParameter("orderState");
	
	System.out.println(orderNo);
	System.out.println(orderState);
	
	Orders orders = new Orders();
	OrdersService ordersService = new OrdersService();
	
	orders.setOrderNo(orderNo);
	orders.setOrderState(orderState);
	
	boolean result = ordersService.modifyOrdersState(orders);
	
	if(result) {
		response.sendRedirect(request.getContextPath() + "/admin/adminOrderList.jsp");
		System.out.println("성공");
	} else {
		response.sendRedirect(request.getContextPath() + "/admin/adminOrderList.jsp");
		System.out.println("실패");
	}
%>
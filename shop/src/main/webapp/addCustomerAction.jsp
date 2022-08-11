<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="service.*" %>
<%
	String customerId = request.getParameter("customerId");
	String customerPass = request.getParameter("customerPass");
	String customerName = request.getParameter("customerName");
	String customerAddress = request.getParameter("customerAddress");
	String customerTelephone = request.getParameter("customerTelephone");
	
	System.out.println(customerId + " <-- customerId");
	System.out.println(customerPass + " <-- customerPass");
	System.out.println(customerName + " <-- customerName");
	System.out.println(customerAddress + " <-- customerAddress");
	System.out.println(customerTelephone + " <-- customerTelephone");
	
	Customer customer = new Customer();
	CustomerService customerService = new CustomerService();
	customer.setCustomerId(customerId);
	customer.setCustomerPass(customerPass);
	customer.setCustomerName(customerName);
	customer.setCustomerAddress(customerAddress);
	customer.setCustomerTelephone(customerTelephone);
	
	boolean result = customerService.addCustomer(customer);
	
	if(result) {
		System.out.println(result + "성공");
		response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
	} else {
		System.out.println(result + "실패");
		response.sendRedirect(request.getContextPath() + "/addCustomer.jsp");
	}
%>

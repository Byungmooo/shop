<%@page import="vo.*"%>
<%@page import="model.*"%>
<%@ page import = "java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
	//인코딩
	request.setCharacterEncoding("utf-8");
	//전송받은 값
	String customerId = request.getParameter("customerId");
	String customerPass = request.getParameter("customerPass");
	//전송받은 값을 customer 객체에 삽입
	Customer customer = new Customer();
	customer.setCustomerId(customerId);
	customer.setCustomerPass(customerPass);
//
	CustomerDao customerDao = new CustomerDao();

	Customer customerLogin = customerDao.Customerlogin(customer);
 	
 	if(customerLogin != null){	//로그인되면
 		//session 값 설정
 		session.setAttribute("user", "customer");
 		session.setAttribute("id", customerLogin.getCustomerId());
 		session.setAttribute("name", customerLogin.getCustomerName());
 		System.out.println("로그인성공");
 		
 		response.sendRedirect(request.getContextPath()+"/index.jsp");
 	} else {
 		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?errorMsg=check your id or password");
 		System.out.println("로그인실패");
 	}
%>
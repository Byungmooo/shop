<%@page import="vo.*"%>
<%@page import="repository.*"%>
<%@ page import="service.CustomerService"%>
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

	CustomerService customerService = new CustomerService();
	Customer loginCustomer = new Customer();
	loginCustomer = customerService.getCustomerByidAndPw(customer);
			
 	if(loginCustomer != null){	//로그인되면
 		//session 값 설정
 		session.setAttribute("user", "customer");
 		session.setAttribute("id", loginCustomer.getCustomerId());
 		session.setAttribute("name", loginCustomer.getCustomerName());
 		//페이지넘기기
 		response.sendRedirect(request.getContextPath()+"/index.jsp");
 		
 		//디버깅
		System.out.println("user : " + session.getAttribute("user") );
		System.out.println("id : " + session.getAttribute("id") );
		System.out.println("name : " + session.getAttribute("name") );
 		System.out.println("로그인성공");
 		
 	} else {
 		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?errorMsg=check your id or password");
 		System.out.println("로그인실패");
 	}
%>
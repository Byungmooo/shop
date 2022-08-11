<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ page import="service.CustomerService"%>
<%@ page import="vo.Customer"%>

<%	
	boolean removeComplete = false;

	// customer 인가 employee 인가 분기 위한 값
	String user = (String)session.getAttribute("user");
	
	// 받을 값
	String id = (String)session.getAttribute("id");
	String pass = request.getParameter("pass");
	
	// customer 객체에 setter
	Customer customer = new Customer();
	customer.setCustomerId(id);
	customer.setCustomerPass(pass);
	
	// delete 메서드 실행하기 위한 객체 생성
	CustomerService customerService = new CustomerService();
	removeComplete = customerService.removeCustomer(customer);
	
	// 디버깅 및 재요청 (분기)
		if(removeComplete){
			System.out.println("remove 성공");
			session.invalidate(); // 세션 비우기
			// 재요청
			response.sendRedirect(request.getContextPath() + "/loginForm.jsp");
		} else {
			System.out.println("remove 실패");
			// 재요청
			response.sendRedirect(request.getContextPath() + "/index.jsp?errorMsg=remove Fail");
		}
%>
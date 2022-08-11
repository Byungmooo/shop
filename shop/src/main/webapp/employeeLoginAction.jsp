<%@page import="repository.*"%>
<%@page import="vo.*"%>
<%@ page import="service.EmployeeService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//인코딩
	request.setCharacterEncoding("utf-8");

	//전송받은 값
	String employeeId = request.getParameter("employeeId");
	String employeePass = request.getParameter("employeePass");
	
	//전송받은 값을 customer 객체에 삽입
	Employee employee = new Employee();
	employee.setEmployeeId(employeeId);
	employee.setEmployeePass(employeePass);
	
	EmployeeService employeeService = new EmployeeService();
	Employee loginEmployee = new Employee();
	loginEmployee = employeeService.getEmployeeByidAndPw(employee);
	

 	if(loginEmployee != null){	//로그인되면
 		//session 값 설정
 		session.setAttribute("user", "employee");
 		session.setAttribute("id", loginEmployee.getEmployeeId());
 		session.setAttribute("name", loginEmployee.getEmployeeName());
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
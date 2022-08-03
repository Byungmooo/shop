<%@page import="model.*"%>
<%@page import="vo.*"%>

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
//
	EmployeeDao employeeDAO = new EmployeeDao();

	Employee EmployeeLogin = employeeDAO.employeelogin(employee);
 	
 	if(EmployeeLogin != null){	//로그인되면
 		//session 값 설정
 		session.setAttribute("user", "employee");
 		session.setAttribute("id", EmployeeLogin.getEmployeeId());
 		session.setAttribute("name", EmployeeLogin.getEmployeeName());
 		System.out.println("로그인성공");
 		//페이지 넘겨주기
 		response.sendRedirect(request.getContextPath()+"/index.jsp");
 	} else {
 		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?errorMsg=check your id or password");
 		System.out.println("로그인실패");
 	}
%>
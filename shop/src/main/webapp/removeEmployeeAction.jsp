<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ page import="service.EmployeeService"%>
<%@ page import="vo.Employee"%>

<%	
	boolean removeComplete = false;

	// customer 인가 employee 인가 분기 위한 값
	String user = (String)session.getAttribute("user");
	
	// 받을 값
	String id = (String)session.getAttribute("id");
	String pass = request.getParameter("pass");
	
	// employee 객체에 setter
	Employee employee = new Employee();
	employee.setEmployeeId(id);
	employee.setEmployeePass(pass);
			
	// delete 메서드 실행하기 위한 객체 생성
	EmployeeService employeeService = new EmployeeService();
	removeComplete = employeeService.removeEmployee(employee);
	
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
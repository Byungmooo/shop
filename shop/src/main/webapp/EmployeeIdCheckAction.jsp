<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="service.*" %>
<%
	String ckId = request.getParameter("ckId");
	System.out.println(ckId);

	SignService idCheck = new SignService();
	boolean result = idCheck.idCheck(ckId);
	
	if(result) {// service -> true
		response.sendRedirect(request.getContextPath()+"/addEmployee.jsp?ckId="+ckId);	
	} else {// service -> false
		response.sendRedirect(request.getContextPath()+"/addEmployee.jsp?errorMsg=badId");
	}

%>
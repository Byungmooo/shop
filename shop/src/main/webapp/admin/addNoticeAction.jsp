<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<%@ page import="service.NoticeService"%>
<%@ page import="vo.Notice"%>

<%
String dir = request.getServletContext().getRealPath("/upload");
int max = 10 * 1024 * 1024; // 10mb
MultipartRequest mRequest = new MultipartRequest(request, dir, max, "utf-8", new DefaultFileRenamePolicy());

// parameter
// goods
String noticetitle = mRequest.getParameter("noticeTitle");
String noticecontent = mRequest.getParameter("noticeContent");


// 디버깅	
System.out.println("addGoodsAction.jsp noticeTitle : " + noticetitle);
System.out.println("addGoodsAction.jsp noticecontent : " + noticecontent);


// setter 
Notice notice = new Notice();
notice.setNoticeTitle(noticetitle);
notice.setNoticeContent(noticecontent);
System.out.println(notice);



// 메소드 호출
NoticeService noticeService = new NoticeService();

//int goodsNo = noticeService.addNotice(notice);


	

//response.sendRedirect(request.getContextPath() + "/admin/GoodsOne.jsp?goodsNo=" + goodsNo);
response.sendRedirect(request.getContextPath() + "/admin/adminNoticeList.jsp");
%>
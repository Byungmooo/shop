<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="service.*"%>
<%@ page import="vo.*"%>
<%
request.setCharacterEncoding("utf-8");

if (session.getAttribute("user") == null && session.getAttribute("active").equals("Y")) {
	response.sendRedirect(request.getContextPath() + "/index.jsp");
	System.out.println("없음");
	return;
}

// 페이징값
int currentPage = 1;
if (request.getParameter("currentPage") != null) {
	currentPage = Integer.parseInt(request.getParameter("currentPage"));
}
final int ROW_PER_PAGE = 10;

EmployeeService employeeService = new EmployeeService();
List<Employee> list = new ArrayList<Employee>();
list = employeeService.getEmployeeList(ROW_PER_PAGE, currentPage);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EmployeeList</title>
</head>
<body>
	<h3>EmployeeList</h3>
	<hr>
	<div>
		<a href="<%=request.getContextPath()%>/admin/adminIndex.jsp"><button>홈으로</button></a>
		<!-- index -->
		<a href="<%=request.getContextPath()%>/admin/employeeList.jsp"><button>사원관리</button></a>

		<a href="<%=request.getContextPath()%>/admin/adminGoodsList.jsp"><button>상품관리</button></a>
		<!-- 상품목록 / 동록 / 수정(품절) / 삭제(장바구니, 주문이 없는 경우) -->

		<a href="<%=request.getContextPath()%>/admin/adminCustomerList.jsp"><button>고객관리</button></a>
		<!-- 고객목록 / 강제탈퇴 / 비번수정(전달구현 x) -->

		<a href="<%=request.getContextPath()%>/admin/adminOrderList.jsp"><button>주문관리</button></a>
		<!-- 주문목록 / 수정 -->

		<a href="<%=request.getContextPath()%>/admin/adminNoticeList.jsp"><button>공지관리</button></a>
		<!-- 공지 CRUD -->
		<a href="<%=request.getContextPath()%>/logout.jsp"><button>로그아웃</button></a>
		<!-- 로그아웃 -->
	</div>
	<hr>
	<div class="container text-center">
		<table border="1">
			<thead>
				<tr>
					<th>EMPLOYEEID</th>
					<th>EMPLOYEENAME</th>
					<th>CREATEDATE</th>
					<th>EMPLOYEEACTIVE</th>
				</tr>
			</thead>
			<tbody>
				<%
				for (Employee e : list) {
				%>
				<tr>
					<td><%=e.getEmployeeId()%></td>
					<td><%=e.getEmployeeName()%></td>
					<td><%=e.getCreateDate()%></td>
					<td>
						<form
							action="<%=request.getContextPath()%>/updateEmployeeActiveAction.jsp"
							method="post">
							<input type="hidden" name="employeeId"
								value="<%=e.getEmployeeId()%>"> <select name="active">
								<%
								if (e.getActive().equals("N")) {
								%>
								<option value="Y">Y</option>
								<option value="N" selected="selected">N</option>
								<%
								} else {
								%>
								<option value="Y" selected="selected">Y</option>
								<option value="N">N</option>
								<%
								}
								%>
							</select>
							<button type="submit" class="btn btn-dark">권한변경</button>
						</form>
					</td>
				</tr>
				<%
				}
				%>
			
		</table>
	</div>
	<!--  페이징 -->
	<%-- <div>
		<ul class="pagination pagination-sm">
			<!-- 이전 -->
			<%					

					if(currentPage > 1) {
			%>			
					<li class="page-item"><a class="page-link"
							href="./boardList.jsp?currentPage=<%=currentPage - 1%>">이전</a></li>
			<%
					}

			%>
			
			<!-- 페이지 번호 -->
			<%	
			 	int pageCount = 10;
				int startPage = ((currentPage - 1) / pageCount) * pageCount + 1;
		    	int endPage = (((currentPage - 1) / pageCount) + 1) * pageCount;
		    	if (lastPage < endPage) {
       				endPage = lastPage;
   				}
		    	
		    	if(currentPage < lastPage) {
					%>								
  					<li class="page-item"><a class="page-link"
  							href="./boardList.jsp?currentPage=<%=i%>"><%=i%></a></li>
  				<%
  					}
			%>
		</ul>
	</div> --%>

</body>
</html>
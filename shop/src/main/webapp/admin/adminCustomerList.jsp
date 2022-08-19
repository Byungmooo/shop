<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ page import = "service.*" %>
<%@ page import = "vo.Customer" %>

<%
       	if(session.getAttribute("id") == null){
       		response.sendRedirect(request.getContextPath() + "/theme/loginForm.jsp?errorMsg=Not logged in");
       		return;
       	} else if(session.getAttribute("id") != null && "customer".equals((String)session.getAttribute("user"))) {
       		// 관리자가 아닌경우 막기
       		response.sendRedirect(request.getContextPath() + "/theme/index.jsp?errorMsg=No permission");
       	}
	
		// 페이징
		int currentPage = 1; // 현재페이지
		final int ROW_PER_PAGE = 10; // 묶음

		if(request.getParameter("currentPage") != null){
			// 받아오는 페이지가 있다면 현재페이지변수에 담기
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		// 메서드를 위한 객체생성
		CustomerService customerService = new CustomerService();
		
		// 마지막페이지 구하는 메서드
		int lastPage = customerService.lastPage(ROW_PER_PAGE);
				
		
		// 숫자페이징
		int startPage = ((currentPage - 1) / ROW_PER_PAGE) * ROW_PER_PAGE + 1; // 시작페이지값 ex) ROW_PER_PAGE 가 10 일경우 1, 11, 21, 31
		int endPage = startPage + ROW_PER_PAGE - 1; // 끝페이지값 ex) ROW_PER_PAGE 가 10 일경우 10, 20, 30, 40
		// endPage 는 lastPage보다 크면 안된다
		endPage = Math.min(endPage, lastPage); // 두 값의 최소값이 endPage가 된다
		
		
		// 리스트
		List<Customer> list = customerService.getCustomerList(ROW_PER_PAGE, currentPage);
		
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<div>
			<h3>GOODS LIST</h3>
		</div>
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
		<table border="1">
	            		<thead>
		            		<tr>
		            			<th>고객아이디</th>
		            			<th>고객이름</th>
		            			<th>고객주소</th>
		            			<th>고객핸드폰</th>
		            			<th>가입날짜</th>
		            			<th>정보수정날짜</th>
		            			<th>비밀번호수정</th>
		            			<th>삭제</th>
		            		</tr>
	           </thead>
	           <tbody>
	           		            		<%
		            			for(Customer c : list){
		            		%>
				            		<tr>
				            			<td>
				            				<a href="<%=request.getContextPath()%>/admin/adminOrdersListById.jsp?customerId=<%=c.getCustomerId()%>">
				            					<%=c.getCustomerId()%>
				            				</a>
				            			</td>
				            			<td><%=c.getCustomerName()%></td>
				            			<td><%=c.getCustomerAddress()%></td>
				            			<td><%=c.getCustomerTelephone()%></td>
				            			<td><%=c.getCreateDate()%></td>
				            			<td><%=c.getUpdateDate()%></td>
				            			<td>
				            				<a href="<%=request.getContextPath()%>/admin/adminUpdateCustomer.jsp?customerId=<%=c.getCustomerId()%>" class="btn">수정</a>
				            			</td>
				            			<td>
				            				<a href="<%=request.getContextPath()%>/admin/adminDeleteCustomer.jsp?customerId=<%=c.getCustomerId()%>" class="btn">삭제</a>
				            			</td>
				            		</tr>
			            	<%
		            			}
		            		%>
	            		</tbody>
	            	</table>
				<div>
				<table>
                   <tr>
                    <%
	            		if(currentPage > 1){
	            	%>
		            		 <td>
	                            <a href="<%=request.getContextPath()%>/admin/adminCustomerList.jsp?currentPage=<%=currentPage-1%>">pre</a>
	                         </td>	
	            	<%
	            		}
                    	
                    	// 숫자페이징
                    	for(int i = startPage; i <= endPage; i++){
                    		if(i == currentPage){
		            %>
		            			<td>
		            				 <a href="<%=request.getContextPath()%>/admin/adminCustomerList.jsp?currentPage=<%=i%>"><%=i%></a>
		            			</td>
	            	<%
                    		} else {
                	%>
		            			<td>
		            				 <a href="<%=request.getContextPath()%>/admin/adminCustomerList.jsp?currentPage=<%=i%>"><%=i%></a>
		            			</td>
	            	<%			
                    		}
                    	}
                    	
	            		if(currentPage < lastPage){
	            	%>
	                        <td>
	                            <a href="<%=request.getContextPath()%>/admin/adminCustomerList.jsp?currentPage=<%=currentPage+1%>">Next</a>
	                        </td>
                    <%
	            		}
	            	%>
                    </tr>
                    </table>
                </div>


</div>
</body>
</html>
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

GoodsService goodsService = new GoodsService();
List<Goods> list = new ArrayList<Goods>();
list = goodsService.getGoodsListByPage(ROW_PER_PAGE, currentPage);

int lastPage = goodsService.getGoodsLastPage(ROW_PER_PAGE);
System.out.print("lastPage : " + lastPage);

if (list == null) {
	response.sendRedirect(request.getContextPath() + "/admin/adminIndex.jsp");
	return;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>adminGoodsList</title>

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
			<div>
				<table border="1">
					<thead>
						<tr>
							<th>NO</th>
							<th>NAME</th>
							<th>PRICE</th>
							<th>CREATEDATE</th>
							<th>SOLDOUT</th>
						</tr>
					</thead>
					<tbody>
						<%
						for (Goods g : list) {
						%>
						<tr>
							<td><%=g.getGoodsNo()%></td>
							<td>							
								<a href="<%=request.getContextPath()%>/admin/GoodsOne.jsp?goodsNo=<%=g.getGoodsNo()%>">
									<%=g.getGoodsName()%>
							</a>
							</td>
							<td><%=g.getGoodsPrice()%>원</td>
							<td><%=g.getCreateDate()%></td>
							<td>
								<form
									action="<%=request.getContextPath()%>/admin/updateGoodsSoldOutAction.jsp"
									method="post">
									<input type="hidden" name="goodsNo" value="<%=g.getGoodsNo()%>">
									<select name="soldOut">
										<%
										if (g.getSoldOut().equals("N")) {
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
									<button type="submit">UPDATE</button>
								</form>
							</td>
						</tr>
						<%
						}
						%>
					
				</table>
			</div>
		</div>
		<hr>
		<div>
			<%
			if (currentPage > 1) {
			%>
			<a
				href="<%=request.getContextPath()%>/admin/adminGoodsList.jsp?currentPage=<%=currentPage - 1%>">이전</a>
			<%
			}
			if (currentPage < lastPage) {
			%>
			<a
				href="<%=request.getContextPath()%>/admin/adminGoodsList.jsp?currentPage=<%=currentPage + 1%>">다음</a>
			<%
			}
			%>
			<a href="<%=request.getContextPath()%>/admin/addGoodsForm.jsp" style = "margin:325px;"><button>상품추가</button></a>
		</div>
</body>
</html>
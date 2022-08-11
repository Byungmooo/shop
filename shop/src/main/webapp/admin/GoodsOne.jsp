<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="service.*"%>
<%@ page import="java.util.*"%>
<%
int goodsNo = Integer.parseInt(request.getParameter("goodsNo"));

GoodsService goodsService = new GoodsService();

Map<String, Object> map = goodsService.getGoodsAndImgOne(goodsNo);

if (map == null) {
	response.sendRedirect(request.getContextPath() + "/admin/adminGoodsList.jsp");
	return;
}
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
			<h3>GOODS</h3>
		</div>
		<hr>
		<div>
			<a href="<%=request.getContextPath()%>/admin/adminIndex.jsp"><button>홈으로</button></a>
			<!-- index -->

			<a href="<%=request.getContextPath()%>/admin/employeeList.jsp"><button>사원관리</button></a>
			<!-- 사원권한설정 -->

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
			<a href="<%=request.getContextPath()%>/admin/adminGoodsList.jsp"><button>BACK</button></a> 
			<a href="<%=request.getContextPath()%>/logout.jsp"><button>LOGOUT</button></a>
		</div>
		<hr>
			<div>
				<table border="1">
					<tr>
						<th>NO</th>
						<td><%=map.get("goodsNo")%></td>
					</tr>
					<tr>
						<th>NAME</th>
						<td><%=map.get("goodsName")%></td>
					</tr>
					<tr>
						<th>PRICE (원)</th>
						<td><%=map.get("goodsPrice")%></td>
					</tr>
					<tr>
						<th>품절여부</th>
						<td><%=map.get("soldOut")%></td>
					</tr>
					<tr>
						<th>상품이미지</th>
						<td><img
							src="<%=request.getContextPath()%>/upload/<%=map.get("imgFileName")%>"></td>
					</tr>
					<tr>
						<th>등록날짜</th>
						<td><%=map.get("goodsCreateDate")%></td>
					</tr>
					<tr>
						<th>수정날짜</th>
						<td><%=map.get("goodsUpdateDate")%></td>
					</tr>
				</table>
			</div>
			<hr>
		<div>
			<a href="<%=request.getContextPath()%>/"><button>UPDATE</button></a> 
			<a href="<%=request.getContextPath()%>/"><button>DELETE</button></a>
		</div>
	</div>
</body>
</html>
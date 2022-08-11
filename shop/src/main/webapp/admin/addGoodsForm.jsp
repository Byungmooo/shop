<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>add goods form</title>
</head>
<h3>AddGoodsForm</h3>
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

<body>
	<form action="<%=request.getContextPath()%>/admin/addGoodsAction.jsp" method="post" enctype="multipart/form-data">
		<table border="1">
			<tr>
				<td>제품 이름</td>
				<td><input type="text" name="goodsName"></td>
			</tr>
			<tr>
				<td>제품 가격</td>
				<td><input type="text" name="goodsPrice"></td>
			</tr>
			<tr>
				<td>품절 여부</td>
				<td><input type="text" name="soldOut"></td>
			</tr>
			<tr>
				<td>이미지 파일</td>
				<td><input type="file" name="imgFile"></td>
			</tr>
		</table>
		<hr>
		<button type="submit" id="btn">상품추가하기</button>
	</form>
</body>
</html>
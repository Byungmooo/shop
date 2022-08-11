<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<div class="">
		<fieldset>
		<!-- id ck form -->
		<form action="<%=request.getContextPath()%>/CustomerIdCheckAction.jsp" method="post">
		
				<table class="table table-primary">
				<tr>
					<td>ID CHECK<td>
					<td><input type="text" name="ckId" class="form-control"><td>
				
				<button type="submit" class="btn btn-dark">아이디중복검사</button>
				</tr>
				</table>
				
		</form>
		</fieldset>
		<%
			if(request.getParameter("errorMsg") != null) {
		%>
				<span style="color:red"><%=request.getParameter("errorMsg")%></span>
		<%
			}
		%>
		
		<!-- 고객가입 form -->
		<%
			String ckId = "";
			if(request.getParameter("ckId") != null) {
				ckId = request.getParameter("ckId");
			}
		%><fieldset>
		<form action="<%=request.getContextPath()%>/addCustomerAction.jsp" method="get" id="customerForm">
			<table border="1">
				<tr>
					<td>customerId</td>
					<td>
						<input type="text" name="customerId" id="customerId" 
							readonly="readonly" value="<%=ckId%>" class="">
					</td>
				</tr>
				<tr>
					<td>customerPass</td>
					<td>
						<input type="text" name="customerPass" id="customerPass" class="">
					</td>
				</tr>
				<tr>
					<td>customerName</td>
					<td>
						<input type="text" name="customerName" id="customerName" class="">
					</td>
				</tr>
				<tr>
					<td>customerAddress</td>
					<td>
						<input type="text" name="customerAddress" id="customerAddress" class="">
					</td>
				</tr>
				<tr>
					<td>customerTelephone</td>
					<td>
						<input type="text" name="customerTelephone" id="customerTelephone" class="">
					</td>
				</tr>
			</table>
			<hr>
			<button type="submit" id="customerBtn" class="btn btn-dark">회원가입</button>
			<a href="loginForm.jsp"  class="btn btn-dark"><button>취소</button></a>
		</form>
		</fieldset>
	</div>
</body>
<script>
	$('#customerBtn').click(function() {
		if($('#customerId').val() == '') {
			alert('고객아이디를 입력하세요');
		} else if($('#customerPass').val() == '') {
			alert('고객비밀번호를 입력하세요');
		} else if($('#customerName').val() == '') {
			alert('고객이름을 입력하세요');
		} else if($('#customerAddress').val() == '') {
			alert('고객주소를 입력하세요');
		} else if($('#customerTelephone').val() == '') {
			alert('고객전화번호를 입력하세요');
		} else {
			customerForm.submit();
		}
	});
</script>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
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
		<form action="<%=request.getContextPath()%>/EmployeeIdCheckAction.jsp" method="post">
		
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
		
		<!-- 관리자가입 form -->
		<%
			String ckId = "";
			if(request.getParameter("ckId") != null) {
				ckId = request.getParameter("ckId");
			}
		%><fieldset>
		<form action="<%=request.getContextPath()%>/addEmployeeAction.jsp" method="get" id="employeeForm">
			<table border="1">
				<tr>
					<td>employeeId</td>
					<td>
						<input type="text" name="employeeId" id="employeeId" 
							readonly="readonly" value="<%=ckId%>" class="">
					</td>
				</tr>
				<tr>
					<td>employeePass</td>
					<td>
						<input type="text" name="employeePass" id="employeePass" class="">
					</td>
				</tr>
				<tr>
					<td>employeeName</td>
					<td>
						<input type="text" name="employeeName" id="employeeName" class="">
					</td>
				</tr>
			</table>
			<hr>
			<button type="submit" id="employeeBtn" class="btn btn-dark">회원가입</button>
			<a href="loginForm.jsp"  class="btn btn-dark"><button>취소</button></a>
		</form>
		</fieldset>
	</div>
</body>
<script>
	$('#employeeBtn').click(function() {
		if($('#employeeId').val() == '') {
			alert('관리자아이디를 입력하세요');
		} else if($('#employeePass').val() == '') {
			alert('관리자비밀번호를 입력하세요');
		} else if($('#employeeName').val() == '') {
			alert('관리자이름을 입력하세요');
		} else {
			employeeForm.submit();
		}
	});
</script>
</html>
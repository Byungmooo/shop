<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
   <div>
      <form id="customerForm" method="post" action="<%=request.getContextPath()%>/customerLoginAction.jsp">
         <fieldset>
            <legend>쇼핑몰 고객 로그인</legend>
            <table border="1">
               <tr>
                  <td>ID</td>
                  <td><input type="text" name="customerId" id="customerId"></td>
               </tr>
               <tr>
                  <td>PW</td>
                  <td><input type="password" name="customerPass" id="customerPass"></td>
               </tr>
            </table>
            <button type="button" id="customerBtn">고객 로그인</button>
         </fieldset>
      </form>
   </div>
   
   <div>
      <form id="employeeForm" method="post" action="<%=request.getContextPath()%>/employeeLoginAction.jsp"">
         <fieldset>
            <legend>쇼핑몰 스텝 로그인</legend>
            <table border="1">
               <tr>
                  <td>ID</td>
                  <td><input type="text" name="employeeId" id="employeeId"></td>
               </tr>
               <tr>
                  <td>PW</td>
                  <td><input type="password" name="employeePass" id="employeePass"></td>
               </tr>
            </table>
            <button type="button" id="employeeBtn">스텝 로그인</button>
         </fieldset>
      </form>
   </div>
</body>
<script>
   $('#customerBtn').click(function(){
      if($('#customerId').val() == '') {
         alert('고객 아이디를 입력하세요');
      } else if($('#customerPass').val() == '') {
         alert('고객 패스워드를 입력하세요');
      } else {
         customerForm.submit();
      }
   });
   
   $('#employeeBtn').click(function(){
      if($('#employeeId').val() == '') {
         alert('스텝 아이디를 입력하세요');
      } else if($('#employeePass').val() == '') {
         alert('스텝 패스워드를 입력하세요');
      } else {
         employeeForm.submit();
      }
   });
</script>
</html>
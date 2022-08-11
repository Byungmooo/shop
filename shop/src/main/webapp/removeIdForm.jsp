<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%

	String deleteAction = "";
	if(session.getAttribute("user").equals("employee")){
		deleteAction="/removeEmployeeAction";
	} else if (session.getAttribute("user").equals("customer")){
		deleteAction="/removeCustomerAction";
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
      <form id="removeIdForm" method="post" action="<%=request.getContextPath()%><%=deleteAction%>.jsp">
         <fieldset>
            <h1>회원탈퇴</h1>
            <table border="1">
		
                 <p><%=session.getAttribute("user")%></p>
                   <hr>
                 <p>NAME : <%=session.getAttribute("name")%> 님!</p>
                   <hr>
                 <p>ID : <%=session.getAttribute("id")%></p>       
            
               <tr>            
                  <td>PW 확인</td>
                  <td><input type="password" name="pass" id="pass"></td>
               </tr>
            </table>
            <hr>
            <button type="submit" class="btn" id="btn">탈퇴하기</button>
            <a href="<%=request.getContextPath()%>/index.jsp"><button type="button">회원정보</button></a>
         </fieldset>
      </form>

   </div>
</body>
</html>
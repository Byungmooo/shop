package model;
import vo.*;
import java.sql.*;
public class EmployeeDao {
			//로그인
			public Employee employeelogin(Employee employee) throws Exception {
				DBUtil dbUtil = new DBUtil();
				//새로 받아오는 객체
				Employee employeeLogin = null;
				String sql ="SELECT employee_id employeeId, employee_name employeeName FROM employee where employee_id=? and employee_pass=PASSWORD(?)";
				Connection conn = null;
				PreparedStatement stmt = null;
				ResultSet rs = null;
//
				try {
					conn = dbUtil.getConnection();
					System.out.println("db연동");
					stmt = conn.prepareStatement(sql);
					stmt.setString(1, employee.getEmployeeId());
					stmt.setString(2, employee.getEmployeePass());
					System.out.println(stmt + "<< stmt");
					rs = stmt.executeQuery();
					
					if(rs.next()) {
						System.out.println(rs + "<<rs");
						employeeLogin = new Employee();
						employeeLogin.setEmployeeId(rs.getString("employeeId"));
						employeeLogin.setEmployeeName(rs.getString("employeeName"));

					}
				}
				finally {
					rs.close();
					stmt.close();
					conn.close();
				}
				return employeeLogin;
			}
	
}

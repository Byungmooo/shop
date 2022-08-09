package model;

import vo.*;
import java.sql.*;


public class CustomerDao {

	   //customer 로그인
	   public Customer Customerlogin(Customer customer)  throws SQLException,Exception {
		   
		   Customer customerLogin = null;
		    DBUtil dbUtil = new DBUtil();
		    
		    String sql ="SELECT customer_id customerId, customer_pass customerPass, customer_name customerName FROM customer where customer_id=? and customer_pass=PASSWORD(?)";
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;
			
			try {
			
			conn = dbUtil.getConnection();System.out.println("db연동");
			stmt = conn.prepareStatement(sql);
			
			stmt.setString(1, customer.getCustomerId());
			stmt.setString(2, customer.getCustomerPass());
			System.out.println(stmt + "<<stmt");
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				System.out.println(rs + "<<rs");
				customerLogin = new Customer();
				customerLogin.setCustomerId(rs.getString("customerId"));
				customerLogin.setCustomerName(rs.getString("customerName"));
				
				//
				// 디버깅
				System.out.println("login id : " + customerLogin.getCustomerId());
				System.out.println("login name : " + customerLogin.getCustomerName());
			}
			}finally {
				if(rs!=null) {
					rs.close();
				}if(stmt!=null) {
					stmt.close();
				}if(conn!=null) {
					conn.close();
				}
			}
	      return customerLogin;
	   }
	
}

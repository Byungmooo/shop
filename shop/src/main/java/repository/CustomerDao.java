package repository;

import vo.Customer;
import java.sql.*;

public class CustomerDao {

	// 가입
	// CustomerService.addCustomer 가 호출
	public int insertCustomer(Connection conn, Customer paraCustomer) throws SQLException {
		int row = 0;
		String sql = "INSERT INTO customer (customer_id, customer_pass, customer_name, customer_address, customer_telephone, update_date, create_date) VALUES (?, PASSWORD(?), ?, ?, PASSWORD(?), now(), now())";
		PreparedStatement stmt = null;

		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paraCustomer.getCustomerId());
			stmt.setString(2, paraCustomer.getCustomerPass());
			stmt.setString(3, paraCustomer.getCustomerName());
			stmt.setString(4, paraCustomer.getCustomerAddress());
			stmt.setString(5, paraCustomer.getCustomerTelephone());

			row = stmt.executeUpdate();
		} finally {
			if (stmt != null) {
				stmt.close();
			}
		}
		return row;
	}

	// 탈퇴
	// CustomerService.removeCustomer(Customer paramCustomer)가 호출
	public int removeCustomer(Connection conn, Customer paramCustomer) throws Exception {
		// 동일한 conn
		// conn.close() X
		int row = 0;

		String sql = "DELETE FROM customer WHERE customer_id= ? AND customer_pass = PASSWORD(?)";

		PreparedStatement stmt = null;

		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramCustomer.getCustomerId());
			stmt.setString(2, paramCustomer.getCustomerPass());
			row = stmt.executeUpdate();

		} finally {
			stmt.close();
		}

		return row;
	}

	// CustomerService가 호출
	public Customer selectCustomerByidAndPw(Connection conn, Customer paramCustomer) throws Exception {

		String sql = "SELECT customer_id , customer_pass, customer_name, customer_address, customer_telephone , update_date , create_date FROM customer WHERE customer_id=? AND customer_pass = PASSWORD(?)";

		Customer loginCustomer = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramCustomer.getCustomerId());
			stmt.setString(2, paramCustomer.getCustomerPass());
			rs = stmt.executeQuery();

			if (rs.next()) {
				loginCustomer = new Customer();
				loginCustomer.setCustomerId(rs.getString("customer_id"));
				loginCustomer.setCustomerPass(rs.getString("customer_pass"));
				loginCustomer.setCustomerName(rs.getString("customer_name"));
				loginCustomer.setCustomerAddress(rs.getString("customer_address"));
				loginCustomer.setCustomerTelephone(rs.getString("customer_telephone"));
				loginCustomer.setCreateDate(rs.getString("update_date"));
				loginCustomer.setUpdateDate(rs.getString("create_date"));
			}

			System.out.println(loginCustomer.getCustomerId());
			System.out.println(loginCustomer.getCustomerPass());

		} finally {
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}

		}

		return loginCustomer;

	}

}

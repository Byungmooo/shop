package repository;

import vo.Customer;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CustomerDao {

	
	
	
	
	
	///////////고객리스트
	//////////////////////////////////////////////////////////////////////// lastPage
	// CustomerService.lastPage()가 호출
	public int allCount(Connection conn) throws Exception {
		int allCount = 0;
		String sql = "SELECT COUNT(*) count FROM customer";
		
		// 초기화
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			// 쿼리담기
			stmt = conn.prepareStatement(sql);
			// 디버깅
			System.out.println("CustomerDao.java allCount stmt : " + stmt);
			// 쿼리실행
			rs = stmt.executeQuery();
			if(rs.next()) {
				allCount = rs.getInt("count");
			}
		} finally {
			if(rs != null) { rs.close(); }
			if(stmt != null) { stmt.close(); }
		}
		
		return allCount;
	}
	
	//CustomerService.getCustomerList 가 호출
	public  List<Customer> selectCustomerList(Connection conn, final int rowPerPage, final int beginRow) throws SQLException {
		List<Customer> list = new ArrayList<Customer>();
		String sql = "SELECT customer_id customerId, customer_name customerName, customer_address customerAddress, customer_telephone customerTelephone, create_date createDate, update_date updateDate FROM customer limit ?,?";
		
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			// 쿼리담기
			stmt = conn.prepareStatement(sql);
			// stmt setter
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			// 디버깅
			System.out.println("CustomerDao.java selectCustomerList stmt : " + stmt);
			
			// 쿼리실행
			rs = stmt.executeQuery();
			while(rs.next()) {
				Customer customer = new Customer();
				customer.setCustomerId(rs.getString("customerId"));
				customer.setCustomerName(rs.getString("customerName"));
				customer.setCustomerAddress(rs.getString("customerAddress"));
				customer.setCustomerTelephone(rs.getString("customerTelephone"));
				customer.setCreateDate(rs.getString("createDate"));
				customer.setUpdateDate(rs.getString("updateDate"));
				// 디버깅
				System.out.println("CustomerDao.java selectCustomerList customer : " + customer.toString());
				
				// list에 담기
				list.add(customer);
			}
		} finally {
			if(rs != null) { rs.close(); }
			if(stmt != null) { stmt.close(); }
		}
		
		return list;
	}
	
	
	
	
	// 가입
	// CustomerService.addCustomer 가 호출
	public int insertCustomer(Connection conn, Customer paramCustomer) throws SQLException {
		int row = 0;
		String sql = "INSERT INTO customer (customer_id, customer_pass, customer_name, customer_address, customer_telephone, update_date, create_date) VALUES (?, PASSWORD(?), ?, ?, PASSWORD(?), now(), now())";
		PreparedStatement stmt = null;

		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramCustomer.getCustomerId());
			stmt.setString(2, paramCustomer.getCustomerPass());
			stmt.setString(3, paramCustomer.getCustomerName());
			stmt.setString(4, paramCustomer.getCustomerAddress());
			stmt.setString(5, paramCustomer.getCustomerTelephone());

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

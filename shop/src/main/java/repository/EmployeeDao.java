package repository;

import vo.Employee;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EmployeeDao {

	// 사원 active 변경
	public int updateEmployeeActive(Connection conn, Employee employee) throws SQLException {
		int row = 0;
		String sql = "UPDATE employee SET active = ? WHERE employee_id = ?";
		PreparedStatement stmt = null;

		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, employee.getActive());
			stmt.setString(2, employee.getEmployeeId());

			row = stmt.executeUpdate();
		} finally {
			if (stmt != null) {
				stmt.close();
			}
		}
		return row;
	}

	// 사원 리스트
	public List<Employee> selectEmployeeList(Connection conn, int rowPerPage, int beginRow) throws SQLException {
		List<Employee> list = null;
		Employee employee = null;

		String sql = "SELECT employee_id employeeId, employee_name employeeName, create_date createDate, active FROM employee ORDER BY create_date LIMIT ?, ?";
		PreparedStatement stmt = null;
		ResultSet rs = null;

		try {
			list = new ArrayList<Employee>();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			rs = stmt.executeQuery();
			while (rs.next()) {
				employee = new Employee();
				employee.setEmployeeId(rs.getString("employeeId"));
				employee.setEmployeeName(rs.getString("employeeName"));
				employee.setCreateDate(rs.getString("createDate"));
				employee.setActive(rs.getString("active"));
				list.add(employee);
			}
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}

		return list;
	}

	// 가입
	// CustomerService.addCustomer 가 호출
	public int insertEmployee(Connection conn, Employee paraEmployee) throws SQLException {
		int row = 0;
		String sql = "INSERT INTO customer (employee_id, employee_pass, employee_name, update_date, create_date) VALUES (?, PASSWORD(?), now(), now())";
		PreparedStatement stmt = null;

		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paraEmployee.getEmployeeId());
			stmt.setString(2, paraEmployee.getEmployeePass());
			stmt.setString(3, paraEmployee.getEmployeeName());

			row = stmt.executeUpdate();
		} finally {
			if (stmt != null) {
				stmt.close();
			}
		}
		return row;
	}

	// 탈퇴
	// EmployeeService.removeEmployee(Employee paramEmployee)가 호출
	public int removeEmployee(Connection conn, Employee paramEmployee) throws Exception {
		// 동일한 conn
		// conn.close() X
		int row = 0;

		String sql = "DELETE FROM employee WHERE employee_id= ? AND employee_pass = PASSWORD(?)";

		PreparedStatement stmt = null;

		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramEmployee.getEmployeeId());
			stmt.setString(2, paramEmployee.getEmployeePass());
			row = stmt.executeUpdate();

		} finally {
			stmt.close();
		}

		return row;
	}

	// CustomerService가 호출
	public Employee selectEmployeeByidAndPw(Connection conn, Employee paramEmployee) throws Exception {

		String sql = "SELECT employee_id , employee_pass, employee_name, update_date , create_date FROM employee WHERE employee_id=? AND employee_pass = PASSWORD(?)";

		Employee loginEmployee = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramEmployee.getEmployeeId());
			stmt.setString(2, paramEmployee.getEmployeePass());
			rs = stmt.executeQuery();

			if (rs.next()) {
				loginEmployee = new Employee();
				loginEmployee.setEmployeeId(rs.getString("employee_id"));
				loginEmployee.setEmployeePass(rs.getString("employee_pass"));
				loginEmployee.setEmployeeName(rs.getString("employee_name"));
				loginEmployee.setCreateDate(rs.getString("update_date"));
				loginEmployee.setUpdateDate(rs.getString("create_date"));
			}

			System.out.println(loginEmployee.getEmployeeId());
			System.out.println(loginEmployee.getEmployeePass());

		} finally {
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}

		}

		return loginEmployee;
	}

}

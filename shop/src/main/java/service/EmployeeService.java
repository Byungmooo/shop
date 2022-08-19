package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import repository.CustomerDao;
import repository.DBUtil;
import repository.EmployeeDao;
import repository.OutIdDao;
import vo.Customer;
import vo.Employee;

public class EmployeeService {
	
	////////////////////// lastPage
	public int lastPage(final int rowPerPage) {
		int lastPage = 0;
		
		// Connection 받을 변수 초기화
		Connection conn = null;
		try {
			
			// Connection 부를 객체생성
			conn = new DBUtil().getConnection();
			// getConnection메서드 실행

			// 디버깅
			System.out.println("EmployeeService.java lastPage conn : " + conn);
			// 자동 commit 해제
			conn.setAutoCommit(false);
			
			// EmployeeDao.selectEmployeeList 메서드실행 할 객체생성
			EmployeeDao employeeDao = new EmployeeDao(); 
			// 메서드실행
			// 리턴값 받기
			int allCount = employeeDao.allCount(conn);
			
			// 마지막페이지 구하기
			lastPage = (int) Math.ceil (allCount / (double)rowPerPage);
			
			if(lastPage == 0) {
				// lastPage가 없다면
				throw new Exception();
			}
			
			// 완료되었으면 commit
			conn.commit();
		} catch(Exception e) {
			e.printStackTrace();
			// 실패라면 rollback
			try {
				conn.rollback();
			} catch (Exception e1) {
				e1.printStackTrace();
			}
		} finally {
			// DB 자원해제
			if(conn != null) {
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
			
		return lastPage;
	}	
	
	
	
	
	
	
	// active update
	public void modifyEmployeeActive(Employee employee) {
		Connection conn = null;
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeUpdate() 실행 시 자동 커밋을 막음
			
			EmployeeDao employeeDao = new EmployeeDao(); 
			if(employeeDao.updateEmployeeActive(conn, employee) != 1) { // 쿼리문이 정상적으로 적용되었는지 확인 후 아닐 시 예외처리
				System.out.print("1");
				throw new Exception();
			}
			
			conn.commit();		
		} catch (Exception e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	// select
	public List<Employee> getEmployeeList(int rowPerPage, int currentPage) {		
		Connection conn = null;
		List<Employee> list = null;
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeUpdate() 실행 시 자동 커밋을 막음
			
			EmployeeDao employeeDao = new EmployeeDao(); 
			
			int beginRow = (currentPage - 1) * rowPerPage;
			
			list = employeeDao.selectEmployeeList(conn, rowPerPage, beginRow);
			
			if(list == null) { // 쿼리문이 정상적으로 적용되었는지 확인 후 아닐 시 예외처리
				throw new Exception();
			}

			conn.commit();		
		} catch (Exception e) {
			e.printStackTrace(); // console에 예외메세지 출력
			try {
				conn.rollback(); // 예외를 던지지말고 감싸야함
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return list;
	}
	
	
	
	//addEmployeeAction에서 호출되는 메서드
	public boolean addEmployee(Employee paramEmployee) {
		boolean result = true;
		Connection conn = null;
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeUpdate() 실행 시 자동 커밋을 막음
			
			EmployeeDao employeeDao = new EmployeeDao(); 
			if(employeeDao.insertEmployee(conn, paramEmployee) != 1) { // 쿼리문이 정상적으로 적용되었는지 확인 후 아닐 시 예외처리
				result = false;
				throw new Exception();
			}			
			conn.commit();		
		} catch (Exception e) {
			e.printStackTrace(); // console에 예외메세지 출력
			try {
				conn.rollback(); // 예외를 던지지말고 감싸야함
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return result;
	}
	
	
	// 회원탈퇴 액션페이지에서 호출되는 메서드
		public boolean removeEmployee(Employee paramEmployee) {
			Connection conn = null;
			
			try {
				conn = new DBUtil().getConnection();
				conn.setAutoCommit(false); // executeUpdate()실행시 자동 커밋을 막음
				
				EmployeeDao employeeDao = new EmployeeDao();
				int Dlow = employeeDao.removeEmployee(conn, paramEmployee);
				
				//디버그
				if(Dlow != 1) {
					System.out.println("delete 실패");
					throw new Exception();
				} else {
					System.out.println("delete 성공");
				}
				
				
				OutIdDao OutIdDao = new OutIdDao();
				int Ilow = OutIdDao.insertOutId(conn, paramEmployee.getEmployeeId());
				//디버그
				if(Ilow != 1) {
					System.out.println("insert 실패");
					throw new Exception();
				} else {
					System.out.println("insert 성공");
				}
				
				
				conn.commit();
				
			} catch (Exception e) {
				e.printStackTrace(); // console에 예외메세지 출력
				try {
					conn.rollback();
				} catch (SQLException e1) {
					e1.printStackTrace();
				}
				return false; // 실패
			} finally {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			return true; // 성공
		}
		
		
		//로그인 후 id, name LogionAction 호출
		public Employee getEmployeeByidAndPw(Employee paramEmployee) throws Exception {
			// 객체 초기화
			Connection conn = null;
			Employee employee = null;
			
			try {
				// conn 메서드실행할 객체생성
				DBUtil dbUtil = new DBUtil();
				conn = dbUtil.getConnection();
				
				EmployeeDao customerDao = new EmployeeDao();
				employee = customerDao.selectEmployeeByidAndPw(conn, paramEmployee);
				
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				try {
					conn.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			
			return employee;
		}
		
			
	
}

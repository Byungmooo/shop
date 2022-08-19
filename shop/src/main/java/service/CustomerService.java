package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import repository.CustomerDao;
import repository.OutIdDao;
import repository.DBUtil;
import vo.Customer;

public class CustomerService {


	//// lastPage
	public int lastPage(final int rowPerPage) {
		int lastPage = 0;
		
		// conn 초기화
		Connection conn = null;
		
		try {
			conn = new DBUtil().getConnection();
			// 디버깅
			System.out.println("CustomerService.java getCustomerList conn : " + conn);
			// 자동 commit 해제
			conn.setAutoCommit(false);
			
			// CustomerDao 객체 생성
			CustomerDao customerDao = new CustomerDao();
			
			// selectCustomerList메서드 실행 값 변수에 받기
			int allCount = customerDao.allCount(conn);
			
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
	
	////////////////////////// getCustomerList
	public List<Customer> getCustomerList(final int rowPerPage, final int currentPage) {

		List<Customer> list = new ArrayList<Customer>();
		
		// Connection 받을 변수 초기화
		Connection conn = null;
		
		int beginRow = (currentPage - 1) * rowPerPage;
		
		try {
			// getConnection메서드 실행
			conn = new DBUtil().getConnection();
			// 디버깅
			System.out.println("CustomerService.java getCustomerList conn : " + conn);
			// 자동 commit 해제
			conn.setAutoCommit(false);
			
			// CustomerDao 객체 생성
			CustomerDao customerDao = new CustomerDao(); 
			// selectCustomerList메서드 실행 값 변수에 받기
			list = customerDao.selectCustomerList(conn, rowPerPage, beginRow);
			
			// 완료되었다면 commit
			conn.commit();
		} catch(Exception e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (Exception e1) {
				e1.printStackTrace();
			}
		} finally {
			// DB 자원해제
			try {
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return list;
	}
	
	
	
	
	
	//addCustmoerAction에서 호출되는 메서드
	public boolean addCustomer(Customer paramCustomer) {
		boolean result = true;
		Connection conn = null;
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeUpdate() 실행 시 자동 커밋을 막음
			
			CustomerDao customerDao = new CustomerDao(); 
			if(customerDao.insertCustomer(conn, paramCustomer) != 1) { // 쿼리문이 정상적으로 적용되었는지 확인 후 아닐 시 예외처리
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
	public boolean removeCustomer(Customer paramCustomer) {
		Connection conn = null;
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeUpdate()실행시 자동 커밋을 막음
			
			CustomerDao customerDao = new CustomerDao();
			int Dlow = customerDao.removeCustomer(conn, paramCustomer);
			
			//디버그
			if(Dlow != 1) {
				System.out.println("delete 실패");
				throw new Exception();
			} else {
				System.out.println("delete 성공");
			}
			
			
			OutIdDao OutIdDao = new OutIdDao();
			int Ilow = OutIdDao.insertOutId(conn, paramCustomer.getCustomerId());
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
	public Customer getCustomerByidAndPw(Customer paramCustomer) throws Exception {
		// 객체 초기화
		Connection conn = null;
		Customer customer = null;
		
		try {
			// conn 메서드실행할 객체생성
			DBUtil dbUtil = new DBUtil();
			conn = dbUtil.getConnection();
			
			CustomerDao customerDao = new CustomerDao();
			customer = customerDao.selectCustomerByidAndPw(conn, paramCustomer);
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return customer;
	}
	

	
}

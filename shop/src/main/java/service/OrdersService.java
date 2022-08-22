package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import repository.GoodsDao;
import repository.OrdersDao;
import vo.Orders;

public class OrdersService {
	
	private OrdersDao ordersDao; // 디커풀링으로 인한 의존도를 낮춰 연결하는 방법
	
	
	//// updateOrderStateByOrderNo	
	public boolean modifyOrderStateByOrderNo(String orderState, int orderNo) {
		// 리턴값 초기화
		boolean result = false;
				
		// conn 초기화
		Connection conn = null;
		
		// ordersDao 초기화;
		this.ordersDao = new OrdersDao();
		
		try {
			conn = new DBUtil().getConnection();
			// 디버깅
			System.out.println("OrdersService.java modifyOrderStateByOrderNo conn : " + conn);
			
			// 자동커밋해제
			conn.setAutoCommit(false);
						
			// 메서드 실행 - row 0이면 update 안됨
			int row = this.ordersDao.updateOrderStateByOrderNo(conn, orderState, orderNo);
			// 디버깅
			System.out.println("OrdersService.java modifyOrderStateByOrderNo row : " + row);
			
			// row == 0 실패 -> 익셉션발생
			if(row == 0) {
				System.out.println("OrdersService.java modifyOrderStateByOrderNo update 실패");
				throw new Exception();
			}
			
			// 성공할 경우 result = true
			result = true;
			// 그후 커밋
			conn.commit();
		} catch(Exception e) {
			e.printStackTrace();
			// 문제있을경우 롤백
			try {
				conn.rollback();
			} catch (Exception e1) {
				e1.printStackTrace();
			}
		} finally {
			// 자원해제
			try {
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return result;
	}
	
	
	////////////////// lastPage	
	// 마지막페이지 구할 총 count
	public int lastPage(final int rowPerPage) {
		int lastPage = 0;
		
		// conn, dbUtil, ordersDao 초기화
		Connection conn = null;
		this.ordersDao = new OrdersDao();
		
		try {
			conn = new DBUtil().getConnection();
			int allCount = this.ordersDao.allCount(conn);
			// 디버깅
			System.out.println("OrdersService.java modifyOrderStateByOrderNo conn : " + conn);
			System.out.println("OrdersService.java modifyOrderStateByOrderNo allCount : " + allCount);
			
			// 마지막페이지 구하기 식
			lastPage = (int) Math.ceil(allCount / (double) rowPerPage);
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			// DB 자원해제
			try {
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return lastPage;
	}
	
	
	
	// 고객별 주문 마지막 페이지
	public int getOrdersLastPageByCustomer(String cusotmerId, int rowPerPage) {
		int lastPage = 0;
		int totalCount = 0;
		Connection conn = null;
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeUpdate() 실행 시 자동 커밋을 막음
			
			this.ordersDao = new OrdersDao();		 			
			totalCount = ordersDao.selectOrdersLastPageByCustomer(conn, cusotmerId, rowPerPage);
			
			if(totalCount == 0) { // 쿼리문이 정상적으로 적용되었는지 확인 후 아닐 시 예외처리
				throw new Exception();
			}
			
			lastPage = totalCount / rowPerPage;
			if (totalCount % rowPerPage != 0) {
				lastPage += 1;
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
		return lastPage;
	}
	
	// 주문 마지막 페이지
	public int getOrdersLastPage(int rowPerPage) {
		int lastPage = 0;
		int totalCount = 0;
		Connection conn = null;
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeUpdate() 실행 시 자동 커밋을 막음
			
			this.ordersDao = new OrdersDao();		 			
			totalCount = ordersDao.selectOrdersLastPage(conn, rowPerPage);
			
			if(totalCount == 0) { // 쿼리문이 정상적으로 적용되었는지 확인 후 아닐 시 예외처리
				throw new Exception();
			}
			
			lastPage = totalCount / rowPerPage;
			if (totalCount % rowPerPage != 0) {
				lastPage += 1;
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
		return lastPage;
	}
	
	
	
	// 고객 한명의 주문목록
	public List<Map<String, Object>> getOrdersListByCustomer(String customerId, int rowPerPage, int currentPage) {
		List<Map<String, Object>> list = null; 

		int beginRow;
		Connection conn = null;
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeUpdate() 실행 시 자동 커밋을 막음
			
			list = new ArrayList<>();
			
			this.ordersDao = new OrdersDao();
			beginRow = (currentPage - 1) * rowPerPage;
			
			list = ordersDao.selectOrdersListByCustomer(conn, customerId, rowPerPage, beginRow);
			
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
	
	// 배송상태변경
	public boolean modifyOrdersState(Orders orders) {
		boolean result = false;
		Connection conn = null;
		int row = 0;
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeUpdate() 실행 시 자동 커밋을 막음
			
			this.ordersDao = new OrdersDao();
			
			row = ordersDao.updateOrdersState(conn, orders);
			
			if(row != 1) { // 쿼리문이 정상적으로 적용되었는지 확인 후 아닐 시 예외처리
				throw new Exception();
			} else {
				result = true;
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
	
	
	
	// 주문 상세보기
	public Map<String, Object> getOrdersOne(int orderNo) throws SQLException {
		Map<String, Object> map = null; 

		Connection conn = null;
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeUpdate() 실행 시 자동 커밋을 막음
			
			map = new HashMap<>();			
			this.ordersDao = new OrdersDao();
			
			map = ordersDao.selectOrdersOne(conn, orderNo);
			
			if(map == null) { // 쿼리문이 정상적으로 적용되었는지 확인 후 아닐 시 예외처리
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
		return map;
	}
	
	// 전체 주문 목록
	public List<Map<String, Object>> getOrdersList(int rowPerPage, int currentPage) {
		List<Map<String, Object>> list = null; 

		int beginRow;
		Connection conn = null;
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeUpdate() 실행 시 자동 커밋을 막음
			
			list = new ArrayList<>();
			
			this.ordersDao = new OrdersDao();
			beginRow = (currentPage - 1) * rowPerPage;
			
			list = ordersDao.selectOrdersList(conn, rowPerPage, beginRow);
			
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
}
package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import vo.Orders;

public class OrdersDao {
	
	
	//// updateOrderStateByOrderNo	
	public int updateOrderStateByOrderNo(Connection conn, String orderState, int orderNo) throws Exception {
		int row = 0;
		String sql = "UPDATE orders SET order_state = ?, update_date = NOW() WHERE order_no = ?";
		
		// stmt 초기화
		PreparedStatement stmt = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			// stmt setter
			stmt.setString(1, orderState);
			stmt.setInt(2, orderNo);
			// 디버깅
			System.out.println("OrdersDao.java updateOrderStateByOrderNo stmt : " + stmt);
			
			// 쿼리 실행
			row = stmt.executeUpdate();
		} finally {
			if(stmt != null) { stmt.close(); }
		}
		
		return row;
	}
	
	
	///// allCount	
	// 마지막페이지 구할 총 count
	public int allCount(Connection conn) throws Exception {
		int allCount = 0;
		String sql = "SELECT COUNT(*) allCount FROM orders";
		
		// stmt, rs 초기화
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			// 디버깅
			System.out.println("OrdersDao.java allCount stmt : " + stmt);
			rs = stmt.executeQuery();
			if(rs.next()) {
				allCount = rs.getInt("allCount");
			}
		} finally {
			if(rs != null) { rs.close(); }
			if(stmt != null) { stmt.close(); }
		}
		
		return allCount;
	}

	//// selectOrdersOne	
	// 주문리스트 마지막페이지
		public int selectOrdersLastPageByCustomer(Connection conn, String customerId, int rowPerPage) throws SQLException {
			int totalCount = 0;
			String sql = "SELECT COUNT(*) FROM orders WHERE customer_id = ?";
			
			PreparedStatement stmt = null;
			ResultSet rs = null;
			
			try {
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, customerId);
				rs = stmt.executeQuery();

				if (rs.next()) {
					totalCount = rs.getInt("COUNT(*)");
				}
			} finally {
				if(rs != null) {
					rs.close();
				}
				if(stmt != null) {
					stmt.close();
				}
			}
			
			return totalCount;
		}
		
		// 주문리스트 마지막페이지
		public int selectOrdersLastPage(Connection conn, int rowPerPage) throws SQLException {
			int totalCount = 0;
			String sql = "SELECT COUNT(*) FROM orders";
			
			PreparedStatement stmt = null;
			ResultSet rs = null;
			
			try {
				stmt = conn.prepareStatement(sql);
				rs = stmt.executeQuery();

				if (rs.next()) {
					totalCount = rs.getInt("COUNT(*)");
				}
			} finally {
				if(rs != null) {
					rs.close();
				}
				if(stmt != null) {
					stmt.close();
				}
			}
			
			return totalCount;
		}
		
	// 배송상태변경
		public int updateOrdersState(Connection conn, Orders order) throws SQLException {
			int row = 0;
			String sql = "UPDATE orders SET order_state = ? WHERE order_no = ?";
			PreparedStatement stmt = null;

			try {
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, order.getOrderState());
				stmt.setInt(2, order.getOrderNo());

				row = stmt.executeUpdate();
			}finally {
				if(stmt!=null) {
					stmt.close();
				}
			}

			return row;
		}
	
	
	// 주문 상세보기
		public Map<String, Object> selectOrdersOne(Connection conn, int orderNo) throws SQLException {
			Map<String, Object> map = null;
			
			String sql = "SELECT o.order_no orderNo, o.customer_id customerId, o.order_quantity orderQuantity"
					+ ", o.order_price orderPrice, o.order_addr orderAddr, o.order_state orderState"
					+ ", o.update_date updateDate, o.create_date createDate"
					+ ", g.goods_no goodsNo, g.goods_name goodsName, g.goods_price goodsPrice"
					+ " FROM orders o INNER JOIN goods g ON o.goods_no = g.goods_no WHERE o.order_no = ?";		
			
//			String sql = "SELECT o.order_no orderNo, o.goods_no goodsNo, o.customer_id customerId, o.order_quantity orderQuantity,"
//					+ " o.order_price orderPrice, o.order_addr orderAddr, o.order_state orderState, "
//					+ "o.update_date updateDate, o.create_date createDate, g.goods_name goodsName, "
//					+ "c.customer_name customerName, c.customer_telephone customerTelephone "
//					+ "FROM orders o INNER JOIN goods g ON o.goods_no = g.goods_no LEFT JOIN customer "
//					+ "c ON o.customer_id = c.customer_id WHERE o.order_no = ?";
			
			PreparedStatement stmt = null;
			ResultSet rs = null;
			
			try {
				map = new HashMap<String, Object>();
				
				stmt = conn.prepareStatement(sql);
				stmt.setInt(1, orderNo);
				
				rs = stmt.executeQuery();
				
				if(rs.next()) {
					map.put("orderNo", rs.getInt("orderNo"));
					map.put("customerId", rs.getString("customerId"));
					map.put("orderQuantity", rs.getInt("orderQuantity"));
					map.put("orderPrice", rs.getInt("orderPrice"));
					map.put("orderAddr", rs.getString("orderAddr"));
					map.put("orderState", rs.getString("orderState"));
					map.put("updateDate", rs.getString("updateDate"));
					map.put("createDate", rs.getString("createDate"));
					map.put("goodsNo", rs.getInt("goodsNo"));
					map.put("goodsName", rs.getString("goodsName"));
					map.put("goodsPrice", rs.getInt("goodsPrice"));
				}
			} finally {
				if(rs != null) {
					rs.close();
				}
				if(stmt != null) {
					stmt.close();
				}
			}
			return map;
		}
   
		// 전체 주문 목록 (관리자)
		public List<Map<String, Object>> selectOrdersList(Connection conn, int rowPerPage, int beginRow) throws SQLException {
			// 조인문을 사용할 경우 Orders를 사용할 수 없음 (Map사용)
			// 다형성, 안될 시 null이 아닌 0사이즈 list 리턴
			List<Map<String, Object>> list = null; 
			Map<String, Object> map = null;
			
			String sql = "SELECT o.order_no orderNo, o.customer_id customerId, o.order_quantity orderQuantity"
					+ ", o.order_price orderPrice, o.order_addr orderAddr, o.order_state orderState"
					+ ", o.update_date updateDate, o.create_date createDate"
					+ ", g.goods_no goodsNo, g.goods_name goodsName, g.goods_price goodsPrice"
					+ " FROM orders o INNER JOIN goods g ON o.goods_no = g.goods_no ORDER BY o.create_date DESC LIMIT ?, ?";
			PreparedStatement stmt = null;
			ResultSet rs = null;
			
			try {
				list = new ArrayList<>();
				
				stmt = conn.prepareStatement(sql);
				stmt.setInt(1, beginRow);
				stmt.setInt(2, rowPerPage);
				
				rs = stmt.executeQuery();
				
				while(rs.next()) {
					map = new HashMap<String, Object>();
					map.put("orderNo", rs.getInt("orderNo"));
					map.put("customerId", rs.getString("customerId"));
					map.put("orderQuantity", rs.getInt("orderQuantity"));
					map.put("orderPrice", rs.getInt("orderPrice"));
					map.put("orderAddr", rs.getString("orderAddr"));
					map.put("orderState", rs.getString("orderState"));
					map.put("updateDate", rs.getString("updateDate"));
					map.put("createDate", rs.getString("createDate"));
					map.put("goodsNo", rs.getInt("goodsNo"));
					map.put("goodsName", rs.getString("goodsName"));
					map.put("goodsPrice", rs.getInt("goodsPrice"));
					
					list.add(map);
				}
			} finally {
				if(rs != null) {
					rs.close();
				}
				if(stmt != null) {
					stmt.close();
				}
			}
			return list;
		}
   
		
		// 고객 한명의 주문 목록 (관리자, 고객)
		public List<Map<String, Object>> selectOrdersListByCustomer(Connection conn, String customerId, int rowPerPage, int beginRow) throws SQLException {
			List<Map<String, Object>> list = null; 
			Map<String, Object> map = null;
			
			String sql = "SELECT o.order_no orderNo, o.order_quantity orderQuantity"
					+ ", o.order_price orderPrice, o.order_addr orderAddr, o.order_state ordersState"
					+ ", o.update_date updateDate, o.create_date createDate"
					+ ", g.goods_no goodsNo, g.goods_name goodsName, g.goods_price goodsPrice"
					+ ", c.customer_id customerId, c.customer_name customerName"
					+ " FROM orders o INNER JOIN goods g ON o.goods_no = g.goods_no"
					+ " INNER JOIN customer c ON o.customer_id = c.customer_id"
					+ " WHERE c.customer_id = ?"
					+ " ORDER BY o.create_date DESC LIMIT ?, ?";

			PreparedStatement stmt = null;
			ResultSet rs = null;
			
			try {
				list = new ArrayList<>();
				
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, customerId);
				stmt.setInt(2, beginRow);
				stmt.setInt(3, rowPerPage);
				
				rs = stmt.executeQuery();
				
				while(rs.next()) {
					map = new HashMap<String, Object>();
					map.put("orderNo", rs.getInt("orderNo"));
					map.put("orderQuantity", rs.getInt("orderQuantity"));
					map.put("orderPrice", rs.getInt("orderPrice"));
					map.put("orderAddr", rs.getString("orderAddr"));
					map.put("orderState", rs.getString("orderState"));
					map.put("updateDate", rs.getString("updateDate"));
					map.put("createDate", rs.getString("createDate"));
					map.put("goodsNo", rs.getInt("goodsNo"));
					map.put("goodsName", rs.getString("goodsName"));
					map.put("goodsPrice", rs.getInt("goodsPrice"));
					map.put("customerId", rs.getString("customerId"));
					map.put("customerName", rs.getString("customerName"));
					
					list.add(map);
				}
			} finally {
				if(rs != null) {
					rs.close();
				}
				if(stmt != null) {
					stmt.close();
				}
			}
			return list;
		}
}










package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
//import java.util.Map;
import java.util.Map;

import vo.Goods;

public class GoodsDao {
	
	
	
	
	// 고객 상품리스트 페이지에서 사용
	public List<Map<String, Object>>customerGoodsListbypage(Connection conn, int rowPerpage, int beginRow) throws Exception{
		List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		/*
		고객이 판매량수 많은것 부터
		goods g LEFT JOIN (SELECT goods_no, SUM(order_quantity)
							FROM orders
							GROUP BY goods_no
							ORDER BY SUM(order_quantity) DESC) t
		g.goods_no = t.goods_no
		 
		 */
		
		
		String sql= "SELECT g.goods_no goodsNo, g.goods_name goodsName, g.goods_price goodsPrice FROM goods g INNER JOIN goods_img gi ON g.goods_no = gi.goods_no";
		
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();
		
		while(rs.next()) {
			Map<String, Object> map = new HashMap<String, Object>();
			list.add(map);
		}if(rs != null) {
			rs.close();
		}if(stmt != null) {
			stmt.close();
		}
		
		
		return list;
	}
	

	//상품 추가
	public int insertGoods(Connection conn, Goods goods) throws Exception {
		int goodsNo = 0; // keyId
		String sql = "INSERT INTO goods (goods_name, goods_price, update_date, create_date, sold_out) VALUES (?, ?, NOW(), NOW(), ?)";
		PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS); // 키값을 반환하게 변경
		// stmt setter
		stmt.setString(1, goods.getGoodsName());
		stmt.setInt(2, goods.getGoodsPrice());
		stmt.setString(3, goods.getSoldOut());
		// 디버깅
		System.out.println("GoodsDao.java insertGoods stmt : " + stmt);
		
		// 1) insert 
		stmt.executeUpdate(); // 성공한 row의 수 
		// 2) select last_ai_key from  
		ResultSet rs = stmt.getGeneratedKeys(); // 컬럼명을 알 수 없다! select 문 순서가 첫번째 컬럼이기때문에 받을 수 있다.
		
		if(rs.next()) {
			goodsNo = rs.getInt(1);
		}
		
		if(rs != null) { rs.close(); }
		if(stmt != null) { stmt.close(); }
		
		return goodsNo;
	}
	
	
	
	// 상품 상세보기
	// 쿼리에서 where 조건이 없다면.. 반환 타입이 List<Map<String, Object>> list
	public Map<String, Object> selectGoodsAndImgOne(Connection conn, int goodsNo) throws SQLException {
		Map<String, Object> map = null;
		
		String sql = "SELECT g.*, gi.* FROM goods g"
				+ " INNER JOIN goods_img gi ON g.goods_no = gi.goods_no "
				+ "WHERE g.goods_no=?";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, goodsNo);
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				map = new HashMap<String, Object>();
				map.put("goodsNo", rs.getInt("g.goods_no"));
				map.put("goodsName", rs.getString("g.goods_name"));
				map.put("goodsPrice", rs.getInt("g.goods_price"));
				map.put("goodsUpdateDate", rs.getString("g.update_date"));
				map.put("goodsCreateDate", rs.getString("g.create_date"));
				map.put("soldOut", rs.getString("g.sold_out"));
				map.put("imgFileName", rs.getString("gi.filename"));
				map.put("imgOriginFileName", rs.getString("gi.origin_filename"));
				map.put("imgContentType", rs.getString("gi.content_type"));
				map.put("imgCreateDate", rs.getString("gi.create_date"));
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
	
	

	
	// 상품 soldout 변경
	public int updateGoodsSoldOut(Connection conn, Goods goods) throws SQLException {
		int row = 0;
		String sql = "UPDATE goods SET sold_out = ? WHERE goods_no = ?";
		PreparedStatement stmt = null;

		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, goods.getSoldOut());
			stmt.setInt(2, goods.getGoodsNo());

			row = stmt.executeUpdate();
		} finally {
			if (stmt != null) {
				stmt.close();
			}
		}
		return row;
	}

	// 상품리스트
	public List<Goods> selectGoodsListByPage(Connection conn, final int rowPerPage, int beginRow) throws SQLException {
		List<Goods> list = null;
		Goods goods = null;

		String sql = "SELECT goods_no goodsNo, goods_name goodsName, goods_price goodsPrice, create_date createDate, sold_out soldOut FROM goods ORDER BY goods_no DESC LIMIT ?, ?";

		PreparedStatement stmt = null;
		ResultSet rs = null;

		try {
			list = new ArrayList<Goods>();

			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			rs = stmt.executeQuery();

			while (rs.next()) {
				goods = new Goods();
				goods.setGoodsNo(rs.getInt("goodsNo"));
				goods.setGoodsName(rs.getString("goodsName"));
				goods.setGoodsPrice(rs.getInt("goodsPrice"));
				goods.setCreateDate(rs.getString("createDate"));
				goods.setSoldOut(rs.getString("soldOut"));

				list.add(goods);
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

	// 상품리스트 마지막페이지
	public int selectGoodsLastPage(Connection conn, int rowPerPage) throws SQLException {
		int totalCount = 0;
		String sql = "SELECT COUNT(*) FROM goods";

		PreparedStatement stmt = null;
		ResultSet rs = null;

		try {
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();

			if (rs.next()) {
				totalCount = rs.getInt("COUNT(*)");
			}
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}

		return totalCount;
	}
}

package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import vo.GoodsImg;

public class GoodsImgDao {
	
	// 이미지 수정
	public int updateGoodsImg(Connection conn, GoodsImg goodsImg) throws SQLException {
		int row = 0;
		
		String sql = "UPDATE goods_img SET filename = ?, origin_filename = ?, content_type = ?"
				+ " WHERE goods_no = ?";
		PreparedStatement stmt = null;		
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, goodsImg.getFilename());
			stmt.setString(2, goodsImg.getOriginFilename());
			stmt.setString(3, goodsImg.getContentType());
			stmt.setInt(4, goodsImg.getGoodsImgNo());
			
			row = stmt.executeUpdate(); 
		} finally {
			if(stmt != null) {
				stmt.close();
			}
		}
		
		System.out.println(row + " <-- row");
		return row;
	}
		
	

	public int insertGoodsImg(Connection conn, GoodsImg goodsImg) throws SQLException {
		// 디버깅
		System.out.println(goodsImg + "<-- insertGoodsImg 디버깅");
		// 리턴할 변수 선언 및 초기화
		int row = 0;
		
		// DB 자원 초기화
		PreparedStatement stmt = null;
		String sql = "INSERT INTO goods_img (goods_no, filename, origin_filename, content_type, create_date) "
				+ "VALUES (?, ?, ?, ?, NOW())";
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, goodsImg.getGoodsImgNo());
			stmt.setString(2, goodsImg.getFilename());
			stmt.setString(3, goodsImg.getOriginFilename());
			stmt.setString(4, goodsImg.getContentType());
			
			System.out.println(stmt + "<--stmt - insertGoodsImg");
			// 실행
			row = stmt.executeUpdate();
			System.out.println(row + "<-- row - insertGoodsImg");
		} finally {
			if (stmt != null) {
				stmt.close();
			}
		}
		return row;
	}
	
}

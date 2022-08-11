package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class OutIdDao {
	// 탈퇴 회원의 아이디
	public int insertOutId(Connection conn, String customerId) throws Exception {

		// conn닫지말것
		int row = 0;
		String sql = "insert into outid(out_id, out_date) values (?, now())";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, customerId);
		row = stmt.executeUpdate();
		System.out.println("OutIdDaoSTMT>>  " + stmt);
		stmt.close();

		return row;
	}
}

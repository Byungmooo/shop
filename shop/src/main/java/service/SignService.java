package service;

import java.sql.Connection;
import java.sql.SQLException;

import repository.DBUtil;
import repository.SignDao;

public class SignService {
	private SignDao signDao;
	
	// true : 사용가능한 ID
	// false : 사용불가능한 ID
	public boolean idCheck(String id) {
		boolean result = false;
		this.signDao = new SignDao();
		
		Connection conn = null;
		try {
			conn = new DBUtil().getConnection();
			if(this.signDao.idCheck(conn, id) == null) {
				result = true;
			}
			conn.commit();
		} catch(Exception e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		} finally {
			if(conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		
		return result;
	}
}

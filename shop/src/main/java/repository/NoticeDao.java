package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import vo.Notice;

public class NoticeDao {
	
	// 공지사항 마지막페이지
	public int selectNoticeLastPage(Connection conn, int rowPerPage) throws SQLException {
		int totalCount = 0;
		String sql = "SELECT COUNT(*) FROM notice";

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
	
	//공지사항 상세보기
	public Map<String, Object> selectNoticeOne(Connection conn, int noticeNo) throws SQLException {
		Map<String, Object> map = null;
	
				String sql = "SELECT notice_no noticeNo, notice_title noticeTitle, notice_content noticeContent"
				+ ", update_date updateDate, create_date createDate"
				+ " FROM notice"
				+ "WHERE notice_no = ?";
		
		
		PreparedStatement stmt = null;
		ResultSet rs = null;	
	
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, noticeNo);
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				map= new HashMap<String, Object>();
				map.put("noticeNo",rs.getInt("noticeNo"));
				map.put("noticeTitle",rs.getString("noticeTitle"));
				map.put("noticeContent",rs.getString("noticeContent"));
				map.put("updateDate",rs.getString("updateDate"));
				map.put("createDate",rs.getString("createDate"));
			}
		}finally {
			if(rs != null) {
				rs.close();
			}
			if(stmt != null) {
				stmt.close();
			}
		}
		
		return map;
	}
	
	
	// 공지사항 리스트
	public List<Notice> selectNoticeList(Connection conn, int rowPerPage, int beginRow) throws SQLException {
		List<Notice> list = null;
		Notice notice = null;

		String sql = "SELECT notice_title noticeTitle, notice_content noticeContent, create_date createDate, update_date updateDate "
					+ "FROM notice "
					+ "ORDER BY create_date LIMIT ?, ?";
		
		PreparedStatement stmt = null;
		ResultSet rs = null;

		try {
			list = new ArrayList<Notice>();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			rs = stmt.executeQuery();
			while (rs.next()) {
				notice = new Notice();
				notice.setNoticeTitle(rs.getString("noticeTitle"));
				notice.setNoticeContent(rs.getString("noticeContent"));
				notice.setCreateDate(rs.getString("createDate"));
				notice.setUpdateDate(rs.getString("updateDate"));
				list.add(notice);
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
}
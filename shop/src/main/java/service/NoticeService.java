package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import repository.DBUtil;
import repository.NoticeDao;
import vo.Notice;


public class NoticeService {
	
	private NoticeDao noticeDao;
	
	
	// 공지사항 마지막 페이지
	public int getNoticeLastPage(int rowPerPage) {
		int lastPage = 0;
		int totalCount = 0;
		Connection conn = null;

		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeUpdate() 실행 시 자동 커밋을 막음

			this.noticeDao = new NoticeDao();
			totalCount = noticeDao.selectNoticeLastPage(conn, rowPerPage);

			if (totalCount == 0) { // 쿼리문이 정상적으로 적용되었는지 확인 후 아닐 시 예외처리
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
	
	
	// select
	public List<Notice> getNoticeList(int rowPerPage, int currentPage) {		
		Connection conn = null;
		List<Notice> list = null;
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeUpdate() 실행 시 자동 커밋을 막음
			
			NoticeDao noticeDao = new NoticeDao(); 
			
			int beginRow = (currentPage - 1) * rowPerPage;
			
			list = noticeDao.selectNoticeList(conn, rowPerPage, beginRow);
			
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
	
	
	
	
	
	
	
	
	
	
	
	
	public Map<String, Object> getNoticeOne(int noticeNo){
		Connection conn = null;
		Map<String, Object> map = null;
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); //executeUpdate() 실행 시 자동 커밋 막음
			
			this.noticeDao = new NoticeDao();
			map = noticeDao.selectNoticeOne(conn,noticeNo);
			
			if(map == null) {
				throw new Exception();
			}
			conn.commit();
		}catch (Exception e) {
			e.printStackTrace();
			try {
				conn.rollback();
			}catch (SQLException e1) {
				e1.printStackTrace();
			}
		}finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return map;
	}
	
	
}

package service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import repository.GoodsDao;
import repository.GoodsImgDao;
import vo.Goods;
import vo.GoodsImg;

public class GoodsService {
	private GoodsDao goodsDao; // 디커풀링으로 인한 의존도를 낮춰 연결하는 방법
	private GoodsImgDao goodsImgDao;
	
//	////////////////////////BEGINROW 수정
//	public List<Map<String, Object>> getCustomerGoodsListByPage(int rowPerPage, int currentPage) {
//		List<Map<String, Object>> list = null;
//		Connection conn = null;
//		try {
//			conn = new DBUtil().getConnection();
//			conn.setAutoCommit(false);
//			
//			goodsDao = new GoodsDao();
//			list = goodsDao.selectCustomerGoodsListByPage(conn, rowPerPage, currentPage);
//			
//			if(list == null) {
//				throw new Exception();
//			}
//			conn.commit();		
//		} catch (Exception e) {
//			e.printStackTrace();
//			try {
//				conn.rollback();
//			} catch (SQLException e1) {
//				e1.printStackTrace();
//			}
//		} finally {
//			try {
//				conn.close();
//			} catch (SQLException e) {
//				e.printStackTrace();
//			}
//		}
//		return list;
//	}
	
//	// 상품수정
//	public int modifyGoods(Goods goods, GoodsImg goodsImg) {
//		int row = 0;
//		
//		Connection conn = null;
//		try {
//			conn = new DBUtil().getConnection();
//			conn.setAutoCommit(false); // executeUpdate() 실행 시 자동 커밋을 막음
//			
//			goodsDao = new GoodsDao();
//			goodsImgDao = new GoodsImgDao();
//			
//			row = goodsDao.updateGoods(conn, goods);
//			
//			if(row != 0) {
//				row = goodsImgDao.updateGoodsImg(conn, goodsImg);
//				if(row == 0) {
//					throw new Exception();  // 이미지 입력실패시 강제로 롤백(catch절 이동)
//				}
//			}
//				
//			conn.commit();		
//		} catch (Exception e) {
//			e.printStackTrace(); // console에 예외메세지 출력
//			try {
//				conn.rollback(); // 예외를 던지지말고 감싸야함
//			} catch (SQLException e1) {
//				e1.printStackTrace();
//			}
//		} finally {
//			try {
//				conn.close();
//			} catch (SQLException e) {
//				e.printStackTrace();
//			}
//		}
//		
	
	
	// 상품 추가
		public int addGoods(Goods goods, GoodsImg goodsImg) throws SQLException {
			// 파라미터 디버깅
			System.out.println(goods);
			System.out.println(goodsImg);
			// 리턴할 변수 선언
			int row = 0;
			// DB 연동
			Connection conn = null;

			try {
				conn = new DBUtil().getConnection();

				conn.setAutoCommit(false);
				// DAO 객체 생성
				goodsDao = new GoodsDao();
				goodsImgDao = new GoodsImgDao();

				// 1)insertGoods 실행후 성공시 -> 2)img 삽입
				// goodsNo가 AutoIncrement로 자동생성되어 DB입력
				// 새로 생성된 key값이 리턴된다.
				int goodsNo = goodsDao.insertGoods(conn, goods);

				if (goodsNo != 0) { // insertGoods가 정상적으로 실행되었다면
					goodsImg.setGoodsImgNo(goodsNo); // 리턴 받아온 key값을 goodsImg의 goodsNo로 셋팅
					row = goodsImgDao.insertGoodsImg(conn, goodsImg);
					if (row == 0) { // 이미지입력 실패시
						throw new Exception(); // catch절로 이동
					}
				}
				conn.commit();
			} catch (Exception e) { // 예외처리되면
				e.printStackTrace();
				try {
					conn.rollback(); // rollback해서 이전상태로 만들기
				} catch (Exception e2) {
					e.printStackTrace();
				}
			} finally {
				// DB자원 해제
				if (conn != null) {
					conn.close();
				}
			}
			System.out.println(row + "<-- row - addGoods");
			return row;
		}

	
	
	// 상품 상세보기
	public Map<String, Object> getGoodsAndImgOne(int goodsNo) {
		Connection conn = null;
		Map<String, Object> map = null;
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeUpdate() 실행 시 자동 커밋을 막음
			
			this.goodsDao = new GoodsDao();	
			map = goodsDao.selectGoodsAndImgOne(conn, goodsNo);
			
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
	
	
	
	// 상품 SoldOut 변경
	public boolean modifyGoodsSoldOut(Goods goods) {
		Connection conn = null;
		boolean result = false;
		int row = 0;

		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeUpdate() 실행 시 자동 커밋을 막음

			this.goodsDao = new GoodsDao();
			row = goodsDao.updateGoodsSoldOut(conn, goods);

			if (row != 1) { // 쿼리문이 정상적으로 적용되었는지 확인 후 아닐 시 예외처리
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

	// 상품리스트
	public List<Goods> getGoodsListByPage(int rowPerPage, int currentPage) {
		List<Goods> list = null;
		Connection conn = null;
		int beginRow;

		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeUpdate() 실행 시 자동 커밋을 막음

			this.goodsDao = new GoodsDao();
			beginRow = (currentPage - 1) * rowPerPage;
			list = goodsDao.selectGoodsListByPage(conn, rowPerPage, beginRow);

			if (list == null) { // 쿼리문이 정상적으로 적용되었는지 확인 후 아닐 시 예외처리
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

	// 상품 마지막 페이지
	public int getGoodsLastPage(int rowPerPage) {
		int lastPage = 0;
		int totalCount = 0;
		Connection conn = null;

		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false); // executeUpdate() 실행 시 자동 커밋을 막음

			this.goodsDao = new GoodsDao();
			totalCount = goodsDao.selectGoodsLastPage(conn, rowPerPage);

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
}

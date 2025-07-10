package com.mlb.store.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.sql.DriverManager;

import java.time.LocalDateTime;
import java.util.ArrayList;
import com.mlb.store.dto.StoreProductWithStocksDto;
import com.mlb.store.dto.StoreStocksWithOrderdetailsDto;
import com.mlb.utils.DBConn;

public class StoreProductWithStocksDao {

	public ArrayList<String> getSizesByColor(Long prID, String color) {
		ArrayList<String> sizes = new ArrayList<>();

		String sql = "SELECT PS.sz_id FROM PRODUCT_STOCKS PS JOIN PRODUCTS P ON P.pr_id = PS.pr_id "
				+ "WHERE P.pr_id = " + prID + " AND PS.cl_id = '" + color + "' AND PS.quantity > 0";

		ResultSet rs = DBConn.statementQuery(sql);

		try {
			while (rs.next()) {
				sizes.add(rs.getString("sz_id"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return sizes;
	}

	public StoreProductWithStocksDto selectByPrID(Long prID) {
		StoreProductWithStocksDto product = null; // product: dto (하나의 상품만 보여줌)
		ArrayList<StoreProductWithStocksDto> productStocks = new ArrayList<>(); // productStocks: dto 리스트 (해당 상품의 재고 리스트)

		String sql = "SELECT P.pr_id, P.pr_name, P.ca_id, P.tm_id, P.pr_thum_img, P.pr_detail_img, " // products의 상품아이디, 이름, 카테고리, 팀명, 썸네일, 상세이미지(한개씩)
				+ "       PS.pr_st_id, PS.cl_id, PS.sz_id, PS.quantity, PS.price " + "FROM PRODUCTS P " // products_stocks의 재고아이디, 컬러, 사이즈, 수량, 가격(리스트)
				+ "JOIN PRODUCT_STOCKS PS ON P.pr_id = PS.pr_id " + "WHERE P.pr_id = " + prID + " AND PS.quantity > 0";

		ResultSet rs = DBConn.statementQuery(sql); // sql 돌림

		try {
			while (rs.next()) {
				
				if (product == null) { // ??
					product = new StoreProductWithStocksDto(); // StoreProductsWithStocksDto 객체 생성
					product.setPrID(rs.getLong("pr_id")); // 테이블에서 상품아이디 가져와서 product 에다 저장함
					product.setPrName(rs.getString("pr_name"));
					product.setCaID(rs.getString("ca_id"));
					product.setTmID(rs.getString("tm_id"));
					product.setPrice(rs.getInt("price"));
					product.setPrThumImg(rs.getString("pr_thum_img"));
					product.setPrDetailImg(rs.getString("pr_detail_img"));
					product.setQuantity(rs.getInt("quantity")); // 여기까지
				}

				// 상품의 재고 정보를 색상, 사이즈 별로 추가
				productStocks.add(new StoreProductWithStocksDto(null, null, null, null, rs.getString("sz_id"),
						rs.getString("cl_id"), rs.getInt("price"), rs.getInt("quantity"), null, null,
						rs.getLong("pr_st_id"), null, null)); // 가져온 값 dto 객체에 담아서 productStocks 리스트에 추가
			}

			// 상품에 해당하는 재고 정보들을 설정
			if (product != null) {
				product.setProductStocks(productStocks);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return product; // 상품 리턴
	}

	public int getStockByColorAndSize(Long prID, String color, String size) {
		int stock = 0;
		String sql = "SELECT PS.pr_st_id, PS.quantity FROM PRODUCT_STOCKS PS "
				+ "JOIN PRODUCTS P ON P.pr_id = PS.pr_id " + "WHERE P.pr_id = " + prID + " " + "AND PS.cl_id = '"
				+ color + "' " + "AND PS.sz_id = '" + size + "'";

		ResultSet rs = DBConn.statementQuery(sql);

		try {
			if (rs.next()) {
				long prStId = rs.getLong("pr_st_id");
				stock = rs.getInt("quantity");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return stock;
	}



	public void addToCart(Long prID, String color, String size, int quantity, String userID) {
		//  pr_st_id 조회 하기
		String queryPrStId = String.format(
				"SELECT pr_st_id, price, quantity FROM PRODUCT_STOCKS WHERE pr_id = %d AND cl_id = '%s' AND sz_id = '%s'",
				prID, color, size);

		ResultSet rs = DBConn.statementQuery(queryPrStId);
		Long prStID = null;
		int price = 0;
		int stock = 0;

		try {
			if (rs.next()) {
				prStID = rs.getLong("pr_st_id");
				price = rs.getInt("price");
				stock = rs.getInt("quantity");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		// 2. 재고 확인 후 장바구니 추가 하는거다아아아
		if (prStID != null) {
			if (quantity > stock) {
				System.out.println("ERROR: 선택한 수량이 재고보다 많습니다.");
				return;
			}

			String insertSql = String
					.format("INSERT INTO ORDER_DETAILS (order_id, user_id, pr_st_id, order_quantity, order_price) "
							+ "VALUES (NULL, '%s', %d, %d, %d)", userID, prStID, quantity, price * quantity // 가격 계산
					);

			DBConn.statementUpdate(insertSql);
		} else {
			System.out.println("ERROR: 해당 색상 및 사이즈의 상품이 존재하지 않습니다.");
		}
	}





	    private static ArrayList<StoreProductWithStocksDto> stockList = new ArrayList<>();

	    public StoreProductWithStocksDao() {
	       // System.out.println(" DAO 생성됨........... stockList 채우는 중...");
	        loadProductStocks(); // 생성될 때 데이터 불러오기
	    }

	    public void loadProductStocks() {
	        stockList.clear(); // 기존 데이터 초기화
	        String query = "SELECT pr_st_id, pr_id, cl_id, sz_id, price, quantity FROM PRODUCT_STOCKS";
	        ResultSet rs = DBConn.statementQuery(query);

	        try {
	           // System.out.println(" DB에서 stockList 가져오는 중...");
	            while (rs.next()) {
	                StoreProductWithStocksDto stock = new StoreProductWithStocksDto();
	                stock.setPrStID(rs.getLong("pr_st_id"));
	                stock.setPrID(rs.getLong("pr_id"));
	                stock.setClID(rs.getString("cl_id"));
	                stock.setSzID(rs.getString("sz_id"));
	                stock.setPrice(rs.getInt("price"));
	                stock.setQuantity(rs.getInt("quantity"));

	                stockList.add(stock); // 리스트에 추가
	               // System.out.println(" DB 데이터 - prID: " + stock.getPrID() + ", color: " + stock.getClID() + ", size: " + stock.getSzID() + ", pr_st_id: " + stock.getPrStID());
	            }
	           //System.out.println(" stockList 채움: 총 " + stockList.size() + " 개");
	        } catch (Exception e) {
	            e.printStackTrace();
	        } finally {
	            try {
	                if (rs != null) rs.close();
	            } catch (Exception e) {
	                e.printStackTrace();
	            }
	        }
	    }
	
	



	public Long getPrStIdByColorAndSize(Long prID, String color, String size) {
	   // System.out.println(" 찾는 조건 - prID: " + prID + ", color: " + color + ", size: " + size);
	    
	    for (StoreProductWithStocksDto stock : stockList) {
	       // System.out.println(" 확인 중 - prID: " + stock.getPrID() + ", color: " + stock.getClID() + ", size: " + stock.getSzID());

	        if (stock.getPrID().equals(prID) && stock.getClID().equalsIgnoreCase(color) && stock.getSzID().equalsIgnoreCase(size)) {
	          //  System.out.println(" pr_st_id 찾음: " + stock.getPrStID());
	            return stock.getPrStID();
	        }
	    }

	 //   System.out.println(" pr_st_id 찾지 못햄");
	    return null;
	}


}


//public ArrayList<StoreProductWithStocksDto> selectAll() {
//	ArrayList<StoreProductWithStocksDto> dtos = new ArrayList<>();
//	String sql = "SELECT P.pr_id, P.pr_name, P.ca_id, P.tm_id, P.pr_regdate, "
//			+ "       P.pr_thum_img, P.pr_detail_img, "
//			+ "       PS.pr_st_id, PS.cl_id, PS.sz_id, PS.quantity, PS.price " + "FROM PRODUCTS P "
//			+ "JOIN PRODUCT_STOCKS PS " + "ON P.pr_id = PS.pr_id " + "ORDER BY P.pr_id";
//
//	ResultSet rs = DBConn.statementQuery(sql);
//
//	try {
//		while (rs.next()) {
//			dtos.add(new StoreProductWithStocksDto(rs.getLong("pr_id"), rs.getString("pr_name"),
//					rs.getString("ca_id"), rs.getString("tm_id"), rs.getString("sz_id"), rs.getString("cl_id"),
//					rs.getInt("price"), rs.getInt("quantity"), rs.getString("pr_thum_img"),
//					rs.getString("pr_detail_img"), rs.getLong("pr_st_id"), null, null));
//		}
//	} catch (Exception e) {
//		e.printStackTrace();
//	} finally {
//		try {
//			if (rs != null)
//				rs.close(); // ResultSet 닫기
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//	}
//
//	return dtos;
//}

//public void insert(StoreStocksWithOrderdetailsDto dto) {
//	String sql = String.format(
//			"INSERT INTO ORDER_DETAILS (order_id, user_id, pr_st_id, order_quantity, order_price) VALUES (NULL, '%s', %d, %d, %d)",
//			dto.getUserID(), dto.getPrStID(), dto.getQuantity(), dto.getOrderPrice());
//
//	DBConn.statementUpdate(sql);
//
//}

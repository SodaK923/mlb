package com.mlb.order.dao;

import java.sql.ResultSet;
import java.time.LocalDateTime;
import java.util.ArrayList;
import com.mlb.order.dto.*;
import com.mlb.order.dto.option.OrderDetail;
import com.mlb.order.dto.option.OrderNo;
import com.mlb.order.dto.option.Product;
import com.mlb.utils.DBConn;

public class OrderListDao {

	
	public Long selectOrderCnt() {
		
		Long orderCnt = 0L;
		
		String sql = "SELECT count(*) as ORDER_CNT FROM ORDERS";

		System.out.println(sql);
		ResultSet rs = DBConn.statementQuery(sql);

		try {

			while (rs.next()) {
				orderCnt = rs.getLong("ORDER_CNT");
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConn.dbClose();
		}
		
		return orderCnt;
		
	}
	
	
	
	
	
	// 전체 주문 리스트
	public ArrayList<OrderUserDto> selectOrderUserList(int pageNum , Long listNum , Long orderId ) {
		
		Long beginIdx = ( ( pageNum - 1 ) * listNum ) + 1;
		Long endIdx   = ( beginIdx + listNum ) - 1;
		
		ArrayList<OrderUserDto> orderList = new ArrayList<>();
		
		StringBuilder sb = new StringBuilder();
		
		sb.append("WITH ");
		sb.append("ODUS AS ( select * from ORDERS NATURAL JOIN USERS order by ORDERS.order_date desc ), ");
		sb.append("R AS ( select ROWNUM as NUMID , P.* FROM ODUS P ) ");
		sb.append("SELECT NUMID , ");
		sb.append("USER_ID , ID as LOG_ID, NAME as USER_NAME , HP as USER_HP , EMAIL as USER_EMAIL, ");
		sb.append("ORDER_ID , ORDER_DATE , TOTAL_PRICE , PAY_ID , ");
		sb.append("SHIPPING_ADDRESS , SHIPPING_DATE ");
		sb.append("FROM R WHERE ");
		
		if( orderId != 0L ) // orderId 값이 있으면 
			sb.append( String.format( "order_id = %d" , orderId ) );
		else
			sb.append( String.format( "NUMID BETWEEN %d AND %d" , beginIdx , endIdx ) );
		

		String sql = sb.toString();
		
		System.out.println(sql);
		ResultSet rs = DBConn.statementQuery(sql);

		try {

			while (rs.next()) {
				
				OrderUserDto oudto = new OrderUserDto( rs.getLong("numid"), 
						rs.getLong("user_id")  , 
						rs.getString("log_id" ) , 
						rs.getString("user_name" ), 
						rs.getString("user_hp"), 
						rs.getString("user_email"),
						rs.getLong("order_id"),
						rs.getTimestamp("order_date").toLocalDateTime(), 			
						rs.getInt("total_price"),
						rs.getString("pay_id"),
						rs.getString("shipping_address"),
						rs.getTimestamp("shipping_date") != null ? rs.getTimestamp("shipping_date").toLocalDateTime():null
						);

				orderList.add(oudto);
			}
			

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConn.dbClose();
		}

		return orderList;
		
	}
	

	// 주문 상세 리스트
	public ArrayList<OrderDto> selectOrderList(Long userId , Long orderId ) {

		// 'BallCap' , 'Hat' , 'Season' ,'Beanie'
		ArrayList<OrderDto> orderList = new ArrayList<>();
		String sql = "select O.order_id,O.order_date,O.total_price,O.pay_id,O.shipping_address,O.shipping_date ";
		sql += "from ORDERS O ";
		
		if( orderId != 0L )
			sql += String.format("where O.order_id = %d ", orderId);
		else 
			sql += String.format("where O.user_id = %d ", userId);
		
		sql += "order by order_date desc";

		System.out.println(sql);
		ResultSet rs = DBConn.statementQuery(sql);

		try {

			ArrayList<OrderNo> orderNolist = new ArrayList<>();
			// 주문 리스트 가져오기
			while (rs.next()) {

				OrderNo orderNo = new OrderNo(rs.getLong("order_id"), rs.getTimestamp("order_date").toLocalDateTime(),
						rs.getInt("total_price"), rs.getString("pay_id"), rs.getString("shipping_address"),
						rs.getTimestamp("shipping_date") != null ? rs.getTimestamp("shipping_date").toLocalDateTime():null);

				orderNolist.add(orderNo);
			}

			// 주문 상세 정보 가져오기.
			for (OrderNo orderNo : orderNolist) {

				ArrayList<OrderDetail> orderDetails = new ArrayList<>();

				StringBuilder sb = new StringBuilder();

				sb.append("select ");
				sb.append("O.order_id, ");
				sb.append("OD.user_id, ");
				sb.append("OD.order_detail_id, ");
				sb.append("OD.order_quantity, ");
				sb.append("OD.order_price, ");
				sb.append("P.pr_id, ");
				sb.append("P.tm_id, ");
				sb.append("P.pr_name, ");
				sb.append("P.pr_thum_img, ");
				sb.append("PS.pr_st_id, ");
				sb.append("PS.cl_id, ");
				sb.append("PS.sz_id ");
				sb.append("from ORDERS O , ORDER_DETAILS OD , product_stocks PS , products P ");
				sb.append("where O.order_id = OD.order_id and ");
				
				if( userId != 0L )
					sb.append(String.format("O.user_id = %d and ", userId));
				
				sb.append("OD.pr_st_id = PS.pr_st_id and ");
				sb.append("PS.pr_id = P.pr_id and ");
				sb.append(String.format("O.order_id = %d", orderNo.getOrderId()));

				sql = sb.toString();
				rs = DBConn.statementQuery(sql);
				System.out.println(sql);
				
				boolean bResult = false;

				while (rs.next()) {
					OrderDetail od = new OrderDetail(rs.getLong("user_id"), rs.getLong("order_detail_id"),
							rs.getInt("order_quantity"), rs.getInt("order_price"), rs.getString("pr_name"),
							rs.getString("pr_thum_img"), rs.getLong("pr_id"), rs.getLong("pr_st_id"),
							rs.getString("cl_id"), rs.getString("sz_id"));

					orderDetails.add(od);
					bResult = true;
				}

				if( bResult )
				{
					OrderDto orderDto = new OrderDto(orderNo, orderDetails);
					orderList.add(orderDto);
				}
				
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConn.dbClose();
		}

		return orderList;
	}

	// 회원 장바구니 리스트
	public ArrayList<OrderDto> selectUserCartList(Long userId){

		ArrayList<OrderDto> orderList = new ArrayList<>();
		
		StringBuilder sb = new StringBuilder();
		
		sb.append("select ");
		sb.append("OD.user_id, ");
		sb.append("OD.order_detail_id, ");
		sb.append("OD.order_quantity, ");
		sb.append("OD.order_price, ");
		sb.append("P.pr_id, ");
		sb.append("P.pr_name, ");
		sb.append("P.pr_thum_img, ");
		sb.append("PS.pr_st_id, ");
		sb.append("PS.cl_id, ");
		sb.append("PS.sz_id ");
		sb.append("from ORDER_DETAILS OD , product_stocks PS , products P ");
		sb.append("where OD.order_id is null and ");
		sb.append(String.format("OD.user_id = %d and ", userId));
		sb.append("OD.pr_st_id = PS.pr_st_id and ");
		sb.append("PS.pr_id = P.pr_id ");
		sb.append("order by OD.order_detail_id desc");

		String sql = sb.toString();
		
		System.out.println(sql);
		ResultSet rs = DBConn.statementQuery(sql);

		try {

			// 상세 정보 가져오기.
			ArrayList<OrderDetail> orderDetails = new ArrayList<>();
			
			boolean bResult = false;

			while (rs.next()) {
				OrderDetail od = new OrderDetail( rs.getLong("user_id"), 
						rs.getLong("order_detail_id") , 
						rs.getInt("order_quantity" ), 
						rs.getInt("order_price"), 
						rs.getString("pr_name"),
						rs.getString("pr_thum_img"),
						rs.getLong("pr_id"), 			
						rs.getLong("pr_st_id"),
						rs.getString("cl_id"),
						rs.getString("sz_id")
						);

				orderDetails.add(od);
				bResult = true;
			}

			if( bResult )
			{
				OrderDto orderDto = new OrderDto(null,orderDetails);
				orderList.add(orderDto);
			}
			

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConn.dbClose();
		}

		return orderList;

	}
	
	
	public int deleteOrderDetail(Long orderDetailId) {
		
		String sql = String.format(
				"DELETE FROM order_details WHERE order_detail_id = %d", orderDetailId );
		
		int result = DBConn.statementUpdate(sql);
		System.out.println("deleteOrderDetail result: " + result);
		return result;
		
	}
	
	public void insertCart( Long userId , Long prstId , int quantity )
	{
		 
		String sql = String.format( "SELECT price FROM product_stocks WHERE pr_st_id = %d" , prstId );

		ResultSet rs = DBConn.statementQuery(sql);
		try {

			int price = 10;
			while (rs.next()) {
				price = rs.getInt("price");
			}
			
			
			sql = String.format( "SELECT order_detail_id , order_quantity  FROM ORDER_DETAILS WHERE order_id is null and user_id = %d and pr_st_id = %d" , userId , prstId );
			
			System.out.println( "sql: " + sql);
			rs = DBConn.statementQuery(sql);
			
			int hasquantity = 0;
			Long order_detail_id = 0L;
			
			while (rs.next()) {
				hasquantity = rs.getInt("order_quantity");
				order_detail_id = rs.getLong("order_detail_id");
			}
			
			if( hasquantity == 0 )
			{
				// 새로운 장바구니 
				sql = String.format(
						"INSERT INTO ORDER_DETAILS (order_id, user_id, pr_st_id, order_quantity, order_price) VALUES (null, %d, %d, %d, %d)" , 
						userId , prstId , quantity , price );
				
			}
			else
			{
				// 기존에 똑같은 상품 , 컬러 , 사이즈인 상품인 경우 수량만 추가 
				int sumQuantity = hasquantity + quantity;
				System.out.println( "sumQuantity: " + sumQuantity);
				sql = String.format( "UPDATE ORDER_DETAILS SET order_quantity = %d WHERE order_detail_id = %d" , sumQuantity , order_detail_id );
				
			}
	        
			System.out.println( "sql: " + sql);
			DBConn.statementUpdate(sql);
			

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConn.dbClose();
		}
		
	}

	public void updateShippingDate(Long orderId) {
		
		String sql = String.format(
				"UPDATE ORDERS SET shipping_date = sysdate WHERE order_id = %d", orderId );
				
		DBConn.statementUpdate(sql);
		
	}

}

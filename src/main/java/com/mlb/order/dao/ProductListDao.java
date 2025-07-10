package com.mlb.order.dao;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;

import com.mlb.order.dto.option.Color;
import com.mlb.order.dto.option.Product;
import com.mlb.order.dto.ProductDto;
import com.mlb.utils.DBConn;
import com.mlb.utils.UserInput;

// PRODUCTS 테이블 CRUD 작업을 수행하는 클래스
public class ProductListDao {
	
	//	TO_DATE('2025-02-21 16:15:13.730619500', 'YYYY-MM-DD HH24:MI:SS')
	public void insert(ProductDto dto) {
		
	}

	public ArrayList<ProductDto> selectByCategoryProductList( String caId , int begin , int end ) {
		
		// 'BallCap' , 'Hat'  , 'Season' ,'Beanie'
		ArrayList<ProductDto> dtos = new ArrayList<>();
		String sql = String.format("WITH PR_RESULT AS ( select ROWNUM as NO, P.pr_id, P.tm_id, P.ca_id, P.pr_name, P.pr_regdate, P.pr_thum_img, P.pr_detail_img from (select * from products order by pr_id desc ) P where P.ca_id = '%s' AND ROWNUM BETWEEN %d AND %d  ) SELECT * FROM PR_RESULT" ,
				caId , begin, end );
		
		
		ResultSet rs = DBConn.statementQuery(sql);
		System.out.println(sql);
		
		
		try {
			// 카테고리 상품 가져오기 
			while (rs.next()) {
				dtos.add( new ProductDto(rs.getLong("pr_id"), 
						rs.getString("tm_id"), 
						rs.getString("ca_id"),
						rs.getString("pr_name"), 
						rs.getTimestamp("pr_regdate").toLocalDateTime(),
						rs.getString("pr_thum_img"),
						rs.getString("pr_detail_img")
						));
			}
			
			// 상품의 재고 수량 가져오고 담기..
			for( ProductDto product : dtos )
			{
				ArrayList<Product> dtostocks = new ArrayList<>();
				
				sql = String.format("SELECT * FROM PRODUCT_STOCKS WHERE PRODUCT_STOCKS.pr_id = %d" , product.getPrId() );
				rs = DBConn.statementQuery(sql);
				System.out.println(sql);
				while (rs.next()) {
					dtostocks.add( new Product(rs.getLong("pr_st_id"), 
							rs.getLong("pr_id"), 
							rs.getString("cl_id"),
							rs.getString("sz_id"), 
							rs.getInt("quantity"),
							rs.getInt("price")
							));
				}
				
				product.setStocklist(dtostocks);
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConn.dbClose();
		}
		
		return dtos;
	}

	public void delete(Long id) {
		
	}

	public void update(ProductDto dto) {
		/*
		String sql = String.format(
				"UPDATE CUSTOMER SET name = '%s', age = %d, height = %.2f, birthday = TO_DATE('%s', 'YYYY-MM-DD HH24:MI:SS') WHERE id = %d",
				
				dto.getName(), dto.getAge(), dto.getHeight(),
                UserInput.dateToString(dto.getBirthday()), dto.getId());
		DBConn.statementUpdate(sql);
		*/
	}
	
	public Long getMaxId() {
		String sql = "SELECT MAX(id) as maxId FROM CUSTOMER";
        ResultSet rs = DBConn.statementQuery(sql);
		Long maxId = 0l;
		try {
			while(rs.next()){
				maxId = rs.getLong("maxId");
			}
		} catch(Exception e){
			e.printStackTrace();
		}
		return maxId;
	}
}
package com.mlb.store.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;

import com.mlb.store.dto.ProductsStocksDto;
import com.mlb.utils.DBConn;

public class ProductsStocksDao {
	// 카테고리별 조회
	public ArrayList<ProductsStocksDto> selectAllByCategory(String category){
		ArrayList<ProductsStocksDto> dto = new ArrayList<ProductsStocksDto>();
		String sql = String.format("select distinct p.pr_ID, p.pr_name, p.pr_thum_img, ps.price "
				+ "from products p, product_stocks ps where p.pr_id=ps.pr_id and p.ca_id='%s'", category);
//		System.out.println("====selectAllByCategory===" );
//		System.out.println(sql);
		ResultSet rs = DBConn.statementQuery(sql);
		try {
			while(rs.next()) {
				dto.add(new ProductsStocksDto(
						rs.getLong("pr_ID"),
						rs.getString("pr_name"), 
						rs.getString("pr_thum_img"), 
						rs.getInt("price")));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return dto;
	}
	
	
	// 카테고리별 팀 조회
	public ArrayList<ProductsStocksDto> selectByCaTeams(String category, String[] teams){
		ArrayList<ProductsStocksDto> dto = new ArrayList<ProductsStocksDto>();
		String teamList = String.join("','", teams); // 여러 팀 입력해야 돼서 Strin.join("','", teams) 일케 하면 teams 배열아이템을 la 다저스','뉴욕 양키스' 이케 바꿔줌
		String sql = String.format("select distinct p.pr_ID, p.pr_name, p.pr_thum_img, ps.price "
				+ "from products p, product_stocks ps, teams t "
				+ "where p.pr_id=ps.pr_id and p.tm_id=t.tm_id and ca_id='%s' and t.tm_id in ('%s')", category, teamList);
		
//		System.out.println("====selectByCaTeams===" );
//		System.out.println(sql);
		ResultSet rs = DBConn.statementQuery(sql);
		
		
		try {
			while(rs.next()) {
				dto.add(new ProductsStocksDto(
						rs.getLong("pr_ID"),
						rs.getString("pr_name"), 
						rs.getString("pr_thum_img"), 
						rs.getInt("price")));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return dto;
	}
	
	
	//카테고리별 신상품순 조회
	public ArrayList<ProductsStocksDto> selectByCaDate(String category){
		ArrayList<ProductsStocksDto> dto = new ArrayList<ProductsStocksDto>();
		String sql = String.format("select distinct p.pr_ID, p.pr_name, p.pr_thum_img, ps.price, p.pr_regdate "
				+ "from products p, product_stocks ps where p.pr_id=ps.pr_id and ca_id='%s' order by p.pr_regdate desc", category);
		ResultSet rs = DBConn.statementQuery(sql);
		try {
			while(rs.next()) {
				dto.add(new ProductsStocksDto(
						rs.getLong("pr_ID"),
						rs.getString("pr_name"),
						rs.getString("pr_thum_img"),
						rs.getInt("price")));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return dto;
	}
	
	// 검색
	public ArrayList<ProductsStocksDto> searchProducts(String input){
		ArrayList<ProductsStocksDto> dto = new ArrayList<ProductsStocksDto>();
		String sql = String.format("select distinct p.pr_ID, p.pr_name, p.pr_thum_img, ps.price from products p, product_stocks ps\r\n"
				+ "where p.pr_id=ps.pr_id and p.pr_name like '%%%s%%'", input); // %% -> % 
//		System.out.println("====searchProducts===" );
//		System.out.println(sql);
		ResultSet rs = DBConn.statementQuery(sql);
		try {
			while(rs.next()) {
				dto.add(new ProductsStocksDto(
						rs.getLong("pr_ID"),
						rs.getString("pr_name"),
						rs.getString("pr_thum_img"),
						rs.getInt("price")));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return dto;
	}
	
	
	// 검색->신상품순 재정렬
	public ArrayList<ProductsStocksDto> searchProductsByDate(String input){
		ArrayList<ProductsStocksDto> dto = new ArrayList<ProductsStocksDto>();
		String sql = String.format("select distinct p.pr_ID, p.pr_name, p.pr_thum_img, ps.price, p.pr_regdate from products p, product_stocks ps\r\n"
				+ "where p.pr_id=ps.pr_id and p.pr_name like '%%%s%%' order by p.pr_regdate desc", input); // %% -> % 
		System.out.println("====searchProductsByDate===" );
		System.out.println(sql);
		ResultSet rs = DBConn.statementQuery(sql);
		try {
			while(rs.next()) {
				dto.add(new ProductsStocksDto(
						rs.getLong("pr_ID"),
						rs.getString("pr_name"),
						rs.getString("pr_thum_img"),
						rs.getInt("price")));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return dto;
	}
	
	// 검색->팀별 재조회안됨ㅜㅜ
	public ArrayList<ProductsStocksDto> searchProductsByTeams(String input, String[] teams){
		ArrayList<ProductsStocksDto> dto = new ArrayList<ProductsStocksDto>();
		String teamList = String.join("','", teams);
		String sql = String.format("select distinct p.pr_id, p.pr_name, p.pr_thum_img, ps.price from products p, product_stocks ps, teams t\r\n"
				+ "where p.pr_id=ps.pr_id and p.tm_id=t.tm_id and t.tm_id in ('%s') and p.pr_name  like '%%%s%%'", teamList, input); // %% -> % 
		System.out.println("====searchProductsByTeams===" );
		System.out.println(sql);
		ResultSet rs = DBConn.statementQuery(sql);
		try {
			while(rs.next()) {
				dto.add(new ProductsStocksDto(
						rs.getLong("pr_ID"),
						rs.getString("pr_name"),
						rs.getString("pr_thum_img"),
						rs.getInt("price")));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return dto;
	}
	
	
	
	// 상품 갯수 세기
	public int countProducts(String input) {
		String sql = String.format("select count(*) count from products where pr_name like '%%%s%%'", input);
//		System.out.println(sql);
		ResultSet rs = DBConn.statementQuery(sql);
		int count = 0;
		try {
			if(rs.next()) {
				count = rs.getInt("count");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return count;
	}
	
	
	// 검색->팀별조회 상품갯수 조회
	public int countProductsByTeams(String input, String[] teams) {
		String teamList = String.join("','", teams);
		String sql = String.format("select count(*) count from products where pr_name like '%%%s%%' and tm_id in ('%s')", input, teamList);
		ResultSet rs = DBConn.statementQuery(sql);
		int count = 0;
		try {
			if(rs.next()) {
				count = rs.getInt("count");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return count;
	}

}

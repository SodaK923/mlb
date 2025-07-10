package com.mlb.product.dao;

import java.sql.ResultSet;
import java.util.*;

import com.mlb.product.dto.ProductStockDto;
import com.mlb.utils.*;

public class ProductStockDao {
    public ArrayList<ProductStockDto> selectAll(){
        ArrayList<ProductStockDto> list = new ArrayList<ProductStockDto>();
        String sql = "SELECT * FROM product_stocks";
        ResultSet rs = DBConn.statementQuery(sql);
        rs = DBConn.statementQuery(sql);
        try {
            while(rs.next()) {
                ProductStockDto dto = new ProductStockDto();
                dto.setPr_st_id(rs.getLong("pr_st_id"));
                dto.setPr_id(rs.getLong("pr_id"));
                dto.setCl_id(rs.getString("cl_id"));
                dto.setSz_id(rs.getString("sz_id"));
                dto.setQuantity(rs.getLong("quantity"));
                dto.setPrice(rs.getLong("price"));
                list.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public ArrayList<ProductStockDto> selectByProductId(Long pr_id){
        ArrayList<ProductStockDto> list = new ArrayList<ProductStockDto>();
        String sql = "SELECT * FROM product_stocks";
        ResultSet rs = DBConn.statementQuery(sql);
        if(pr_id != null){
            sql += " WHERE pr_id = " + pr_id;
        }
        rs = DBConn.statementQuery(sql);
        try {
            while(rs.next()) {
                ProductStockDto dto = new ProductStockDto();
                dto.setPr_st_id(rs.getLong("pr_st_id"));
                dto.setPr_id(rs.getLong("pr_id"));
                dto.setCl_id(rs.getString("cl_id"));
                dto.setSz_id(rs.getString("sz_id"));
                dto.setQuantity(rs.getLong("quantity"));
                dto.setPrice(rs.getLong("price"));
                list.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public ProductStockDto selectByProductStockId(Long pr_st_id) {
        ProductStockDto dto = new ProductStockDto();
        String sql = "SELECT * FROM product_stocks WHERE pr_st_id = " + pr_st_id;
        ResultSet rs = DBConn.statementQuery(sql);
        try {
            if(rs.next()) {
                dto.setPr_st_id(rs.getLong("pr_st_id"));
                dto.setPr_id(rs.getLong("pr_id"));
                dto.setCl_id(rs.getString("cl_id"));
                dto.setSz_id(rs.getString("sz_id"));
                dto.setQuantity(rs.getLong("quantity"));
                dto.setPrice(rs.getLong("price"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return dto;
    }

    public void update(ProductStockDto dto){
        String sql = "UPDATE product_stocks SET " 
        + "pr_id = " + dto.getPr_id() + " , " 
        + "cl_id = \'" + dto.getCl_id() + "\' , "
        + "sz_id = \'" + dto.getSz_id() + "\' , "
        + "quantity = " + dto.getQuantity() + " , "
        + "price = " + dto.getPrice()
        + " WHERE pr_st_id = " + dto.getPr_st_id();
        DBConn.statementUpdate(sql);
    }
    public void insert(ProductStockDto dto){
        String sql = "INSERT INTO product_stocks(pr_id, cl_id, sz_id, quantity, price) VALUES("
        + dto.getPr_id() + " , "
        + "\'" + dto.getCl_id() + "\' , "
        + "\'" + dto.getSz_id() + "\' , "
        + dto.getQuantity() + " , "
        + dto.getPrice() + ")";
        DBConn.statementUpdate(sql);
    }
    public void delete(Long pr_st_id){
        String sql = "DELETE FROM product_stocks WHERE pr_st_id = " + pr_st_id;
        DBConn.statementUpdate(sql);
    }

    public ArrayList<ProductStockDto> searchWithoutProductStockId(ProductStockDto dto){
        ArrayList<ProductStockDto> list = new ArrayList<ProductStockDto>();
        String sql = "SELECT * FROM product_stocks WHERE";
        if(dto.getPr_id() != null){
            sql += " pr_id = " + dto.getPr_id() + " AND ";
        }
        if(dto.getCl_id() != null){
            sql += " cl_id = \'" + dto.getCl_id() + "\' AND ";
        }
        if(dto.getSz_id() != null){
            sql += " sz_id = \'" + dto.getSz_id() + "\' AND ";
        }
        if(dto.getQuantity() != null){
            sql += " quantity = " + dto.getQuantity() + " AND ";
        }
        if(dto.getPrice() != null){
            sql += " price = " + dto.getPrice() + " AND ";
        }
        sql = sql.substring(0, sql.length() - 5);
        ResultSet rs = DBConn.statementQuery(sql);
        try {
            while(rs.next()) {
                ProductStockDto productStockDto = new ProductStockDto();
                productStockDto.setPr_st_id(rs.getLong("pr_st_id"));
                productStockDto.setPr_id(rs.getLong("pr_id"));
                productStockDto.setCl_id(rs.getString("cl_id"));
                productStockDto.setSz_id(rs.getString("sz_id"));
                productStockDto.setQuantity(rs.getLong("quantity"));
                productStockDto.setPrice(rs.getLong("price"));
                list.add(productStockDto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}

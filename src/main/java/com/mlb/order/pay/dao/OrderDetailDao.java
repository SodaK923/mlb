package com.mlb.order.pay.dao;

import java.sql.ResultSet;
import java.util.ArrayList;

import com.mlb.order.pay.dto.*;
import com.mlb.utils.*;

public class OrderDetailDao {
    public ArrayList<OrderDetailDto> selectCartByUserId(Long user_id) {
        ArrayList<OrderDetailDto> dtos = new ArrayList<OrderDetailDto>();
        String sql = "SELECT * FROM order_details WHERE order_id is NULL AND user_id = " + user_id;
        ResultSet rs = DBConn.statementQuery(sql);
        try {
            while (rs.next()) {
                OrderDetailDto dto = new OrderDetailDto();
                dto.setOrderDetailId(rs.getLong("order_detail_id"));
                dto.setOrderId(rs.getLong("order_id"));
                dto.setUserId(rs.getLong("user_id"));
                dto.setPrStId(rs.getLong("pr_st_id"));
                dto.setOrderQuantity(rs.getLong("order_quantity"));
                dto.setOrderPrice(rs.getLong("order_price"));
                dtos.add(dto);
            }
        } catch(Exception e){
            e.printStackTrace();
        }
        return dtos;
    }

    public ArrayList<OrderDetailDto> selectByOrderId(Long order_id){
        ArrayList<OrderDetailDto> dtos = new ArrayList<OrderDetailDto>();
        String sql = "SELECT * FROM order_details WHERE order_id = " + order_id;
        ResultSet rs = DBConn.statementQuery(sql);
        try {
            while (rs.next()) {
                OrderDetailDto dto = new OrderDetailDto();
                dto.setOrderDetailId(rs.getLong("order_detail_id"));
                dto.setOrderId(rs.getLong("order_id"));
                dto.setUserId(rs.getLong("user_id"));
                dto.setPrStId(rs.getLong("pr_st_id"));
                dto.setOrderQuantity(rs.getLong("order_quantity"));
                dto.setOrderPrice(rs.getLong("order_price"));
                dtos.add(dto);
            }
        } catch(Exception e){
            e.printStackTrace();
        }
        return dtos;
    }

    public OrderDetailDto selectByOrderDetailId(Long orderDetailId){
        OrderDetailDto dto = new OrderDetailDto();
        String sql = "SELECT * FROM order_details WHERE order_detail_id = " + orderDetailId;
        ResultSet rs = DBConn.statementQuery(sql);
        try {
            if (rs.next()) {
                dto.setOrderDetailId(rs.getLong("order_detail_id"));
                dto.setOrderId(rs.getLong("order_id"));
                dto.setUserId(rs.getLong("user_id"));
                dto.setPrStId(rs.getLong("pr_st_id"));
                dto.setOrderQuantity(rs.getLong("order_quantity"));
                dto.setOrderPrice(rs.getLong("order_price"));
            }
        } catch(Exception e){
            e.printStackTrace();
        }
        return dto;
    }

    public Long insert(OrderDetailDto dto) {
        String sql = "INSERT INTO order_details (order_id, user_id, pr_st_id, order_quantity, order_price) VALUES (" +
            dto.getOrderId() + ", " +
            dto.getUserId() + ", " +
            dto.getPrStId() + ", " +
            dto.getOrderQuantity() + ", " +
            dto.getOrderPrice() +  
        ")";
        DBConn.statementUpdate(sql);
        sql = "SELECT MAX(order_detail_id) FROM order_details WHERE user_id = " + dto.getUserId();
        try {
            ResultSet rs = DBConn.statementQuery(sql);
            if (rs.next()) {
                return rs.getLong(1);
            }
        } catch(Exception e){
            e.printStackTrace();
        }
        return null;
    }

    public void update(OrderDetailDto dto) {
        String sql = "UPDATE order_details SET " +
            "order_id = " + dto.getOrderId() + ", " +
            "user_id = " + dto.getUserId() + ", " +
            "pr_st_id = " + dto.getPrStId() + ", " +
            "order_quantity = " + dto.getOrderQuantity() + ", " +
            "order_price = " + dto.getOrderPrice() +
        " WHERE order_detail_id = " + dto.getOrderDetailId();
        DBConn.statementUpdate(sql);
    }

    public Long getMaxIdByUserId(Long userId) {
        String sql = "SELECT MAX(order_detail_id) FROM order_details WHERE user_id = " + userId;
        ResultSet rs = DBConn.statementQuery(sql);
        Long maxId = 0L;
        try {
            if (rs.next()) {
                maxId = rs.getLong(1);
            }
        } catch(Exception e){
            e.printStackTrace();
        }
        return maxId;
    }
}

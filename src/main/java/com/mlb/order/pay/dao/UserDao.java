package com.mlb.order.pay.dao;

import java.sql.ResultSet;

import com.mlb.order.pay.dto.*;
import com.mlb.utils.DBConn;

public class UserDao {
    public UserDto selectByUserId(Long userId) {
        UserDto user = new UserDto();
        String sql = "SELECT * FROM USERS WHERE user_id = " + userId;
        ResultSet rs = DBConn.statementQuery(sql);
        try {
            if (rs.next()) {
                user.setUserId(rs.getLong("user_id"));
                user.setGrade(rs.getString("grade"));
                user.setName(rs.getString("name"));
                user.setId(rs.getString("id"));
                user.setPw(rs.getString("pw"));
                user.setAddress(rs.getString("address"));
                user.setHp(rs.getString("hp"));
                user.setEmail(rs.getString("email"));
                user.setRegdate(rs.getTimestamp("regdate").toLocalDateTime());
            }
        } catch(Exception e){
            e.printStackTrace();
        }
        return user;
    }
}
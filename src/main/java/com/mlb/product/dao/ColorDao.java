package com.mlb.product.dao;

import java.sql.ResultSet;
import java.util.ArrayList;

import com.mlb.product.dto.ColorDto;
import com.mlb.utils.DBConn;

public class ColorDao {
    public ColorDto getColorById(String cl_id){
        String sql = "SELECT * FROM colors WHERE cl_id = \'" + cl_id + "\'";
        ResultSet rs = DBConn.statementQuery(sql);
        try {
            while(rs.next()){
                ColorDto color = new ColorDto(
                    rs.getString("cl_id"),
                    rs.getString("cl_name"),
                    rs.getString("cl_hexcode")
                );
                return color;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    public ArrayList<ColorDto> selectAll(){
        String sql = "SELECT * FROM colors";
        ResultSet rs = DBConn.statementQuery(sql);
        ArrayList<ColorDto> colors = new ArrayList<ColorDto>();

        try {
            while(rs.next()){
                ColorDto color = new ColorDto(
                    rs.getString("cl_id"),
                    rs.getString("cl_name"),
                    rs.getString("cl_hexcode")
                );
                colors.add(color);
            }
            return colors;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}

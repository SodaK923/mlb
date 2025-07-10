package com.mlb.product.dao;

import java.sql.ResultSet;
import java.util.ArrayList;

import com.mlb.product.dto.TeamDto;
import com.mlb.utils.DBConn;

public class TeamDao {
    public TeamDto selectByTeamId(String tm_id) {
        String sql = "SELECT * FROM teams WHERE tm_id = \'" + tm_id + "\'";
        ResultSet rs = DBConn.statementQuery(sql);
        try {
            while(rs.next()) {
                TeamDto team = new TeamDto();
                team.setTm_id(rs.getString("tm_id"));
                team.setTm_name(rs.getString("tm_name"));
                return team;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return new TeamDto();
    }

    public ArrayList<TeamDto> selectAll(){
        String sql = "SELECT * FROM teams";
        ResultSet rs = DBConn.statementQuery(sql);
        ArrayList<TeamDto> list = new ArrayList<TeamDto>();
        try {
            while(rs.next()) {
                TeamDto team = new TeamDto();
                team.setTm_id(rs.getString("tm_id"));
                team.setTm_name(rs.getString("tm_name"));
                list.add(team);
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
        return list;
    }

}

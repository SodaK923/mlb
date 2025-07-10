package com.mlb.customer;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import com.mlb.utils.DBConn;

public class UserDao {
	
	public static boolean registerUser(UserDto user) {
        // INSERT 문을 실행할 SQL 쿼리 생성(회원가입)
        String sql = String.format(
            "INSERT INTO users (grade, name, id, pw, address, hp, email, regdate) " +
            "VALUES ('%s', '%s', '%s', '%s', '%s', '%s', '%s', SYSDATE)",
            user.getGrade(), user.getName(), user.getId(), user.getPw(),
            user.getAddress(), user.getHp(), user.getEmail()
        );

        try {
            // DBConn을 사용하여 실행
            int result = DBConn.statementUpdate(sql);
            return result > 0; // 성공 여부 반환
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
	}
	
    public static List<UserDto> getAllUsers() {
        List<UserDto> users = new ArrayList<>();
        
        // SQL 쿼리 작성
        String sql = "SELECT user_Id, grade, name, id, pw, address, hp, email, regdate FROM users";

        try {
            // DB 연결 및 쿼리 실행
            ResultSet rs = DBConn.statementQuery(sql);
            
            while (rs.next()) {
                UserDto user = new UserDto(
                    rs.getLong("user_Id"),
                    rs.getString("grade"),
                    rs.getString("name"),
                    rs.getString("id"),
                    rs.getString("pw"),
                    rs.getString("address"),
                    rs.getString("hp"),
                    rs.getString("email"),
                    rs.getTimestamp("regdate").toLocalDateTime()
                );
                users.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return users;
    }


    public static UserDto getUser(String userId, String password) {
    	//로그인
        String sql = String.format("SELECT * FROM users WHERE Id = '%s'", userId);
        ResultSet rs = DBConn.statementQuery(sql);
        try {
            if (rs.next()) {
                String storedPassword = rs.getString("pw");
                if (storedPassword.equals(password)) {
                    return new UserDto(
                        rs.getLong("user_id"),
                        rs.getString("grade"),
                        rs.getString("name"),
                        rs.getString("id"),
                        rs.getString("pw"),
                        rs.getString("address"),
                        rs.getString("hp"),
                        rs.getString("email"),
                        rs.getTimestamp("regdate").toLocalDateTime()
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public String findUserId(String name, String email) {
    	//아이디 찾기
        String userId = null;

        String sql = String.format("SELECT id FROM users WHERE name = '%s' AND email = '%s'", name, email);

        ResultSet rs = DBConn.statementQuery(sql);

        try {
            
            if (rs.next()) {
                userId = rs.getString("id");
            }
        } catch (SQLException e) {
            e.printStackTrace();  
        }

        return userId;  
    }
    
    public String resetPassword(String id, String email) {
        String newPassword = generateRandomPassword(); // 새로운 랜덤 비밀번호 생성

        // 사용자의 존재 여부 확인
        String checkSql = String.format("SELECT * FROM users WHERE id = '%s' AND email = '%s'", id, email);
        ResultSet rs = DBConn.statementQuery(checkSql);

        try {
            if (rs.next()) {
                // 비밀번호 업데이트 SQL 실행
                String updateSql = String.format("UPDATE users SET pw = '%s' WHERE id = '%s'", newPassword, id);
                int result = DBConn.statementUpdate(updateSql);

                if (result > 0) {
                    return newPassword; // 새로운 비밀번호 반환
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // 랜덤 비밀번호 생성 메서드
    private String generateRandomPassword() {
        return UUID.randomUUID().toString().substring(0, 8); // 8자리 랜덤 문자열 생성
    }
    
    // 사용자 정보 수정
    public static boolean updateUser(UserDto user, boolean updatePassword) {
        String sql;
        if (updatePassword) {
            sql = String.format(
                "UPDATE users SET name = '%s', email = '%s', hp = '%s', address = '%s', pw = '%s' WHERE id = '%s'",
                user.getName(), user.getEmail(), user.getHp(), user.getAddress(), user.getPw(), user.getId()
            );
        } else {
            sql = String.format(
                "UPDATE users SET name = '%s', email = '%s', hp = '%s', address = '%s' WHERE id = '%s'",
                user.getName(), user.getEmail(), user.getHp(), user.getAddress(), user.getId()
            );
        }
        
        return DBConn.statementUpdate(sql) > 0;
    }

    public static boolean deleteUser(Long userId) {
        String sql = String.format("DELETE FROM users WHERE user_id = %d", userId);
        return DBConn.statementUpdate(sql) > 0;
    }

    public static Long getMaxUserId() {
        String sql = "SELECT MAX(userId) AS maxId FROM users";
        ResultSet rs = DBConn.statementQuery(sql);
        Long maxId = 0L;
        try {
            if (rs.next()) {
                maxId = rs.getLong("maxId");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return maxId;
    }
}
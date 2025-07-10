package com.mlb.order.pay.dto;

import java.time.LocalDateTime;
import java.util.Objects;

public class UserDto {
	private Long userId;
	private String grade;
	private String name;
	private String id;
	private String pw;
	private String address;
	private String hp;
	private String email;
	private LocalDateTime regdate;
	
	@Override
	public String toString() {
		return "UserDto [userId=" + userId + ", grade=" + grade + ", name=" + name + ", id=" + id + ", pw=" + pw
				+ ", address=" + address + ", hp=" + hp + ", email=" + email + ", regdate=" + regdate + "]";
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getHp() {
		return hp;
	}

	public void setHp(String hp) {
		this.hp = hp;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public LocalDateTime getRegdate() {
		return regdate;
	}

	public void setRegdate(LocalDateTime regdate) {
		this.regdate = regdate;
	}

	@Override
	public int hashCode() {
		return Objects.hash(address, email, grade, hp, id, name, pw, regdate, userId);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		UserDto other = (UserDto) obj;
		return Objects.equals(address, other.address) && Objects.equals(email, other.email)
				&& Objects.equals(grade, other.grade) && Objects.equals(hp, other.hp) && Objects.equals(id, other.id)
				&& Objects.equals(name, other.name) && Objects.equals(pw, other.pw)
				&& Objects.equals(regdate, other.regdate) && Objects.equals(userId, other.userId);
	}
	
	public UserDto() {}
	public UserDto(Long userId, String grade, String name, String id, String pw, String address, String hp,
			String email, LocalDateTime regdate) {
		super();
		this.userId = userId;
		this.grade = grade;
		this.name = name;
		this.id = id;
		this.pw = pw;
		this.address = address;
		this.hp = hp;
		this.email = email;
		this.regdate = regdate;
	}
	
	
	
}
	
	


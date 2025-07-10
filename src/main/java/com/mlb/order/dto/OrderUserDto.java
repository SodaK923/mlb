package com.mlb.order.dto;


import java.time.LocalDateTime;
import java.util.Objects;

public class OrderUserDto {
	
	private Long numId;
	private Long userId;
	private String logId;
	private String userName;
	private String userHP;
	private String userEmail;
	private Long orderId;
	private LocalDateTime orderDate;
	private Integer totalPrice;
	private String payId;
	private String shippingAddress;
	private LocalDateTime shippingDate;
	
	
	public OrderUserDto() {};
	
	public OrderUserDto(Long numId, Long userId, 
			String logId, String userName, String userHP, String userEmail,
			Long orderId, LocalDateTime orderDate, Integer totalPrice, String payId, 
			String shippingAddress,	LocalDateTime shippingDate) {
		
		this.numId = numId;
		this.userId = userId;
		this.logId = logId;
		this.userName = userName;
		this.userHP = userHP;
		this.userEmail = userEmail;
		this.orderId = orderId;
		this.orderDate = orderDate;
		this.totalPrice = totalPrice;
		this.payId = payId;
		this.shippingAddress = shippingAddress;
		this.shippingDate = shippingDate;
	}

	public Long getNumId() {
		return numId;
	}

	public void setNumId(Long numId) {
		this.numId = numId;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public String getLogId() {
		return logId;
	}

	public void setLogId(String logId) {
		this.logId = logId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserHP() {
		return userHP;
	}

	public void setUserHP(String userHP) {
		this.userHP = userHP;
	}

	public String getUserEmail() {
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	public Long getOrderId() {
		return orderId;
	}

	public void setOrderId(Long orderId) {
		this.orderId = orderId;
	}

	public LocalDateTime getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(LocalDateTime orderDate) {
		this.orderDate = orderDate;
	}

	public Integer getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(Integer totalPrice) {
		this.totalPrice = totalPrice;
	}

	public String getPayId() {
		return payId;
	}

	public void setPayId(String payId) {
		this.payId = payId;
	}

	public String getShippingAddress() {
		return shippingAddress;
	}

	public void setShippingAddress(String shippingAddress) {
		this.shippingAddress = shippingAddress;
	}

	public LocalDateTime getShippingDate() {
		return shippingDate;
	}

	public void setShippingDate(LocalDateTime shippingDate) {
		this.shippingDate = shippingDate;
	}

	@Override
	public int hashCode() {
		return Objects.hash(logId, numId, orderDate, orderId, payId, shippingAddress, shippingDate, totalPrice,
				userEmail, userHP, userId, userName);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		OrderUserDto other = (OrderUserDto) obj;
		return Objects.equals(logId, other.logId) && Objects.equals(numId, other.numId)
				&& Objects.equals(orderDate, other.orderDate) && Objects.equals(orderId, other.orderId)
				&& Objects.equals(payId, other.payId) && Objects.equals(shippingAddress, other.shippingAddress)
				&& Objects.equals(shippingDate, other.shippingDate) && Objects.equals(totalPrice, other.totalPrice)
				&& Objects.equals(userEmail, other.userEmail) && Objects.equals(userHP, other.userHP)
				&& Objects.equals(userId, other.userId) && Objects.equals(userName, other.userName);
	}

	@Override
	public String toString() {
		return "OrderUserDto [numId=" + numId + ", userId=" + userId + ", logId=" + logId + ", userName=" + userName
				+ ", userHP=" + userHP + ", userEmail=" + userEmail + ", orderId=" + orderId + ", orderDate="
				+ orderDate + ", totalPrice=" + totalPrice + ", payId=" + payId + ", shippingAddress=" + shippingAddress
				+ ", shippingDate=" + shippingDate + "]";
	}
	
	

}

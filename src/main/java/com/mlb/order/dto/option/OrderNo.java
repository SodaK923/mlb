package com.mlb.order.dto.option;

import java.time.LocalDateTime;
import java.util.Objects;

public class OrderNo {
	
	private Long orderId;
	private LocalDateTime orderDate;
	private Integer totalPrice;
	private String payId;
	private String shippingAddress;
	private LocalDateTime shippingDate;
	
	
	public OrderNo() {}

	public OrderNo(Long orderId, LocalDateTime orderDate, Integer totalPrice, String payId,
			String shippingAddress , LocalDateTime shippingDate) {
		this.orderId = orderId;
		this.orderDate = orderDate;
		this.totalPrice = totalPrice;
		this.payId = payId;
		this.shippingAddress = shippingAddress;
		this.shippingDate = shippingDate;
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

	public LocalDateTime getShippingDate() {
		
		if( shippingDate == null)
		{
			shippingDate = LocalDateTime.now();
			shippingDate.plusDays(3);
		}
		return shippingDate;
	}

	public void setShippingDate(LocalDateTime shippingDate) {
		this.shippingDate = shippingDate;
	}

	public String getShippingAddress() {
		return shippingAddress;
	}

	public void setShippingAddress(String shippingAddress) {
		this.shippingAddress = shippingAddress;
	}

	@Override
	public int hashCode() {
		return Objects.hash(orderDate, orderId, payId, shippingAddress, shippingDate, totalPrice);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		OrderNo other = (OrderNo) obj;
		return Objects.equals(orderDate, other.orderDate) && Objects.equals(orderId, other.orderId)
				&& Objects.equals(payId, other.payId) && Objects.equals(shippingAddress, other.shippingAddress)
				&& Objects.equals(shippingDate, other.shippingDate) && Objects.equals(totalPrice, other.totalPrice);
	}

	@Override
	public String toString() {
		return "OrderNo [orderId=" + orderId + ", orderDate=" + orderDate + ", totalPrice=" + totalPrice + ", payId="
				+ payId + ", shippingAddress=" + shippingAddress + ", shippingDate=" + shippingDate + "]";
	}

	
	
	
	
}

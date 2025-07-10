package com.mlb.order.dto.option;

import java.util.Objects;

public class OrderDetail {
	
	
	private Long orderId = 0L;
	private Long userId;
	private Long orderDetailId;
	private String prName;
	private String prThumImg;
	
	private Product product;
	
	
	
	public OrderDetail( 
			Long userId, 
			Long orderDetailId, 
			Integer orderQuantity, 
			Integer orderPrice ,
			String prName , 
			String prThumImg , 
			Long prId , 
			Long prStId , 
			String clId , 
			String szId ) 
	{
		
		this.userId = userId;
		this.orderDetailId = orderDetailId;
		this.prName = prName;
		this.prThumImg = prThumImg;
		
		product = new Product( prStId,  prId , clId, szId, orderQuantity, orderPrice);
	}

	public Long getOrderId() {
		return orderId;
	}

	public void setOrderId(Long orderId) {
		this.orderId = orderId;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	public Long getOrderDetailId() {
		return orderDetailId;
	}

	public void setOrderDetailId(Long orderDetailId) {
		this.orderDetailId = orderDetailId;
	}
	
	

	public String getPrName() {
		return prName;
	}

	public void setPrName(String prName) {
		this.prName = prName;
	}

	public String getPrThumImg() {
		return prThumImg;
	}

	public void setPrThumImg(String prThumImg) {
		this.prThumImg = prThumImg;
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	@Override
	public int hashCode() {
		return Objects.hash(orderDetailId, orderId, product, userId);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		OrderDetail other = (OrderDetail) obj;
		return Objects.equals(orderDetailId, other.orderDetailId) && Objects.equals(orderId, other.orderId)
				&& Objects.equals(product, other.product) && Objects.equals(userId, other.userId);
	}

	@Override
	public String toString() {
		return "OrderDetail [orderId=" + orderId + ", userId=" + userId + ", orderDetailId=" + orderDetailId
				+ ", product=" + product + "]";
	}

	
	
}

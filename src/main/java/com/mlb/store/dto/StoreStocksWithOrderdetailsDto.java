package com.mlb.store.dto;


//CREATE TABLE ORDER_DETAILS (
//	    order_detail_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY, -- 자동 증가 주문 상세 ID
//	    order_id NUMBER , -- 주문 ID (외래 키 참조)
//	    user_id NUMBER NOT NULL, -- 사용자 ID (외래 키 참조)
//	    pr_st_id NUMBER NOT NULL, -- 제품 재고 ID (외래 키 참조)
//	    order_quantity NUMBER NOT NULL, -- 주문 수량
//	    order_price NUMBER NOT NULL, -- 주문 가격
import java.util.Objects;

//	);

public class StoreStocksWithOrderdetailsDto {
	private Long prID;
	private String prName;
	private Long prStID;
	private String clID;
	private String szID;
	private Integer quantity;
	private Integer price;
	
	private String userID;
	private Integer orderPrice;
	@Override
	public int hashCode() {
		return Objects.hash(clID, orderPrice, prID, prName, prStID, price, quantity, szID, userID);
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		StoreStocksWithOrderdetailsDto other = (StoreStocksWithOrderdetailsDto) obj;
		return Objects.equals(clID, other.clID) && Objects.equals(orderPrice, other.orderPrice)
				&& Objects.equals(prID, other.prID) && Objects.equals(prName, other.prName)
				&& Objects.equals(prStID, other.prStID) && Objects.equals(price, other.price)
				&& Objects.equals(quantity, other.quantity) && Objects.equals(szID, other.szID)
				&& Objects.equals(userID, other.userID);
	}
	public Long getPrID() {
		return prID;
	}
	public void setPrID(Long prID) {
		this.prID = prID;
	}
	public String getPrName() {
		return prName;
	}
	public void setPrName(String prName) {
		this.prName = prName;
	}
	public Long getPrStID() {
		return prStID;
	}
	public void setPrStID(Long prStID) {
		this.prStID = prStID;
	}
	public String getClID() {
		return clID;
	}
	public void setClID(String clID) {
		this.clID = clID;
	}
	public String getSzID() {
		return szID;
	}
	public void setSzID(String szID) {
		this.szID = szID;
	}
	public Integer getQuantity() {
		return quantity;
	}
	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}
	public Integer getPrice() {
		return price;
	}
	public void setPrice(Integer price) {
		this.price = price;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public Integer getOrderPrice() {
		return orderPrice;
	}
	public void setOrderPrice(Integer orderPrice) {
		this.orderPrice = orderPrice;
	}
	@Override
	public String toString() {
		return "StoreProductStocksWithOrderdetails [prID=" + prID + ", prName=" + prName + ", prStID=" + prStID
				+ ", clID=" + clID + ", szID=" + szID + ", quantity=" + quantity + ", price=" + price + ", userID="
				+ userID + ", orderPrice=" + orderPrice + "]";
	}
	public StoreStocksWithOrderdetailsDto() {}
	public StoreStocksWithOrderdetailsDto(Long prID, String prName, Long prStID, String clID, String szID,
			Integer quantity, Integer price, String userID, Integer orderPrice) {
		super();
		this.prID = prID;
		this.prName = prName;
		this.prStID = prStID;
		this.clID = clID;
		this.szID = szID;
		this.quantity = quantity;
		this.price = price;
		this.userID = userID;
		this.orderPrice = orderPrice;
	}


}

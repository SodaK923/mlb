package com.mlb.store.dto;

import java.time.LocalDateTime;
import java.util.Objects;

public class ProductsStocksDto {
	private Long prID;
	private String tmID;
	private String caID;
	private String prName;
	private LocalDateTime prRegdate;
	private String prThumImg;
	
	private Long prStID;
	private String clID;
	private String szID;
	private Integer quantity;
	private Integer price;

	


	public Long getPrID() {
		return prID;
	}


	public void setPrID(Long prID) {
		this.prID = prID;
	}


	public String getTmID() {
		return tmID;
	}


	public void setTmID(String tmID) {
		this.tmID = tmID;
	}


	public String getCaID() {
		return caID;
	}


	public void setCaID(String caID) {
		this.caID = caID;
	}


	public String getPrName() {
		return prName;
	}


	public void setPrName(String prName) {
		this.prName = prName;
	}


	public LocalDateTime getPrRegdate() {
		return prRegdate;
	}


	public void setPrRegdate(LocalDateTime prRegdate) {
		this.prRegdate = prRegdate;
	}


	public String getPrThumImg() {
		return prThumImg;
	}


	public void setPrThumImg(String prThumImg) {
		this.prThumImg = prThumImg;
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

	
	
	@Override
	public int hashCode() {
		return Objects.hash(caID, clID, prID, prName, prRegdate, prStID, prThumImg, price, quantity, szID, tmID);
	}


	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		ProductsStocksDto other = (ProductsStocksDto) obj;
		return Objects.equals(caID, other.caID) && Objects.equals(clID, other.clID) && Objects.equals(prID, other.prID)
				&& Objects.equals(prName, other.prName) && Objects.equals(prRegdate, other.prRegdate)
				&& Objects.equals(prStID, other.prStID) && Objects.equals(prThumImg, other.prThumImg)
				&& Objects.equals(price, other.price) && Objects.equals(quantity, other.quantity)
				&& Objects.equals(szID, other.szID) && Objects.equals(tmID, other.tmID);
	}

	

	@Override
	public String toString() {
		return "ProductsStocksDto [prID=" + prID + ", tmID=" + tmID + ", caID=" + caID + ", prName=" + prName
				+ ", prRegdate=" + prRegdate + ", prThumImg=" + prThumImg + ", prStID=" + prStID + ", clID=" + clID
				+ ", szID=" + szID + ", quantity=" + quantity + ", price=" + price + "]";
	}

	

	public ProductsStocksDto(Long prID, String tmID, String caID, String prName, LocalDateTime prRegdate,
			String prThumImg, Long prStID, String clID, String szID, Integer quantity, Integer price) {
		super();
		this.prID = prID;
		this.tmID = tmID;
		this.caID = caID;
		this.prName = prName;
		this.prRegdate = prRegdate;
		this.prThumImg = prThumImg;
		this.prStID = prStID;
		this.clID = clID;
		this.szID = szID;
		this.quantity = quantity;
		this.price = price;
	}


	//썸네일: 상품명, 썸네일 이미지, 가격
	public ProductsStocksDto(Long prID, String prName, String prThumImg, Integer price) {
		super();
		this.prID = prID;
		this.prName = prName;
		this.prThumImg = prThumImg;
		this.price = price;
	}


	public ProductsStocksDto() {
		super();
	}
	
	

}

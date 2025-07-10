package com.mlb.store.dto;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Objects;

public class StoreProductWithStocksDto {
    private Long prID;
    private String prName;
    private String caID;
    private String tmID;
    private String szID;
    private String clID;
    private Integer price;
    private Integer quantity;
    private String prThumImg;
    private String prDetailImg;
    private Long prStID;
    private LocalDateTime prRegdate;
    private ArrayList<StoreProductWithStocksDto> productStocks;  


    public ArrayList<StoreProductWithStocksDto> getProductStocks() {
        return productStocks;
    }


	@Override
	public int hashCode() {
		return Objects.hash(caID, clID, prDetailImg, prID, prName, prRegdate, prStID, prThumImg, price, productStocks,
				quantity, szID, tmID);
	}


	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		StoreProductWithStocksDto other = (StoreProductWithStocksDto) obj;
		return Objects.equals(caID, other.caID) && Objects.equals(clID, other.clID)
				&& Objects.equals(prDetailImg, other.prDetailImg) && Objects.equals(prID, other.prID)
				&& Objects.equals(prName, other.prName) && Objects.equals(prRegdate, other.prRegdate)
				&& Objects.equals(prStID, other.prStID) && Objects.equals(prThumImg, other.prThumImg)
				&& Objects.equals(price, other.price) && Objects.equals(productStocks, other.productStocks)
				&& Objects.equals(quantity, other.quantity) && Objects.equals(szID, other.szID)
				&& Objects.equals(tmID, other.tmID);
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


	public String getCaID() {
		return caID;
	}


	public void setCaID(String caID) {
		this.caID = caID;
	}


	public String getTmID() {
		return tmID;
	}


	public void setTmID(String tmID) {
		this.tmID = tmID;
	}


	public String getSzID() {
		return szID;
	}


	public void setSzID(String szID) {
		this.szID = szID;
	}


	public String getClID() {
		return clID;
	}


	public void setClID(String clID) {
		this.clID = clID;
	}


	public Integer getPrice() {
		return price;
	}


	public void setPrice(Integer price) {
		this.price = price;
	}


	public Integer getQuantity() {
		return quantity;
	}


	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}


	public String getPrThumImg() {
		return prThumImg;
	}


	public void setPrThumImg(String prThumImg) {
		this.prThumImg = prThumImg;
	}


	public String getPrDetailImg() {
		return prDetailImg;
	}


	public void setPrDetailImg(String prDetailImg) {
		this.prDetailImg = prDetailImg;
	}


	public Long getPrStID() {
		return prStID;
	}


	public void setPrStID(Long prStID) {
		this.prStID = prStID;
	}


	public LocalDateTime getPrRegdate() {
		return prRegdate;
	}


	public void setPrRegdate(LocalDateTime prRegdate) {
		this.prRegdate = prRegdate;
	}


	public void setProductStocks(ArrayList<StoreProductWithStocksDto> productStocks) {
		this.productStocks = productStocks;
	}


	@Override
	public String toString() {
		return "ProductWithStocksDto [prID=" + prID + ", prName=" + prName + ", caID=" + caID + ", tmID=" + tmID
				+ ", szID=" + szID + ", clID=" + clID + ", price=" + price + ", quantity=" + quantity + ", prThumImg="
				+ prThumImg + ", prDetailImg=" + prDetailImg + ", prStID=" + prStID + ", prRegdate=" + prRegdate
				+ ", productStocks=" + productStocks + "]";
	}

	public StoreProductWithStocksDto() {}
	public StoreProductWithStocksDto(Long prID, String prName, String caID, String tmID, String szID, String clID,
			Integer price, Integer quantity, String prThumImg, String prDetailImg, Long prStID, LocalDateTime prRegdate,
			ArrayList<StoreProductWithStocksDto> productStocks) {
		super();
		this.prID = prID;
		this.prName = prName;
		this.caID = caID;
		this.tmID = tmID;
		this.szID = szID;
		this.clID = clID;
		this.price = price;
		this.quantity = quantity;
		this.prThumImg = prThumImg;
		this.prDetailImg = prDetailImg;
		this.prStID = prStID;
		this.prRegdate = prRegdate;
		this.productStocks = productStocks;
	}


}
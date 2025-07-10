package com.mlb.order.dto;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.Objects;

import com.mlb.order.dto.option.*;

public class ProductDto {

	private Long prId;
	private String tmId;
	private String caId;
	private String prName;
	private LocalDateTime regDate;
	
	private String prThumImg;
	private String prDetailImg;
	
	private ArrayList<Product> productlist;
	private int price;
	
	public ProductDto(Long prId, String tmId, String caId, String prName, LocalDateTime regDate, String prThumImg,
			String prDetailImg) {
		
		this.prId = prId;
		this.tmId = tmId;
		this.caId = caId;
		this.prName = prName;
		this.regDate = regDate;
		this.prThumImg = prThumImg;
		this.prDetailImg = prDetailImg;
	}

	public Long getPrId() {
		return prId;
	}

	public void setPrId(Long prId) {
		this.prId = prId;
	}

	public String getTmId() {
		return tmId;
	}

	public void setTmId(String tmId) {
		this.tmId = tmId;
	}

	public String getCaId() {
		return caId;
	}

	public void setCaId(String caId) {
		this.caId = caId;
	}

	public String getPrName() {
		return prName;
	}

	public void setPrName(String prName) {
		this.prName = prName;
	}

	public LocalDateTime getRegDate() {
		return regDate;
	}

	public void setRegDate(LocalDateTime regDate) {
		this.regDate = regDate;
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

	
	
	
	
	
	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public ArrayList<Product> getStocklist() {
		return productlist;
	}

	public void setStocklist(ArrayList<Product> stocklist) {
		this.productlist = stocklist;
		setPrice(false);
	}
	
	// 재고로 보유한 컬러 Hexcode ...
	public HashSet<String> getStockColorHexcode()
	{
		HashSet<String> stockColorSet = new HashSet<>();
		
		for( Product s : productlist )
		{
			stockColorSet.add( s.getColor().getHexcode() );
		}
		
		return stockColorSet;
	}
	
	public HashSet<Color> getStockColors()
	{
		HashSet<Color> stockColorSet = new HashSet<>();
		
		for( Product s : productlist )
		{
			stockColorSet.add( s.getColor() );
		}
		
		return stockColorSet;
	}
	
	// 해당컬러가 보유한 상품 사이즈 
	public HashSet<String> getStockSize(String clId )
	{
		HashSet<String> stockSizeSet = new HashSet<>();
		
		for( Product s : productlist )
		{
			if( s.getColor().getId() == clId )
				stockSizeSet.add( s.getSzId() );
			
		}
		
		return stockSizeSet;
	}
	
	// 상품 재고 중 제일 높은 or 낮은 금액
	private void setPrice( boolean bMaxPrice )
	{
		
		this.price = productlist.get(0).getPrice();
		
		for( Product s : productlist )
		{
			int curPrice = s.getPrice();
			if( bMaxPrice ) {
				if( price < curPrice )
					price = curPrice;
				
			} else {
				if( price > curPrice )
					price = curPrice;
				
			}
			
		}
		
		// System.out.println("setPrice:"+price);
		
	}
	
	
	// 재고 수량 확인 ( 컬러 ID , 사이즈 ID )
	public int getStockQuantity( String clId , String szId )
	{
		int quantity = 0;
		for( Product s : productlist )
		{
			if( s.getColor().getId() == clId && s.getSzId() == szId )
			{
				return quantity = s.getQuantity();
			}
		}
		return quantity;
	}

	@Override
	public int hashCode() {
		return Objects.hash(caId, prDetailImg, prId, prName, prThumImg, regDate, productlist, tmId);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		ProductDto other = (ProductDto) obj;
		return Objects.equals(caId, other.caId) && Objects.equals(prDetailImg, other.prDetailImg)
				&& Objects.equals(prId, other.prId) && Objects.equals(prName, other.prName)
				&& Objects.equals(prThumImg, other.prThumImg) && Objects.equals(regDate, other.regDate)
				&& Objects.equals(productlist, other.productlist) && Objects.equals(tmId, other.tmId);
	}

	@Override
	public String toString() {
		return "ProductDto [prId=" + prId + ", tmId=" + tmId + ", caId=" + caId + ", prName=" + prName + ", regDate="
				+ regDate + ", prThumImg=" + prThumImg + ", prDetailImg=" + prDetailImg + ", productlist=" + productlist
				+ "]";
	}

	
	
	
	
	
}

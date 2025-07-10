package com.mlb.order.dto.option;

import java.util.Objects;

public class Product {
	
	private Long prStId;
	private Long prId;
	private Color color;
	private String szId;//'XS', 'S', 'M', 'L', 'XL', 'XXL'
	private int quantity;
	private int price;
	

	public Product( Long prStId, Long prId , String clId, String szId, int quantity, int price) {
		
		this.prStId = prStId;
		this.prId = prId;
		
		for( Color c : Color.values() )
		{
			if( c.getId().equals(clId) )
			{
				color = c;
				break;
			}
		}
		
		this.szId = szId;
		this.quantity = quantity;
		this.price = price;
		
	}
	
	public Long getPrStId() {
		return prStId;
	}



	public void setPrStId(Long prStId) {
		this.prStId = prStId;
	}



	public Long getPrId() {
		return prId;
	}



	public void setPrId(Long prId) {
		this.prId = prId;
	}
	
	public Color getColor() {
		return color;
	}


	public void setColor(Color color) {
		this.color = color;
	}

	public String getSzId() {
		return szId;
	}

	public void setSzId(String szId) {
		this.szId = szId;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	@Override
	public int hashCode() {
		return Objects.hash(color, prId, prStId, price, quantity, szId);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Product other = (Product) obj;
		return color == other.color && Objects.equals(prId, other.prId) && Objects.equals(prStId, other.prStId)
				&& price == other.price && quantity == other.quantity && Objects.equals(szId, other.szId);
	}

	@Override
	public String toString() {
		return "Stock [prStId=" + prStId + ", prId=" + prId + ", color=" + color + ", szId=" + szId + ", quantity="
				+ quantity + ", price=" + price + "]";
	}

	
	
	
	

}

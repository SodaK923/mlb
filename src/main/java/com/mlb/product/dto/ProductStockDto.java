package com.mlb.product.dto;

import com.mlb.product.dao.ColorDao;

public class ProductStockDto {
	private Long pr_st_id;
	private Long pr_id;
	private String cl_id;
	private String sz_id;
	private Long quantity;
	private Long price;

	public ProductStockDto() {
	}
	
	public ProductStockDto(Long pr_st_id, Long pr_id, String cl_id, String sz_id, Long quantity, Long price) {
		this.pr_st_id = pr_st_id;
		this.pr_id = pr_id;
		this.cl_id = cl_id;
		this.sz_id = sz_id;
		this.quantity = quantity;
		this.price = price;
	}

	public Long getPr_st_id() {
		return pr_st_id;
	}

	public void setPr_st_id(Long pr_st_id) {
		this.pr_st_id = pr_st_id;
	}

	public Long getPr_id() {
		return pr_id;
	}

	public void setPr_id(Long pr_id) {
		this.pr_id = pr_id;
	}

	public String getCl_id() {
		return cl_id;
	}

	public void setCl_id(String cl_id) {
		this.cl_id = cl_id;
	}

	public String getCl_hexcode() {
		return new ColorDao().getColorById(cl_id).getCl_hexcode();
	}

	public String getCl_name() {
		return new ColorDao().getColorById(cl_id).getCl_name();
	}

	public String getSz_id() {
		return sz_id;
	}

	public void setSz_id(String sz_id) {
		this.sz_id = sz_id;
	}

	public Long getQuantity() {
		return quantity;
	}

	public void setQuantity(Long quantity) {
		this.quantity = quantity;
	}

	public Long getPrice() {
		return price;
	}

	public void setPrice(Long price) {
		this.price = price;
	}

	@Override
	public String toString() {
		return "ProductStockDto [pr_st_id=" + pr_st_id + ", pr_id=" + pr_id + ", cl_id=" + cl_id + ", sz_id=" + sz_id
				+ ", quantity=" + quantity + ", price=" + price + "]";
	}

	@Override
	public boolean equals(Object obj) {
		if(obj instanceof ProductStockDto) {
			ProductStockDto dto = (ProductStockDto) obj;
			if(this.pr_st_id == dto.pr_st_id) {
				return true;
			}
		}
		return false;
	}
}

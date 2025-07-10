package com.mlb.product.dto;

import java.time.*;

import com.mlb.product.dao.TeamDao;

public class ProductDto {
	private Long pr_id;
	private String tm_id;
	private String ca_id;
	private String pr_name;
	private LocalDateTime pr_regdate;
	private String pr_thum_img;
	private String pr_detail_img;

	public ProductDto() {
	}

	public ProductDto(Long pr_id, String tm_id, String ca_id, String pr_name, LocalDateTime pr_regdate,
			String pr_thum_img, String pr_detail_img) {
		this.pr_id = pr_id;
		this.tm_id = tm_id;
		this.ca_id = ca_id;
		this.pr_name = pr_name;
		this.pr_regdate = pr_regdate;
		this.pr_thum_img = pr_thum_img;
		this.pr_detail_img = pr_detail_img;
	}

	public Long getPr_id() {
		return pr_id;
	}

	public void setPr_id(Long pr_id) {
		this.pr_id = pr_id;
	}

	public String getTm_id() {
		return tm_id;
	}

	public void setTm_id(String tm_id) {
		this.tm_id = tm_id;
	}

	public String getCa_id() {
		return ca_id;
	}

	public void setCa_id(String ca_id) {
		this.ca_id = ca_id;
	}

	public String getPr_name() {
		return pr_name;
	}

	public void setPr_name(String pr_name) {
		this.pr_name = pr_name;
	}

	public LocalDateTime getPr_regdate() {
		return pr_regdate;
	}

	public void setPr_regdate(LocalDateTime pr_regdate) {
		this.pr_regdate = pr_regdate;
	}

	public String getPr_thum_img() {
		return pr_thum_img;
	}

	public void setPr_thum_img(String pr_thum_img) {
		this.pr_thum_img = pr_thum_img;
	}

	public String getPr_detail_img() {
		return pr_detail_img;
	}

	public void setPr_detail_img(String pr_detail_img) {
		this.pr_detail_img = pr_detail_img;
	}

	public String getTm_name() {
		return new TeamDao().selectByTeamId(this.tm_id).getTm_name();
	}

	@Override
	public String toString() {
		return "ProductDto [pr_id=" + pr_id + ", tm_id=" + tm_id + ", ca_id=" + ca_id + ", pr_name=" + pr_name
				+ ", pr_regdate=" + pr_regdate + ", pr_thum_img=" + pr_thum_img + ", pr_detail_img=" + pr_detail_img
				+ "]";
	}

	@Override
	public boolean equals(Object obj) {
		if (obj instanceof ProductDto) {
			ProductDto dto = (ProductDto) obj;
			if (dto.getPr_id().equals(this.pr_id)) {
				return true;
			}
		}
		return false;
	}
}

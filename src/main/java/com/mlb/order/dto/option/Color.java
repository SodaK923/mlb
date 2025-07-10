package com.mlb.order.dto.option;

public enum Color {
	BLACK("BLK","Black","#000000"),
	WHITE("WT","White","#FFFFFF"),
	BLUE("BLE","Blue","#0000FF"),
	RED("RED","Red","#FF0000"),
	GREEN("GN","Green","#008000"),
	PINK("PK","Pink","#FFC0CB"),
	BEIGE("BG","Beige","#F5F5DC"),
	BROWN("BR","Brown","#8B4513"),
	GRAY("GR","Gray","#808080");
	
	private String id;
	private String name;
	private String hexcode;
	
	private Color(String id, String name, String hexcode) {
		this.id = id;
		this.name = name;
		this.hexcode = hexcode;
	}

	public String getId() {
		return id;
	}

	public String getName() {
		return name;
	}

	public String getHexcode() {
		return hexcode;
	}
	
	
	
}

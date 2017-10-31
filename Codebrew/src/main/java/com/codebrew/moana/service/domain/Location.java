package com.codebrew.moana.service.domain;

public class Location {
	
	private String code;
	private String name;
	private String rnum;
	public Location() {
		super();
	}
	public Location(String code, String name, String rnum) {
		super();
		this.code = code;
		this.name = name;
		this.rnum = rnum;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getRnum() {
		return rnum;
	}
	public void setRnum(String rnum) {
		this.rnum = rnum;
	}
	@Override
	public String toString() {
		return "Location [code=" + code + ", name=" + name + ", rnum=" + rnum + "]";
	}
	
	

}

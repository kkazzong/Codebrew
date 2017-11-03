package com.codebrew.moana.service.domain;

public class Contents {
	
	private String url;

	public Contents() {
		super();
	}

	public Contents(String url) {
		super();
		this.url = url;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	@Override
	public String toString() {
		return "Contents [url=" + url + "]";
	} 
	
	

}

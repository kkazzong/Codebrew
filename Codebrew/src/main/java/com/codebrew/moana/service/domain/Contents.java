package com.codebrew.moana.service.domain;

public class Contents {
	
	private String url;
	
	private String url0;
	private String url1;
	private String url2;

	public Contents() {
		super();
	}
	
	


	public Contents(String url0, String url1, String url2) {
		super();
		this.url0 = url0;
		this.url1 = url1;
		this.url2 = url2;
	}




	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}


	public String getUrl0() {
		return url0;
	}


	public void setUrl0(String url0) {
		this.url0 = url0;
	}


	public String getUrl1() {
		return url1;
	}


	public void setUrl1(String url1) {
		this.url1 = url1;
	}


	public String getUrl2() {
		return url2;
	}


	public void setUrl2(String url2) {
		this.url2 = url2;
	}


	@Override
	public String toString() {
		return "Contents [url=" + url + ", url0=" + url0 + ", url1=" + url1 + ", url2=" + url2 + "]";
	}
	
	

	
	

}

package com.codebrew.moana.service.domain;

public class Follow extends User {
	
	
	private int followNo;
	private String requestId;
	private String responseId;
	private String f4f;
	
	
	
	public Follow() {
		
	}


	public int getFollowNo() {
		return followNo;
	}


	public void setFollowNo(int followNo) {
		this.followNo = followNo;
	}


	public String getRequestId() {
		return requestId;
	}


	public void setRequestId(String requestId) {
		this.requestId = requestId;
	}


	public String getResponseId() {
		return responseId;
	}


	public void setResponseId(String responseId) {
		this.responseId = responseId;
	}


	public String getF4f() {
		return f4f;
	}


	public void setF4f(String f4f) {
		this.f4f = f4f;
	}


	@Override
	public String toString() {
		return "Follow [followNo=" + followNo + ", requestId=" + requestId + ", responseId=" + responseId + ", f4f="
				+ f4f + "]";
	}


	
	

}

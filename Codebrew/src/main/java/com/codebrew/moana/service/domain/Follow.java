package com.codebrew.moana.service.domain;

public class Follow {
	
	
	private int followNo;
	private String requestId;
	private String responseId;
	
	
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


	@Override
	public String toString() {
		return "Follow [followNo=" + followNo + ", requestId=" + requestId + ", responseId=" + responseId + "]";
	}
	

}

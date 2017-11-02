package com.codebrew.moana.service.domain;


public class Chat {

	///Field///
	private User sender;
	private User recipient;

	
	///Constructor///
	public Chat() {
		super();
		// TODO Auto-generated constructor stub
	}


	///Method///
	public User getSender() {
		return sender;
	}


	public void setSender(User sender) {
		this.sender = sender;
	}


	public User getRecipient() {
		return recipient;
	}


	public void setRecipient(User recipient) {
		this.recipient = recipient;
	}


	@Override
	public String toString() {
		return "\nChat [@@@ sender = " + sender + ",\n@@@ recipient = " + recipient + "]\n";
	}

	
	
}
	
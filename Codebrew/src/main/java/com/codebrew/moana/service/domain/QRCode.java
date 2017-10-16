package com.codebrew.moana.service.domain;

public class QRCode {

	// Field
	private String qrCodeImage;
	private String qrCodeResult;

	// Constructor
	public QRCode() {
		System.out.println("QRCode default Constructor");
	}

	//getter, setter
	public String getQrCodeImage() {
		return qrCodeImage;
	}

	public void setQrCodeImage(String qrCodeImage) {
		this.qrCodeImage = qrCodeImage;
	}

	public String getQrCodeResult() {
		return qrCodeResult;
	}

	public void setQrCodeResult(String qrCodeResult) {
		this.qrCodeResult = qrCodeResult;
	}

	@Override
	public String toString() {
		return "QRCode [qrCodeImage=" + qrCodeImage + ", qrCodeResult=" + qrCodeResult + "]";
	}

}

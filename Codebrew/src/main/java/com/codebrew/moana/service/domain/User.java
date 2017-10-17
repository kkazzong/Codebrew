package com.codebrew.moana.service.domain;

import java.sql.Date;

public class User {
	

	private String userId;
	private String userName;
	private String password;
	private String profileImage;
	private String role;
	private String phone;
	private String gender;
	private Date birth;
	private int age;
	private String locationFlag;
	private String nickname;
	private Date regDate;
	private int coconutCount;
	
	
	public User() {
		
	}
	
	



	public String getUserId() {
		return userId;
	}





	public void setUserId(String userId) {
		this.userId = userId;
	}





	public String getUserName() {
		return userName;
	}





	public void setUserName(String userName) {
		this.userName = userName;
	}





	public String getPassword() {
		return password;
	}





	public void setPassword(String password) {
		this.password = password;
	}





	public String getProfileImage() {
		return profileImage;
	}





	public void setProfileImage(String profileImage) {
		this.profileImage = profileImage;
	}





	public String getRole() {
		return role;
	}





	public void setRole(String role) {
		this.role = role;
	}





	public String getPhone() {
		return phone;
	}





	public void setPhone(String phone) {
		this.phone = phone;
	}





	public String getGender() {
		return gender;
	}





	public void setGender(String gender) {
		this.gender = gender;
	}





	public Date getBirth() {
		return birth;
	}





	public void setBirth(Date birth) {
		this.birth = birth;
	}





	public int getAge() {
		return age;
	}





	public void setAge(int age) {
		this.age = age;
	}





	public String getLocationFlag() {
		return locationFlag;
	}





	public void setLocationFlag(String locationFlag) {
		this.locationFlag = locationFlag;
	}





	public String getNickname() {
		return nickname;
	}





	public void setNickname(String nickname) {
		this.nickname = nickname;
	}





	public Date getRegDate() {
		return regDate;
	}





	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}





	public int getCoconutCount() {
		return coconutCount;
	}





	public void setCoconutCount(int coconutCount) {
		this.coconutCount = coconutCount;
	}





	@Override
	public String toString() {
		return "User [userId=" + userId + ", userName=" + userName + ", password=" + password
				+ ", profileImage=" + profileImage + ", role=" + role + ", phone=" + phone + ", gender=" + gender
				+ ", birth=" + birth + ", locationFlag=" + locationFlag + ", nickname=" + nickname + ", regDate="
				+ regDate + ", coconutCount=" + coconutCount + "]";
	}



}

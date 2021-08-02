package com.go.main.admin;

public class AdminDTO {
	private String memberkey;
	private String name;
	private String blackStatus;
	private String ownerNo;
	private String deleteCheck;
	private String email;
	private String emailCheck;
	private String blackReporter;
	private String address;
	private String gender;
	private String congestionCheck;
	private String blackReport;
	private String authority;
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	private String location;
	
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getAuthority() {
		return authority;
	}
	public void setAuthority(String authority) {
		this.authority = authority;
	}
	public String getEmailCheck() {
		return emailCheck;
	}
	public void setEmailCheck(String emailCheck) {
		this.emailCheck = emailCheck;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getCongestionCheck() {
		return congestionCheck;
	}
	public void setCongestionCheck(String congestionCheck) {
		this.congestionCheck = congestionCheck;
	}
	public String getBlackReport() {
		return blackReport;
	}
	public void setBlackReport(String blackReport) {
		this.blackReport = blackReport;
	}
	public String getMemberkey() {
		return memberkey;
	}
	public void setMemberkey(String memberkey) {
		this.memberkey = memberkey;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getBlackStatus() {
		return blackStatus;
	}
	public void setBlackStatus(String blackStatus) {
		this.blackStatus = blackStatus;
	}
	public String getOwnerNo() {
		return ownerNo;
	}
	public void setOwnerNo(String ownerNo) {
		this.ownerNo = ownerNo;
	}
	public String getDeleteCheck() {
		return deleteCheck;
	}
	public void setDeleteCheck(String deleteCheck) {
		this.deleteCheck = deleteCheck;
	}
	public void setBlackReporter(String blackreporter) {
		this.blackReporter = blackreporter;
		
	}
	public String getBlackReporter() {
		return blackReporter;
	}
}

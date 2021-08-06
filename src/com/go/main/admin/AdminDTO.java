package com.go.main.admin;

import java.sql.Date;

public class AdminDTO {
	private String memberkey;
	private String name;
	private String blackStatus;
	private String ownerNo;
	private String deleteCheck;
	private String email;
	
	private String emailCheck;
	private String blackReporter;
	private String location;
	private String address;
	private String gender;
	private String congestionCheck;
	private String blackReport;
	private String authority;
	private String cafeName;
	private String cafeDel;
	private String cafeLocation;
	private int cafeTotalTable;
	private String blindReason;
	private String cafeKey;
	private String productName;
	private Date reg_date;
	private String productDel;
	private String productId;
	private int productPrice;
	private String explanation;
	private String pBlindReason;
	
	
	public String getpBlindReason() {
		return pBlindReason;
	}
	public void setpBlindReason(String pBlindReason) {
		pBlindReason = pBlindReason;
	}

	public String getExplanation() {
		return explanation;
	}
	public void setExplanation(String explanation) {
		this.explanation = explanation;
	}
	public int getProductPrice() {
		return productPrice;
	}
	public void setProductPrice(int productPrice) {
		this.productPrice = productPrice;
	}
	public String getProductId() {
		return productId;
	}
	public void setProductId(String productId) {
		this.productId = productId;
	}
	public String getProductDel() {
		return productDel;
	}
	public void setProductDel(String productDel) {
		this.productDel = productDel;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public Date getReg_date() {
		return reg_date;
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}
	
	public String getCafeKey() {
		return cafeKey;
	}
	public void setCafeKey(String cafeKey) {
		this.cafeKey = cafeKey;
	}
	
	public String getBlindReason() {
		return blindReason;
	}
	public void setBlindReason(String blindReason) {
		this.blindReason = blindReason;
	}
	public String getCafeLocation() {
		return cafeLocation;
	}
	public void setCafeLocation(String cafeLocation) {
		this.cafeLocation = cafeLocation;
	}
	public int getCafeTotalTable() {
		return cafeTotalTable;
	}
	public void setCafeTotalTable(int cafeTotalTable) {
		this.cafeTotalTable = cafeTotalTable;
	}
	
	public String getCafeDel() {
		return cafeDel;
	}
	public void setCafeDel(String cafeDel) {
		this.cafeDel = cafeDel;
	}
	public String getCafeName() {
		return cafeName;
	}
	public void setCafeName(String cafeName) {
		this.cafeName = cafeName;
	}

	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	
	
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

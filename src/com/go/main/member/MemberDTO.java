package com.go.main.member;

public class MemberDTO {
	
	private String memberKey;  //1
	private String pw;  //2
	private String name;  //3
	private String gender;  //4
	private String email; //5 
	private String emailCheck; //6
	private String congestionCheck; //7
	private String deleteCheck;  //8
	private String authority; //9
	private String location; //10 
	private String address;
	private String division;   
	private String reportReason;
	private String processStatus;
	private String managers;
	private String Productname;
	private String Cmreporter;
	
	public String getDivision() {
		return division;
	}
	public void setDivision(String division) {
		this.division = division;
	}
	public String getCafeName() {
		return cafeName;
	}
	public void setCafeName(String cafeName) {
		this.cafeName = cafeName;
	}
	public String getCm_content() {
		return cm_content;
	}
	public void setCm_content(String cm_content) {
		this.cm_content = cm_content;
	}
	private String cafeName;
	private String cm_content;
	public String getMemberKey() {
		return memberKey;
	}
	public void setMemberKey(String memberKey) {
		this.memberKey = memberKey;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getEmailCheck() {
		return emailCheck;
	}
	public void setEmailCheck(String emailCheck) {
		this.emailCheck = emailCheck;
	}
	public String getCongestionCheck() {
		return congestionCheck;
	}
	public void setCongestionCheck(String congestionCheck) {
		this.congestionCheck = congestionCheck;
	}
	public String getDeleteCheck() {
		return deleteCheck;
	}
	public void setDeleteCheck(String deleteCheck) {
		this.deleteCheck = deleteCheck;
	}
	public String getAuthority() {
		return authority;
	}
	public void setAuthority(String authority) {
		this.authority = authority;
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
	public String getReportReason() {
		return reportReason;
	}
	public void setReportReason(String reportReason) {
		this.reportReason = reportReason;
	}
	public String getProcessStatus() {
		return processStatus;
	}
	public void setProcessStatus(String processStatus) {
		this.processStatus = processStatus;
	}
	public String getManagers() {
		return managers;
	}
	public void setManagers(String managers) {
		this.managers = managers;
	}
	public String getSetProductname() {
		return Productname;
	}
	public void setSetProductname(String setProductname) {
		this.Productname = setProductname;
	}
	public String getCmreporter() {
		return Cmreporter;
	}
	public void setCmreporter(String cmreporter) {
		Cmreporter = cmreporter;
	}
	

	
	
	
}

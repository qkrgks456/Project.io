package com.go.main.cafe;

import java.util.ArrayList;
import java.util.HashMap;

public class CafeDTO {
	private String cafeName;
	private String cafeLocation;
	private String cafeAddress;
	private String cafePhone;
	private String cafeDetail;
	private String cafeTime;
	private String parkingCheck;
	private String petCheck;
	private String childCheck;
	private String rooftopCheck;
	private String groupCheck;
	private String onnerNo;
	private ArrayList<HashMap<String, Object>> maparr;
	private HashMap<String, Object> businessfilenames;
	
	public String getCafeName() {
		return cafeName;
	}
	public void setCafeName(String cafeName) {
		this.cafeName = cafeName;
	}
	public String getCafeLocation() {
		return cafeLocation;
	}
	public void setCafeLocation(String cafeLocation) {
		this.cafeLocation = cafeLocation;
	}
	public String getCafeAddress() {
		return cafeAddress;
	}
	public void setCafeAddress(String cafeAddress) {
		this.cafeAddress = cafeAddress;
	}
	public String getCafePhone() {
		return cafePhone;
	}
	public void setCafePhone(String cafePhone) {
		this.cafePhone = cafePhone;
	}
	public String getCafeDetail() {
		return cafeDetail;
	}
	public void setCafeDetail(String cafeDetail) {
		this.cafeDetail = cafeDetail;
	}
	public String getCafeTime() {
		return cafeTime;
	}
	public void setCafeTime(String cafeTime) {
		this.cafeTime = cafeTime;
	}
	public String getParkingCheck() {
		return parkingCheck;
	}
	public void setParkingCheck(String parkingCheck) {
		this.parkingCheck = parkingCheck;
	}
	public String getPetCheck() {
		return petCheck;
	}
	public void setPetCheck(String petCheck) {
		this.petCheck = petCheck;
	}
	public String getChildCheck() {
		return childCheck;
	}
	public void setChildCheck(String childCheck) {
		this.childCheck = childCheck;
	}
	public String getRooftopCheck() {
		return rooftopCheck;
	}
	public void setRooftopCheck(String rooftopCheck) {
		this.rooftopCheck = rooftopCheck;
	}
	public String getGroupCheck() {
		return groupCheck;
	}
	public void setGroupCheck(String groupCheck) {
		this.groupCheck = groupCheck;
	}
	public String getOnnerNo() {
		return onnerNo;
	}
	public void setOnnerNo(String onnerNo) {
		this.onnerNo = onnerNo;
	}
	public ArrayList<HashMap<String, Object>> getMaparr() {
		return maparr;
	}
	public void setMaparr(ArrayList<HashMap<String, Object>> maparr) {
		this.maparr = maparr;
	}
	public HashMap<String, Object> getBusinessfilenames() {
		return businessfilenames;
	}
	public void setBusinessfilenames(HashMap<String, Object> businessfilenames) {
		this.businessfilenames = businessfilenames;
	}
	
}

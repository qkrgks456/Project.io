package com.go.sub.comment;

import java.util.ArrayList;

public class CommentDTO {
	private String commentNo;
	private String memberKey;
	private String cm_content;
	private ArrayList<CommentDTO> list;
	private String reportReason;
	private String managers;
	private String processStatus;
	private String cafeName;
	private String productName;
	private String cmreportdispose;
	public String getReportReason() {
		return reportReason;
	}
	public void setReportReason(String reportReason) {
		this.reportReason = reportReason;
	}
	public String getManagers() {
		return managers;
	}
	public void setManagers(String managers) {
		this.managers = managers;
	}
	public String getProcessStatus() {
		return processStatus;
	}
	public void setProcessStatus(String processStatus) {
		this.processStatus = processStatus;
	}
	public String getCafeName() {
		return cafeName;
	}
	public void setCafeName(String cafeName) {
		this.cafeName = cafeName;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public String getMemberKey() {
		return memberKey;
	}
	public void setMemberKey(String memberKey) {
		this.memberKey = memberKey;
	}
	public String getCm_content() {
		return cm_content;
	}
	public void setCm_content(String cm_content) {
		this.cm_content = cm_content;
	}
	public ArrayList<CommentDTO> getList() {
		return list;
	}
	public void setList(ArrayList<CommentDTO> list) {
		this.list = list;
	}
	public String getCommentNo() {
		return commentNo;
	}
	public void setCommentNo(String commentNo) {
		this.commentNo = commentNo;
	}
	public String getCmreportdispose() {
		return cmreportdispose;
	}
	public void setCmreportdispose(String cmreportdispose) {
		this.cmreportdispose = cmreportdispose;
	}
}

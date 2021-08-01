package com.go.sub.comment;

import java.util.ArrayList;

public class CommentDTO {
	private String commentNo;
	private String memberKey;
	private String cm_content;
	private ArrayList<CommentDTO> list;
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
}

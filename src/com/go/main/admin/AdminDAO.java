package com.go.main.admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;





public class AdminDAO {
	
	Connection conn=null;
	ResultSet rs=null;
	PreparedStatement ps=null;
	
	AdminDTO dto = null;
	ArrayList<AdminDTO> list=null;
	String sql="";
	int success =0;
	
	public AdminDAO() {
		
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Oracle");
			conn = ds.getConnection();
			System.out.println("admin DB연결체크 : " + conn);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	public ArrayList<AdminDTO> adminMemberinfoSearch(String adminMember, String adminSearchSelect) {
		
		System.out.println("dao까지 연결확인: "+adminSearchSelect+"/"+adminMember);
		sql = "SELECT u.memberKey , u.name , bb.statuscheck, ou.ownerno, u.deletecheck FROM users u LEFT OUTER JOIN blackList bb ON u.memberKey = bb.memberKey LEFT OUTER JOIN ownerUser ou ON u.memberKey=ou.memberKey WHERE u.memberkey LIKE ?"; 
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, "%"+adminMember+"%");
			rs = ps.executeQuery();
	
			/* 값이 있다면 */
			if(rs.next()) {
				success=1;
				
				dto = new AdminDTO();
				list = new ArrayList<AdminDTO>();
				dto.setMemberkey(rs.getString("memberKey"));
				dto.setName(rs.getString("name"));
				dto.setBlackStatus(rs.getString("statuscheck"));
				dto.setOwnerNo(rs.getString("ownerNo"));
				dto.setDeleteCheck(rs.getString("deleteCheck"));
				
				System.out.println("dto에 값 저장: "+ dto.getMemberkey()+"/"+dto.getName()+"/"+dto.getBlackStatus()+"/"+dto.getOwnerNo()+"/"+dto.getDeleteCheck());
				list.add(dto);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	
	public void resClose() {
		try {
			if (rs != null && !rs.isClosed()) {
				rs.close();
			}
			if (ps != null && !ps.isClosed()) {
				ps.close();
			}
			if (conn != null && !conn.isClosed()) {
				conn.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public AdminDTO adminMemberDetail(String memberkey) {
		System.out.println("어드민 dao까지 연결확인: "+memberkey);
		sql = "SELECT u.memberKey, u.name, u.email, u.location, u.gender, u.emailcheck" + 
				" , u.CONGESTIONCHECK, b.statuscheck, b.blackreport,b.blackreporter FROM users u" + 
				" LEFT OUTER JOIN blackList b on u.memberKey = b.memberKey where u.memberKey = ?";
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1,memberkey);
			rs = ps.executeQuery();
			if(rs.next()) {
				dto = new AdminDTO();
				dto.setMemberkey(rs.getString("memberKey"));
				dto.setName(rs.getString("name"));
				dto.setEmail(rs.getString("email"));
				dto.setLocation(rs.getString("location"));
				dto.setGender(rs.getString("gender"));
				dto.setEmailCheck(rs.getString("emailcheck"));
				dto.setCongestionCheck(rs.getString("CONGESTIONCHECK"));
				dto.setBlackStatus(rs.getString("statuscheck"));
				dto.setBlackReport(rs.getString("blackreport"));
				dto.setBlackReporter(rs.getString("blackreporter"));
				
				System.out.println("DTO에 어드민 디테일값 저장: "+dto.getMemberkey()+"/"+dto.getName()+"/"+dto.getEmail()+"/"+dto.getLocation()+"/"+dto.getGender()+"/"+dto.getEmailCheck()+"/"+dto.getCongestionCheck()+"/"+dto.getBlackStatus()+"/"+dto.getBlackReport()+"/"+dto.getBlackReporter());
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return dto;
	}
	public AdminDTO adminMemberBlackAddPage(String memberkey, String name) {
		System.out.println("블랙리스트 추가페이지 dao까지 연결확인: "+memberkey+"/"+name);
		sql = "SELECT u.memberkey, u.name FROM users u";
		
		dto = new AdminDTO();
		dto.setMemberkey(memberkey);
		dto.setName(name);
		return dto;
	}
	public int adminMemberBlackMinus(String memberkey) {
		System.out.println("블랙리스트 해제 dao까지 연결확인: "+memberkey);
		sql= "DELETE FROM blackList where memberKey = ?";
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1, memberkey);
			success = ps.executeUpdate();
			System.out.println("삭제 성공 여부: " +success);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return success;
		
		
	}
	public int adminMemberBlackAdd(String memberkey, String blackRePort) {
		System.out.println("블랙리스트 추가페이지 dao까지 연결확인: " +memberkey+"/"+blackRePort);
		sql="INSERT INTO blackList(blacklistno,memberkey,blackreport,blackreporter,statusCheck) VALUES(blacklistNo_seq.nextval,?,?,'admin2','Y')";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, memberkey);
			ps.setString(2, blackRePort);
			success = ps.executeUpdate();
			System.out.println("블랙리스트 추가성공 여부: " + success);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return success;
	}

}

package com.go.main.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.go.main.member.MemberDTO;

public class MemberDAO {

	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	boolean result = false;
	String sql = null;
	MemberDTO dto = null;
	
	
	public MemberDAO() {
		try {
			// 1. Context 가져오기
			Context ctx = new InitialContext();
			// 2. name으로 Resource 가져와 DataSource 변환
			DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/Oracle");
		 	// 3. Connection 가져오기
			conn = ds.getConnection();
			System.out.println("member커넥션 : "+conn);
		} catch (Exception e) {
			e.printStackTrace();
			
			
		}	
		
		
	}
	
	

	public boolean login(MemberDTO dto) {
		sql = "SELECT memberkey FROM users WHERE memberkey=? AND pw=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1,dto.getMemberKey());
			ps.setString(2,dto.getPw());
			rs = ps.executeQuery();			
			if(rs.next()) {
				result = true;
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			resClose();
		}
		return result;	
		}

		//return null;
	
	public int signup(MemberDTO dto) {
		int suc=0;
		
				
		sql = "INSERT INTO users (memberKey,pw,name,gender,email"
		+",emailCheck,congestionCheck,deleteCheck,authority,location) "
		+ "VALUES(?,?,?,?,?,?,?,'N','일반',?)"; //DTO 10개 
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1,dto.getMemberKey());
			ps.setString(2,dto.getPw());
			ps.setString(3,dto.getName());
			ps.setString(4,dto.getGender());
			ps.setString(5,dto.getEmail());
			ps.setString(6,dto.getEmailCheck());
			ps.setString(7,dto.getCongestionCheck());
			//ps.setString(8,dto.getDeleteCheck());
			//ps.setString(9,dto.getAuthority());
			ps.setString(8, dto.getLocation());
				
			suc = ps.executeUpdate();
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			resClose();
		}
		
		return suc;
	}
	
	public boolean signupcheck(String memberkey) {
		sql = "SELECT memberkey FROM users WHERE memberkey=? ";
		boolean suc4=false;
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, memberkey);
			rs=ps.executeQuery();
			suc4=rs.next();
				
		}catch(Exception e){
			e.printStackTrace();
		}finally {
		   resClose();
		}
		return suc4;
	}
		
	
	public void resClose() {
		try {
			if(rs!=null&&!rs.isClosed()) {rs.close();}			
			if(ps!=null&&!ps.isClosed()) {ps.close();}
			if(conn!=null&&!conn.isClosed()) {conn.close();}						
		} catch (Exception e) {
			e.printStackTrace();
		}	
	}
}

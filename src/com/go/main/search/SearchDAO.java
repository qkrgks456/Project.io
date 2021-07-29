package com.go.main.search;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class SearchDAO {
	
	public Connection conn = null;
	public ResultSet rs = null;
	public PreparedStatement ps = null;
	
	public SearchDAO() {
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Oracle");
			conn = ds.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}		
	}

	public void resClose() {
		try {
			if(rs != null && !rs.isClosed()) {rs.close();}
			if(ps != null && !ps.isClosed()) {ps.close();}
			if(conn != null && !conn.isClosed()) {conn.close();}
		} catch (Exception e) {
			e.printStackTrace();
		}		
	}
	public ArrayList<SearchDTO> namelist(String sresult) {
		String sql= "SELECT c.cafeName FROM cafeinfo c LEFT OUTER JOIN product p ON c.cafekey=p.cafekey WHERE c.cafename=?";
		ArrayList<SearchDTO> namelist = null;
		SearchDTO dto = null;
		System.out.println("DAO에서 검색값 확인 : " + sresult);
		try {			
			ps = conn.prepareStatement(sql);
			ps.setString(1,sresult);
			rs = ps.executeQuery();			
			namelist = new ArrayList<SearchDTO>();
			while(rs.next()) {
			dto = new SearchDTO();
			dto.setCafeName(rs.getString("cafeName"));				
			namelist.add(dto);
			}			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			resClose();
		}
		return namelist;
		
	}
	
}

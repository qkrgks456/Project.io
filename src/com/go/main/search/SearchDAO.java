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
	public ArrayList<SearchDTO> namelist() {
		String sql= "SELECT b.idx, b.subject, b.content, b.user_name, b.reg_date, b.bhit,p.orifilename,p.newfilename FROM bbs b LEFT OUTER JOIN photo p ON b.idx=p.idx WHERE b.idx=?";
		ArrayList<SearchDTO> namelist = null;
		SearchDTO dto = null;
		
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			namelist = new ArrayList<SearchDTO>();
			while(rs.next()) {
			dto = new SearchDTO();
			
				
				
			}			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			resClose();
		}
		return namelist;
	}
	
}

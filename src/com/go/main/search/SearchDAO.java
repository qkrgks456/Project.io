package com.go.main.search;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import com.google.gson.Gson;

public class SearchDAO {
	
	HttpServletRequest req = null;
	HttpServletResponse resp = null;
	
	public Connection conn = null;
	public ResultSet rs = null;
	public PreparedStatement ps = null;
	
	public SearchDAO(HttpServletRequest req, HttpServletResponse resp) {
		this.req = req;
		this.resp = resp;
		
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
	public ArrayList<SearchDTO> namelist(String Sresult) throws IOException {
		String sql= "SELECT newFileName,cafename,cafeLocation,confusion,cafekey	FROM (SELECT i.newfilename,c.cafeName,c.cafeNum,c.cafeKey,c.cafeLocation,c.cafeDetail,c.confusion,c.bHit FROM (SELECT division,newFileName FROM image WHERE ROWID IN (SELECT MIN(ROWID) FROM image GROUP BY division)) i LEFT OUTER JOIN cafeInfo c ON i.division= c.cafeKey WHERE c.cafeDel='N' AND c.openCheck='Y') WHERE cafename LIKE ?";
		//나중에 디비전값 = 사업자 등록번호 맞춰줘야 함
		ArrayList<SearchDTO> namelist = null;
		SearchDTO dto = null;
		try {			
			namelist = new ArrayList<SearchDTO>();
			ps = conn.prepareStatement(sql);
			ps.setString(1,"%"+Sresult+'%');
			rs = ps.executeQuery();	
			while(rs.next()) {
			dto = new SearchDTO();
			dto.setNewFileName(rs.getString("newFileName"));
			dto.setCafeName(rs.getString("cafeName"));		
			dto.setCafeLocation(rs.getString("cafeLocation"));
			dto.setConfusion(rs.getString("confusion"));	
			dto.setCafeKey(rs.getString("cafeKey"));
			namelist.add(dto);
			}
		
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			resClose();
		}
		return namelist;
	
		
	}
	/*
	public ArrayList<SearchDTO> namelistpic(String sresult) {
		ArrayList<SearchDTO> namelistpic = null;
		SearchDTO dto = null;		
		String sql=
				"SELECT fileidx, division, newFilename, cafename "
				+"FROM (SELECT fileidx ,division ,newFilename ,cafename "
				+"FROM cafeinfo c LEFT OUTER JOIN product p ON c.cafekey=p.cafekey left outer join image i on c.cafekey = i.division ORDER BY ROWNUM)"    
				+"WHERE cafename like ? AND ROWNUM = 1";				
		namelistpic = new ArrayList<SearchDTO>();
		dto = new SearchDTO();
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1,"%"+sresult+'%');
			rs = ps.executeQuery();	
			if(rs.next()) {
				dto.setFileIdx(rs.getInt("fileidx"));
				dto.setDivision(rs.getString("division"));
				dto.setNewFileName(rs.getString("newFileName"));
				dto.setCafeName(rs.getString("cafename"));					
				namelistpic.add(dto);
			} 			
	
			}
			catch (SQLException e) {
			e.printStackTrace();
		}finally {
			resClose();
		}			
		return namelistpic;		
	}
	*/
	
	public ArrayList<SearchDTO> productlist(String sresult) {
		String sql = "SELECT p.productname, p.price, c.cafeName, c.cafeLocation FROM cafeinfo c LEFT OUTER JOIN product p ON c.cafekey=p.cafekey WHERE p.productname LIKE ?";
		ArrayList<SearchDTO> productlist = null;
		SearchDTO dto = null;
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1,"%"+sresult+'%');
			rs = ps.executeQuery();	
			productlist = new ArrayList<SearchDTO>();
			while(rs.next()) {
				dto = new SearchDTO();
				dto.setProductName(rs.getString("productName"));
				dto.setPrice(rs.getInt("price"));
				dto.setCafeName(rs.getString("cafeName"));		
				dto.setCafeLocation(rs.getString("cafeLocation"));
				productlist.add(dto);
			}			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			resClose();	
		}
		
		return productlist;
	}

	public ArrayList<SearchDTO> Alist(){
		String sql = "SELECT newFileName,cafeName,cafeLocation,Confusion,cafeKey FROM (SELECT i.newfilename,c.cafeName,c.cafeNum,c.cafeKey,c.cafeLocation,c.cafeDetail,c.confusion,c.bHit FROM (SELECT division,newFileName FROM image WHERE ROWID IN (SELECT MIN(ROWID) FROM image GROUP BY division)) i LEFT OUTER JOIN cafeInfo c ON i.division= c.cafeKey WHERE c.cafeDel='N' AND c.openCheck='Y')";
		ArrayList<SearchDTO> Alist = null;
		SearchDTO dto = null;
		
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			Alist = new ArrayList<SearchDTO>();
			while(rs.next()) {
				dto = new SearchDTO();
				dto.setNewFileName(rs.getString("newFileName"));
				dto.setCafeName(rs.getString("cafeName"));		
				dto.setCafeLocation(rs.getString("cafeLocation"));
				dto.setConfusion(rs.getString("Confusion"));	
				dto.setCafeKey(rs.getString("cafeKey"));
				Alist.add(dto);
			}			
		
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			resClose();
		}		
		return Alist;		
		}

	public ArrayList<SearchDTO> AlistT() {
		String sql = "SELECT newFileName,productName,price,cafeName,cafeLocation FROM (SELECT i.newfilename,c.cafeName,c.cafeNum,c.cafeKey,c.cafeLocation,c.cafeDetail,c.confusion,c.bHit,p.productname,p.price FROM (SELECT division,newFileName FROM image WHERE ROWID IN (SELECT MIN(ROWID) FROM image GROUP BY division)) i LEFT OUTER JOIN cafeInfo c ON i.division= c.cafeKey LEFT OUTER JOIN product p ON c.cafeKey = p.cafekey WHERE c.cafeDel='N' AND c.openCheck='Y' AND PRICE IS NOT NULL)";
		ArrayList<SearchDTO> AlistT = null;
		SearchDTO dto = null;
		
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			AlistT = new ArrayList<SearchDTO>();
			while(rs.next()) {
				dto = new SearchDTO();
				dto.setNewFileName(rs.getString("newFileName"));
				dto.setProductName(rs.getString("productName"));		
				dto.setPrice(rs.getInt("price"));
				dto.setCafeName(rs.getString("cafeName"));	
				dto.setCafeLocation(rs.getString("cafeLocation"));
				AlistT.add(dto);
			}			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			resClose();
		}		
		return AlistT;		
		}
	}


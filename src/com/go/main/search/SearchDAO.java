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

	public ArrayList<SearchDTO> namelist(String Sresult) throws IOException {
		String sql = "SELECT newFileName,cafename,cafeLocation,confusion,cafekey	FROM (SELECT i.newfilename,c.cafeName,c.cafeNum,c.cafeKey,c.cafeLocation,c.cafeDetail,c.confusion,c.bHit FROM (SELECT division,newFileName FROM image WHERE ROWID IN (SELECT MIN(ROWID) FROM image GROUP BY division)) i LEFT OUTER JOIN cafeInfo c ON i.division= c.cafeKey WHERE c.cafeDel='N' AND c.openCheck='Y') WHERE upper(cafename) LIKE upper(?)";
		// 나중에 디비전값 = 사업자 등록번호 맞춰줘야 함
		ArrayList<SearchDTO> namelist = null;
		SearchDTO dto = null;
		try {
			namelist = new ArrayList<SearchDTO>();
			ps = conn.prepareStatement(sql);
			ps.setString(1, "%" + Sresult + '%');
			rs = ps.executeQuery();
			while (rs.next()) {
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
		}
		return namelist;
	}

	public ArrayList<SearchDTO> productlist(String sresult) {
		// String sql = "SELECT p.productname, p.price, c.cafeName, c.cafeLocation FROM
		// cafeinfo c LEFT OUTER JOIN product p ON c.cafekey=p.cafekey WHERE
		// p.productname LIKE ?";
		String sql = "SELECT p.productname, p.price, c.cafeKey, c.cafeName, c.cafeLocation,i.newfilename,p.delcheck,p.selcheck FROM cafeinfo c LEFT OUTER JOIN product p ON c.cafekey=p.cafekey LEFT OUTER JOIN image i ON p.productid=i.division WHERE p.delcheck='N' AND p.selcheck='Y' AND upper(p.productname) like upper(?)";
		ArrayList<SearchDTO> productlist = null;
		SearchDTO dto = null;

		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, "%" + sresult + '%');
			rs = ps.executeQuery();
			productlist = new ArrayList<SearchDTO>();
			while (rs.next()) {
				dto = new SearchDTO();
				dto.setProductName(rs.getString("productName"));
				dto.setPrice(rs.getInt("price"));
				dto.setCafeName(rs.getString("cafeName"));
				dto.setCafeLocation(rs.getString("cafeLocation"));
				dto.setNewFileName(rs.getString("newFileName"));
				dto.setDelcheck(rs.getString("delcheck"));
				dto.setSelcheck(rs.getString("selcheck"));
				dto.setCafeKey(rs.getString("cafeKey"));
				productlist.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return productlist;
	}

	public ArrayList<SearchDTO> Alist() {
		String sql = "SELECT newFileName,cafeName,cafeLocation,Confusion,cafeKey FROM (SELECT i.newfilename,c.cafeName,c.cafeNum,c.cafeKey,c.cafeLocation,c.cafeDetail,c.confusion,c.bHit FROM (SELECT division,newFileName FROM image WHERE ROWID IN (SELECT MIN(ROWID) FROM image GROUP BY division)) i LEFT OUTER JOIN cafeInfo c ON i.division= c.cafeKey WHERE c.cafeDel='N' AND c.openCheck='Y')";
		ArrayList<SearchDTO> Alist = null;
		SearchDTO dto = null;

		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			Alist = new ArrayList<SearchDTO>();
			while (rs.next()) {
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
		}
		return Alist;
	}

	public ArrayList<SearchDTO> AlistT() {
		// String sql = "SELECT newFileName,productName,price,cafeName,cafeLocation FROM
		// (SELECT
		// i.newfilename,c.cafeName,c.cafeNum,c.cafeKey,c.cafeLocation,c.cafeDetail,c.confusion,c.bHit,p.productname,p.price
		// FROM (SELECT division,newFileName FROM image WHERE ROWID IN (SELECT
		// MIN(ROWID) FROM image GROUP BY division)) i LEFT OUTER JOIN cafeInfo c ON
		// i.division= c.cafeKey LEFT OUTER JOIN product p ON c.cafeKey = p.cafekey
		// WHERE c.cafeDel='N' AND c.openCheck='Y' AND PRICE IS NOT NULL AND PRODUCTNAME
		// IS NOT NULL)";
		String sql = "select productname, price,c.cafename,c.cafelocation,i.newfilename,c.cafekey from product p left outer join cafeinfo c on c.cafekey=p.cafekey left outer join image i on p.productid = i.division WHERE p.delcheck='N' AND p.selcheck='Y' AND price is not null and productname is not null and cafename is not null";
		ArrayList<SearchDTO> AlistT = null;
		SearchDTO dto = null;

		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			AlistT = new ArrayList<SearchDTO>();
			while (rs.next()) {
				dto = new SearchDTO();
				dto.setNewFileName(rs.getString("newFileName"));
				dto.setProductName(rs.getString("productName"));
				dto.setPrice(rs.getInt("price"));
				dto.setCafeName(rs.getString("cafeName"));
				dto.setCafeLocation(rs.getString("cafeLocation"));
				dto.setCafeKey(rs.getString("cafeKey"));
				AlistT.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return AlistT;
	}
}

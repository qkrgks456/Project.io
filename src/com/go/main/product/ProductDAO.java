package com.go.main.product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

public class ProductDAO {

	HttpServletRequest req = null;
	HttpServletResponse resp=null;
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;

	public ProductDAO(HttpServletRequest req, HttpServletResponse resp) {// 커넥션 생성
		this.req = req;
		this.resp=resp;
		try {
			Context ctx = new InitialContext();// 1. Context 가져오기
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Oracle");// 2. name 으로 Resource 가져와 DataSource 로
																					// 변환
			conn = ds.getConnection();// 3. Connection 가져오기
			System.out.println(conn);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void resClose() {// 자원 반납
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
			System.out.println("conn close" + conn);
			System.out.println("isClose() : " + conn.isClosed());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public int productjoin(ProductDTO dto, String sessionId) {
		int suc = 0;
		String sql = "INSERT INTO product(productid,cafekey,productName,Price,explanation,productQuantity,selCheck,categoryName) VALUES(product_seq.nextval,?,?,?,?,?,?,?)";

		try {
			ps = conn.prepareStatement(sql, new String[] { "productId" });
			ps.setString(1, sessionId);
			ps.setString(2, dto.getProductName());
			ps.setInt(3, dto.getPrice());
			ps.setString(4, dto.getExplanation());
			ps.setString(5, dto.getProductQuantity());
			ps.setString(6, dto.getSelCheck());
			ps.setString(7, dto.getCategoryName());
			ps.executeUpdate();
			rs = ps.getGeneratedKeys();
			if (rs.next()) {
				sql = "INSERT INTO image(fileidx,division,oriFileName,newFileName)" + "VALUES(image_seq.NEXTVAL,?,?,?)";
				ps = conn.prepareStatement(sql);
				suc = rs.getInt(1);
				System.out.println("suc 받아짐? :" + suc);
				ps.setInt(1, suc);
				ps.setString(2, dto.getOriFileName());
				ps.setString(3, dto.getNewFileName());
				ps.executeUpdate();
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return suc;
	}

	public ArrayList<ProductDTO> productlistWD() {
		String sql = "SELECT p.productname,p.explanation,p.productid,p.categoryname,i.newfilename from product p left outer join image i on i.division=p.productid WHERE categoryname='원두'";
		ArrayList<ProductDTO> productlistWD = null;
		ProductDTO dto = null;

		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			productlistWD = new ArrayList<ProductDTO>();
			while (rs.next()) {
				dto = new ProductDTO();
				dto.setProductName(rs.getString("productName"));
				dto.setExplanation(rs.getString("explanation"));
				dto.setProductId(rs.getInt("productId"));
				dto.setNewFileName(rs.getString("newFileName"));
				dto.setCategoryName(rs.getString("categoryName"));
				productlistWD.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			resClose();
		}
		return productlistWD;
	}

	public ArrayList<ProductDTO> productlistMD() {
		String sql = "SELECT p.productname,p.explanation,p.productid,p.categoryname,i.newfilename from product p left outer join image i on i.division=p.productid WHERE categoryname='엠디'";
		ArrayList<ProductDTO> productlistMD = null;
		ProductDTO dto = null;

		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			productlistMD = new ArrayList<ProductDTO>();
			while (rs.next()) {
				dto = new ProductDTO();
				dto.setProductName(rs.getString("productName"));
				dto.setExplanation(rs.getString("explanation"));
				dto.setProductId(rs.getInt("productId"));
				dto.setNewFileName(rs.getString("newFileName"));
				dto.setCategoryName(rs.getString("categoryName"));
				productlistMD.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			resClose();
		}

		return productlistMD;
	}
	
	public ProductDTO productdetail(String wdId) {
		ProductDTO dto = null;
		String sql = "SELECT p.productname,p.explanation,p.productid,p.categoryname,i.newfilename,p.price from product p left outer join image i on i.division=p.productid WHERE p.productid=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, wdId);
			rs = ps.executeQuery();
			if (rs.next()) {
				dto = new ProductDTO();
				dto.setProductName(rs.getString("productName"));
				dto.setExplanation(rs.getString("explanation"));
				dto.setProductId(rs.getInt("productid"));
				dto.setCategoryName(rs.getString("categoryname"));
				dto.setPrice(rs.getInt("Price"));
				dto.setNewFileName(rs.getString("newFileName"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			resClose();
		}
		return dto;
	}

	public ProductDTO productdetailT(String mdId) {
		ProductDTO dto = null;
		String sql = "SELECT p.productname,p.explanation,p.productid,p.categoryname,i.newfilename,p.price from product p left outer join image i on i.division=p.productid WHERE p.productid=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, mdId);
			rs = ps.executeQuery();
			if (rs.next()) {
				dto = new ProductDTO();
				dto.setProductName(rs.getString("productName"));
				dto.setExplanation(rs.getString("explanation"));
				dto.setProductId(rs.getInt("productid"));
				dto.setCategoryName(rs.getString("categoryname"));
				dto.setPrice(rs.getInt("Price"));
				dto.setNewFileName(rs.getString("newFileName"));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			resClose();
		}
		return dto;
	}

	public ArrayList<ProductDTO> prosearch(String prosearchresult) {
		String sql = "select p.productname,p.explanation,p.productid,i.newfilename from product p left outer join image i on i.division=p.productid WHERE productname LIKE ?";
		ArrayList<ProductDTO> prosearch = null;
		ProductDTO dto = null;
		
		try {
			prosearch = new ArrayList<ProductDTO>();
			ps=conn.prepareStatement(sql);
			ps.setString(1, "%"+prosearchresult+"%");
			rs = ps.executeQuery();
			while(rs.next()) {
			dto = new ProductDTO();
			dto.setProductName(rs.getString("productName"));
			dto.setExplanation(rs.getString("explanation"));
			dto.setProductId(rs.getInt("productid"));
			dto.setNewFileName(rs.getString("newFileName"));
			prosearch.add(dto);
			}			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			resClose();
		}		
		return prosearch;
	}

	public int cartinsert(String sessionId) {
		String qty = req.getParameter("quantity");
		String pid = req.getParameter("productn");
		int suc=0;
		
		String sql="insert into cart(memberkey,productid,amount) values(?, ?, ?)";
	
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1, sessionId);
			ps.setString(2, pid);
			ps.setString(3, qty);
			suc = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return suc;
	}
	
	public ArrayList<ProductDTO> cartlist() {
		String sql = "SELECT p.productname,p.productquantity,p.price,i.newfilename from product p left outer join image i on i.division=p.productid";
		ArrayList<ProductDTO> cartlist = null;
		ProductDTO dto = null;

		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, "");
			rs = ps.executeQuery();
			cartlist = new ArrayList<ProductDTO>();
			while (rs.next()) {
				dto = new ProductDTO();
				dto.setProductName(rs.getString("productname"));
				dto.setProductQuantity(rs.getString("productquantity"));
				dto.setPrice(rs.getInt("price"));
				dto.setNewFileName(rs.getString("newfilename"));		
				cartlist.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} 

		return cartlist;
	}
	}

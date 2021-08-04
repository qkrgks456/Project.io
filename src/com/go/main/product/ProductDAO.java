package com.go.main.product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ProductDAO {

	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	public ProductDAO() {//커넥션 생성
		try {			
			Context ctx = new InitialContext();//1. Context 가져오기
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Oracle");//2. name 으로 Resource  가져와  DataSource  로 변환
			conn = ds.getConnection();//3. Connection 가져오기			
			System.out.println(conn);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void resClose() {//자원 반납
		try {
			if(rs !=null && !rs.isClosed()) {rs.close();}
			if(ps != null && !ps.isClosed()) {ps.close();}
			if(conn != null && !conn.isClosed()) {conn.close();}		
			System.out.println("conn close"+conn);
			System.out.println("isClose() : "+conn.isClosed());
		} catch (Exception e) {
			e.printStackTrace();
		}		
	}
	
	
	public int productjoin(ProductDTO dto, String sessionId) {
		int suc = 0;
		String sql = "INSERT INTO product(productid,cafekey,productName,Price,explanation,productQuantity,selCheck,categoryName) VALUES(product_seq.nextval,?,?,?,?,?,?,?)";
		
		try {
			ps=conn.prepareStatement(sql, new String[] {"productId"});
			ps.setString(1, sessionId);
			ps.setString(2, dto.getProductName());
			ps.setInt(3, dto.getPrice());
			ps.setString(4, dto.getExplanation());
			ps.setInt(5, dto.getProductQuantity());
			ps.setString(6, dto.getSelCheck());
			ps.setString(7, dto.getCategoryName());		
			ps.executeUpdate();		
			rs=ps.getGeneratedKeys();
			if(rs.next()) {
				sql="INSERT INTO image(fileidx,division,oriFileName,newFileName)"
						+ "VALUES(image_seq.NEXTVAL,?,?,?)";
				ps =conn.prepareStatement(sql);
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

}

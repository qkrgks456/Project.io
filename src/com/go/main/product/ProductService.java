package com.go.main.product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

public class ProductService {
	
	HttpServletRequest req =null;
	HttpServletResponse resp = null;
	
	public Connection conn = null;
	public ResultSet rs = null;
	public PreparedStatement ps = null;
	

	public ProductService(HttpServletRequest req, HttpServletResponse resp) {
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


	public void productinsert() {
		String productName = req.getParameter("productName");
		String categoryName = req.getParameter("categoryName");
		
		String explanation = req.getParameter("explanation");
		String sellCheck = req.getParameter("sellCheck");
		
		System.out.println("상품 등록 값 받아오는지 ? : "+productName+" / "+categoryName+" / "+explanation+" / "+sellCheck);
		
		
	}
	
	
	
	
	
	
	
	
	
}

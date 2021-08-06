package com.go.main.product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;
import javax.websocket.Session;

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


	public int productinsert(String sessionId) {	
		ProductUploadService upload = new ProductUploadService(req);
		ProductDTO dto = upload.PhotoUpload();
		ProductDAO dao = new ProductDAO(req, resp);
		
		int suc = dao.productjoin(dto,sessionId);	
		
		return suc;		
	}


	public ArrayList<ProductDTO> productlistWD() {
		ProductDAO dao = new ProductDAO(req, resp);
		ArrayList<ProductDTO> productlistWD = dao.productlistWD();
		System.out.println("원두 불러오기 :" +  productlistWD.size());		
		return productlistWD;		
	}


	public Object productlistMD() {
		ProductDAO dao = new ProductDAO(req, resp);
		ArrayList<ProductDTO> productlistMD = dao.productlistMD();
		System.out.println("MD 불러오기 :" +  productlistMD.size());		
		return productlistMD;	
	}


	public ProductDTO productdetail() {
		ProductDTO dto = new ProductDTO();
		ProductDAO dao = new ProductDAO(req, resp);
		String wdId = req.getParameter("wdId");		
		String mdId = req.getParameter("mdId");
		System.out.println("wdid값 찍히나 확인 : " + wdId);	
		System.out.println("mdid값 찍히나 확인 : " + mdId);	
		
		if(wdId != null) {
			dto=dao.productdetail(wdId);			
		}else if (mdId != null) {
			dto=dao.productdetailT(mdId);			
		}

		return dto;
	}


	public ArrayList<ProductDTO> prosearch(String prosearchresult) {
		
		ProductDAO dao = new ProductDAO(req,resp);
		ArrayList<ProductDTO> prosearch = dao.prosearch(prosearchresult);
		
		return prosearch;
		
	}


	public int cartinsert(String sessionId) {
		ProductDAO dao = new ProductDAO(req, resp);
		int suc = dao.cartinsert(sessionId);
		return suc;
	}
	
	public <CartDTO> ArrayList<CartDTO> cartlist() {
		CartDAO dao = new CartDAO(req, resp);
		ArrayList<CartDTO> cartlist = dao.cartlist();
		System.out.println("장바구니 불러오기 :" +  cartlist.size());		
		return cartlist;		
	}

	
		
		
		
	}
	
	
	
	
}

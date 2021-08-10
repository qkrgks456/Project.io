package com.go.main.product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.go.sub.good.GoodDAO;

public class ProductService {

	HttpServletRequest req = null;
	HttpServletResponse resp = null;

	public Connection conn = null;
	public ResultSet rs = null;
	public PreparedStatement ps = null;

	public ProductService(HttpServletRequest req, HttpServletResponse resp) {
		this.req = req;
		this.resp = resp;

	}

	public int productinsert(String sessionId) {
		ProductUploadService upload = new ProductUploadService(req);
		ProductDTO dto = upload.PhotoUpload();
		ProductDAO dao = new ProductDAO(req, resp);

		int suc = dao.productjoin(dto, sessionId);

		return suc;
	}

	public ArrayList<ProductDTO> productlistWD() {
		ProductDAO dao = new ProductDAO(req, resp);
		ArrayList<ProductDTO> productlistWD = dao.productlistWD();
		System.out.println("원두 불러오기 :" + productlistWD.size());
		return productlistWD;
	}

	public Object productlistMD() {
		ProductDAO dao = new ProductDAO(req, resp);
		ArrayList<ProductDTO> productlistMD = dao.productlistMD();
		System.out.println("MD 불러오기 :" + productlistMD.size());
		return productlistMD;
	}

	public HashMap<String, Object> productdetail() {
		HttpSession session = req.getSession();
		String sessionId = (String) session.getAttribute("loginId");
		HashMap<String, Object> map = null;
		HashMap<String, Object> resultMap = null;
		ProductDTO dto = new ProductDTO();
		ProductDAO dao = new ProductDAO(req, resp);
		String productId = req.getParameter("productId");
		System.out.println(productId);
		System.out.println("wdid값 찍히나 확인 : " + productId);
		String page = req.getParameter("page");
		System.out.println("page : " + page);
		if (page == null) {
			page = "1";
		}
		if (productId != null) {
			resultMap = dao.productdetail(productId, Integer.parseInt(page), sessionId);
		}
		resultMap.put("productId", productId);
		dao.resClose();

		return resultMap;
	}

	public ArrayList<ProductDTO> prosearch(String prosearchresult) {

		ProductDAO dao = new ProductDAO(req, resp);
		ArrayList<ProductDTO> prosearch = dao.prosearch(prosearchresult);

		return prosearch;

	}

	public ArrayList<ProductDTO> cartinsert(String sessionId) {
		ArrayList<ProductDTO> cartlist = null;
		ProductDAO dao = new ProductDAO(req, resp);
		int suc = dao.cartinsert(sessionId);
		if (suc > 0) {
			cartlist = dao.cartlist(sessionId);
		}
		dao.resClose();
		return cartlist;
	}

	public ArrayList<ProductDTO> cartlist(String sessionId) {
		ProductDAO dao = new ProductDAO(req, resp);
		ArrayList<ProductDTO> cartlist = dao.cartlist(sessionId);
		System.out.println("장바구니 불러오기 :" + cartlist.size());
		return cartlist;
	}

	public HashMap<String, Object> myProductList(String sessionId) {
		ProductDAO dao = new ProductDAO(req, resp);
		return dao.myProductList(sessionId);
	}

	public HashMap<String, Object> productListDel(String sessionId) {
		String[] delproductId = req.getParameterValues("delproductId[]");
		HashMap<String, Object> map = null;
		ProductDAO dao = new ProductDAO(req, resp);
		int suc = dao.productListDel(delproductId);
		if (suc > 0) {
			map = dao.myProductList(sessionId);
		}
		dao.resClose();
		return map;
	}

	public HashMap<String, Object> purchaseInsert (String sessionId) {
		ProductDAO dao = new ProductDAO(req, resp);

		String pid = req.getParameter("productn");
		String qty = req.getParameter("quantity");
		String prc = req.getParameter("prc");

		System.out.println("잘 들어왔는지 확인 :  " + pid + " / " + qty + " / " + prc);

		HashMap<String, Object> map = dao.purchaseInsert(sessionId, pid, qty, prc);
		dao.resClose();

	return map;	
	}

	

	
	public HashMap<String, Object> cartDel(String sessionId) {
		String[] delproductId = req.getParameterValues("delproductId[]");
		HashMap<String, Object> map = null;
		ProductDAO dao = new ProductDAO(req, resp);
		int suc = dao.cartDel(delproductId);
		if (suc > 0) {
			map = dao.myProductList(sessionId);
		}
		dao.resClose();
		return map;
	}

	public int cafebasket() {
		String basketCheckBtn = req.getParameter("basketCheckBtn");
		String cafeKey = req.getParameter("memberKey");
		ProductDAO dao = new ProductDAO(req,resp);
		return dao.cafebasket(basketCheckBtn,cafeKey,(String)req.getSession().getAttribute("loginId"));
		
	}

	public ArrayList<ProductDTO> purchaseList(String sessionId) {
		ProductDAO dao = new ProductDAO(req, resp);
		ArrayList<ProductDTO> purchaseList = dao.purchaseList(sessionId);
		System.out.println("구매내역 불러오기 :" + purchaseList.size());
		return purchaseList;
	}

	public int cartBuy(String sessionId) {
		ProductDAO dao = new ProductDAO(req, resp);
		String[] delproductId = req.getParameterValues("delproductId[]");
		String[] qus = req.getParameterValues("qus[]");
		String[] prices = req.getParameterValues("prices[]");
		return dao.cartBuy(sessionId,delproductId,qus,prices);
	}

	public ArrayList<ProductDTO> sellList(String sessionId) {
		ProductDAO dao = new ProductDAO(req, resp);
		
		return dao.sellList(sessionId);
	}
	
	
	
}




	


		
		
		
	

	
	
	
	
	
	
	

package com.go.main.product;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

@WebServlet({ "/productList", "/productinsert", "/productdetail", "/searchproduct", "/cartinsert", "/cartList",
		"/myProductList", "/productListDel", "/purchaseInsert", "/purchaseList", "/cartDel", "/cartBuy", "/sellList",
		"/buyListDel", "/cartListDel" })
public class ProductController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		dual(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		dual(req, resp);
	}

	private void dual(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String uri = req.getRequestURI();
		String ctx = req.getContextPath();
		String addr = uri.substring(ctx.length());
		System.out.println("addr 값 : " + addr);
		req.setCharacterEncoding("UTF-8");
		RequestDispatcher dis = null;
		ProductService service = new ProductService(req, resp);
		HttpSession session = req.getSession();
		String sessionId = (String) session.getAttribute("loginId");
		ArrayList<ProductDTO> cartlist = null;
		HashMap<String, Object> map = null;
		int suc = 0;
		switch (addr) {
		case "/productList":
			
			System.out.println("상품 리스트 불러오기 요청");
			req.setAttribute("map", service.productlistWD());
			dis = req.getRequestDispatcher("MainProduct/productList.jsp");
			dis.forward(req, resp);
		
			break;

		case "/productinsert":
			if (sessionId != null) {
			System.out.println("상품 등록");
			suc = service.productinsert(sessionId);
			System.out.println("상품등록 성공 여부 : " + suc);
			req.setAttribute("success", suc);
			dis = req.getRequestDispatcher("myProductList");
			dis.forward(req, resp);
			} else {
				resp.sendRedirect("/Project/");
			}
			break;

		case "/productdetail":
			
			System.out.println("상세보기 요청!");
			map = service.productdetail();
			req.setAttribute("map", map);
			System.out.println(map);
			dis = req.getRequestDispatcher("MainProduct/product.jsp");
			dis.forward(req, resp);
			
			break;

		case "/searchproduct":
			if (sessionId != null) {
			System.out.println("검색 요청");
			String prosearchresult = req.getParameter("prosearch");
			req.setAttribute("search", service.prosearch(prosearchresult));
			dis = req.getRequestDispatcher("MainProduct/productList.jsp");
			dis.forward(req, resp);
			} else {
				resp.sendRedirect("/Project/");
			}
			break;

		/*
		 * case "/cafebasket": System.out.println("장바구니 누를수있어요?"); if (sessionId !=
		 * null) { int cafebasket = service.cafebasket(); map = new HashMap<String,
		 * Object>(); resp.setContentType("text/html; charset=UTF-8");
		 * resp.getWriter().print(new Gson().toJson(map)); } else {
		 * resp.sendRedirect("/Project/"); }
		 */

		case "/cartinsert":
			if (sessionId != null) {
			System.out.println("카트 넣기 성공");
			cartlist = service.cartinsert(sessionId);
			req.setAttribute("cartlist", cartlist);
			dis = req.getRequestDispatcher("myShopping/buy/cart.jsp");
			dis.forward(req, resp);
			} else {
				resp.sendRedirect("/Project/");
			}
			break;

		case "/cartList":
			if (sessionId != null) {
			System.out.println("카트리스트 성공");
			cartlist = service.cartlist(sessionId);
			req.setAttribute("cartlist", cartlist);
			dis = req.getRequestDispatcher("myShopping/buy/cart.jsp");
			dis.forward(req, resp);
			} else {
				resp.sendRedirect("/Project/");
			}
			break;


		case "/myProductList":
			if (sessionId != null) {
			System.out.println("내 등록 상품정보");
			map = service.myProductList(sessionId);
			req.setAttribute("map", map);
			System.out.println(map);
			dis = req.getRequestDispatcher("myShopping/sell/productList/productList.jsp");
			dis.forward(req, resp);
			} else {
				resp.sendRedirect("/Project/");
			}
			break;

		case "/productListDel":
			if (sessionId != null) {
			System.out.println("상품정보 선택 삭제");
			map = service.productListDel(sessionId);
			resp.setContentType("text/html; charset=UTF-8");
			resp.getWriter().print(new Gson().toJson(map));
			} else {
				resp.sendRedirect("/Project/");
			}
			break;

		case "/buyListDel":
			if (sessionId != null) {
			System.out.println("구매내역 선택 삭제");
			map = service.buyListDel(sessionId);
			resp.setContentType("text/html; charset=UTF-8");
			resp.getWriter().print(new Gson().toJson(map));
			} else {
				resp.sendRedirect("/Project/");
			}
			break;

		case "/cartListDel":
			if (sessionId != null) {
			System.out.println("장바구니 선택 삭제");
			map = service.cartListDel(sessionId);
			resp.setContentType("text/html; charset=UTF-8");
			resp.getWriter().print(new Gson().toJson(map));
			} else {
				resp.sendRedirect("/Project/");
			}
			break;

		case "/purchaseInsert":
			System.out.println("구매내역에 넣기 ");
			if (sessionId != null) {
				map = service.purchaseInsert(sessionId);
				if (map != null) {
					map.put("sessionId", sessionId);
					resp.setContentType("text/html; charset=UTF-8");
					resp.getWriter().print(new Gson().toJson(map));
				}
			} else {
				resp.sendRedirect("/Project/");
			}
			break;

		case "/cartDel":
			if (sessionId != null) {
			System.out.println("상품정보 선택 삭제");
			map = service.cartDel(sessionId);
			resp.setContentType("text/html; charset=UTF-8");
			resp.getWriter().print(new Gson().toJson(map));
			} else {
				resp.sendRedirect("/Project/");
			}
			break;

		case "/purchaseList":
			if (sessionId != null) {
			System.out.println("구매내역 뿌리기");
			ArrayList<ProductDTO> purchaseList = service.purchaseList(sessionId);
			req.setAttribute("purchaseList", purchaseList);
			System.out.println(purchaseList);
			dis = req.getRequestDispatcher("myShopping/buy/buyList.jsp");
			dis.forward(req, resp);
			} else {
				resp.sendRedirect("/Project/");
			}
			break;

		case "/cartBuy":
			if (sessionId != null) {
				System.out.println("카트 선택 구매");
				suc = service.cartBuy(sessionId);
				map = new HashMap<String, Object>();
				map.put("suc", suc);
				if (suc > 0) {
					resp.setContentType("text/html; charset=UTF-8");
					resp.getWriter().print(new Gson().toJson(map));
				}
			}else {
				resp.sendRedirect("/Project/");
			}
			break;
		case "/sellList":
			if (sessionId != null) {
				System.out.println("판매 내역");
				ArrayList<ProductDTO> sellList = service.sellList(sessionId);
				req.setAttribute("sellList", sellList);
				dis = req.getRequestDispatcher("myShopping/sell/sellList.jsp");
				dis.forward(req, resp);
			} else {
				resp.sendRedirect("/Project/");
			}
			break;
		}

	}

}

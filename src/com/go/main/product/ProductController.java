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


@WebServlet({"/productList","/productinsert","/productdetail","/searchproduct","/cartinsert"})
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
		
			
		switch (addr) {
		case "/productList":
			System.out.println("상품 리스트 불러오기 요청");			
			req.setAttribute("productlistWD", service.productlistWD());
			req.setAttribute("productlistMD", service.productlistMD());
			
			dis = req.getRequestDispatcher("MainProduct/productList.jsp");
			dis.forward(req, resp);
			break;
			
		case"/productinsert":
			System.out.println("상품 등록");
			int suc = service.productinsert(sessionId);
			
			System.out.println("상품등록 성공 여부 : "+suc);
			req.setAttribute("success", suc);
			dis = req.getRequestDispatcher("myShopping/sell/productList/productList.jsp");
			dis.forward(req, resp);
			break;
			
		case"/productdetail":
			System.out.println("상세보기 요청!");
			HashMap<String, Object> map = service.productdetail();
			req.setAttribute("map", map);
			dis = req.getRequestDispatcher("MainProduct/product.jsp");
			dis.forward(req, resp);
		break;
		
		case "/searchproduct":
			System.out.println("검색 요청");
			String prosearchresult = req.getParameter("prosearch");
			req.setAttribute("search", service.prosearch(prosearchresult));
			dis = req.getRequestDispatcher("MainProduct/productList.jsp");
			dis.forward(req, resp);
			
		break;
		
		case "/cartinsert":
			System.out.println("카트 넣기 성공");
			ArrayList<ProductDTO> cartlist = service.cartinsert(sessionId);	
			req.setAttribute("cartlist",cartlist);
			dis = req.getRequestDispatcher("myShopping/buy/cart.jsp");
			dis.forward(req, resp);
			break;
		}
	
		
	}
}

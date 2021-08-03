package com.go.main.product;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet({"/productList","/productinsert"})
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
		System.out.println(uri);
		
		switch (addr) {
		case "/productList":
			System.out.println("상품 리스트 불러오기 요청");
			
			
			break;
		case"/productinsert":
			System.out.println("상품 등록");
			service.productinsert();
			break;
		}
		
	}
}

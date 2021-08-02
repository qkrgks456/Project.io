package com.go.main.search;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import javafx.scene.control.Alert;


@WebServlet({"/serachCafeName"})
public class SearchController extends HttpServlet {

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
		SearchService service = new SearchService(req);
		System.out.println(uri);
		switch (addr) {
		case "/serachCafeName":
			System.out.println("카페 네임 검색 요청");					
			String Sname = req.getParameter("searchtype");//// 옵션 키워드
			String Sresult = req.getParameter("searchresult");//// 검색 키워드
				System.out.println("name(옵션) 값 : " + Sname);
				System.out.println("result(유저검색) 값 출력 : " + Sresult);				

				if(Sname.equals("searchcafename")) {
					service.namelist(Sresult);
					//service.namelistpic(Sresult);
					req.setAttribute("list", service.namelist(Sresult));
					//req.setAttribute("nameimage", service.namelistpic(Sresult));
					dis = req.getRequestDispatcher("search.jsp");
					dis.forward(req, resp);
				}
				if(Sname.equals("searchcafeproduct")) {
					service.productlist(Sresult);
					req.setAttribute("list2", service.productlist(Sresult));
					dis = req.getRequestDispatcher("search.jsp");
					dis.forward(req, resp);				
				}			
			
			break;
		}		
	}
}


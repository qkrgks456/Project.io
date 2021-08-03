package com.go.main.search;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.ws.RequestWrapper;

import org.apache.jasper.tagplugins.jstl.core.Param;

import javafx.scene.control.Alert;


@WebServlet({"/serachCafeName","/test","/testTwo"})
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
		SearchService service = new SearchService(req, resp);
		System.out.println(uri);
		
		switch (addr) {
		case "/serachCafeName":
			System.out.println("카페 네임 검색 요청");					
			String Sname = req.getParameter("searchtype");//// 옵션 키워드
			String Sresult = req.getParameter("Sresult");//// 검색 키워드
				System.out.println("name(옵션) 값 : " + Sname);
				System.out.println("result(유저검색) 값 출력 : " + Sresult);				

				if(Sname.equals("searchcafename")) {
					service.namelist(Sresult);					
				}
				if(Sname.equals("searchcafeproduct")) {
					service.productlist(Sresult);
				}			
				break;
				
		case "/test":			
			String Snames = req.getParameter("searchtype");
			System.out.println("카테고리값 : " + Snames);
			try {
				service.Alist();
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			break;
			
		case "/testTwo":
			try {
				Snames = req.getParameter("searchtype");
				System.out.println("카테고리값 : " + Snames);
				service.AlistT();
			} catch (Exception e) {
				e.printStackTrace();
			}			
			break;
		}		
	}
}


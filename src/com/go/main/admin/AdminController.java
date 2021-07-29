package com.go.main.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet({"/adminMemberList"})
public class AdminController extends HttpServlet {
	
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
		//주소 가져오기
		String uri = req.getRequestURI();
		String ctx = req.getContextPath();
		String addr = uri.substring(ctx.length());
		System.out.println("들어온 주소: "+addr);
		
		String adminmember =req.getParameter("adminmember");
		String memberSearchSelect =req.getParameter("memberSearchSelect");
		System.out.println(memberSearchSelect);
		
		switch(addr) {
		case "/adminMemberList":
			System.out.println("어드민에서 멤버리스트 조회");
			break;
		}
		
		
	}
}
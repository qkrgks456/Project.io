package com.go.main.admin;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet({"/adminMemberList","/adminMemberListDetail","/adminMemberBlackAdd"})
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
		ArrayList<AdminDTO> list = null;
		AdminDTO dto = new AdminDTO();
		
		AdminService service = new AdminService(req);
		RequestDispatcher dis = null;
		
		int success=0;
		
		switch(addr) {
		case "/adminMemberList":
			System.out.println("어드민에서 멤버리스트 조회");
			list = service.adminMemberinfoSearch();
			req.setAttribute("list", list);
			dis = req.getRequestDispatcher("admin/adminList/adminMemberList/adminMemberList.jsp");
			dis.forward(req,resp);
			break;
			
		case "/adminMemberListDetail":
			System.out.println("어드민에서 회원상세 조회");
			dto = service.adminMemberDetail();
			req.setAttribute("adminMemberDetail", dto);
			dis = req.getRequestDispatcher("admin/adminList/adminMemberList/adminMemberDetail.jsp");
			dis.forward(req,resp);
			break;
		case "/adminMemberBlackAdd":
			System.out.println("어드민에서 멤버 블랙리스트 추가");
			dto = service.adminMemberBlackAdd();
			req.setAttribute("adminMemberBlack", dto);
			dis = req.getRequestDispatcher("admin/adminList/adminMemberList/adminMemberBlack.jsp");
			dis.forward(req,resp);
			break;
		}
		
		
	}
}
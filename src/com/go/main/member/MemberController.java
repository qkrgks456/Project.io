package com.go.main.member;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet({"/login","/logout","/signup"})
public class MemberController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private void dual(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
		// url 파악
		String uri = req.getRequestURI();
		String context = req.getContextPath();
		String subAddr = uri.substring(context.length());
		// 변수
		String id = null;
		String pw = null;
		String path = null;
		HttpSession session = req.getSession();
		switch (subAddr) {
		// 로그인 로직(테스트)
		case "/login": 
			PrintWriter out = resp.getWriter();
			id = req.getParameter("InputId");
			pw = req.getParameter("InputPassword");
			path = req.getParameter("path");
			System.out.println(id+" "+pw+" "+path);
			if(id.equals("qkrgks456")&&pw.equals("qkr123")) {
				session.setAttribute("loginId", id);
				out.print("1");
				out.flush();
				out.close();
			}else {
				out.print("2");
				out.flush();
				out.close();
			}
			break;
		// 로그아웃 로직
		case "/logout":
			session.removeAttribute("loginId");
			resp.sendRedirect("index.jsp");
			break;
		}
		
	}
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		dual(req,resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		dual(req,resp);
	}

}

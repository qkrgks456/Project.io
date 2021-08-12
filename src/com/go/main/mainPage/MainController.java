package com.go.main.mainPage;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.go.main.cafe.CafeDAO;
import com.google.gson.Gson;


@WebServlet({"/","/cartCount"})
public class MainController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private void dual(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// url 파악
		String uri = req.getRequestURI();
		String ctx = req.getContextPath();
		String addr = uri.substring(ctx.length());
		HttpSession session = req.getSession();
		String sessionId = (String) session.getAttribute("loginId");
		RequestDispatcher dis = null;		
		CafeDAO cafeDao = null;
		MainDAO dao = null;
		boolean check = false;
		HashMap<String, Object> map = null;
		switch (addr) {
		case "/":
			cafeDao = new CafeDAO();
			check =cafeDao.cafeInputCheck(sessionId);
			cafeDao.resClose();
			dao = new MainDAO();
			System.out.println("안녕");
			map = dao.mainPage(sessionId);
			map.put("check", check);
			req.setAttribute("map", map);
			dis = req.getRequestDispatcher("index.jsp");
			dis.forward(req, resp);
			break;
		case "/cartCount":
			dao = new MainDAO();
			int cartCount = dao.cartCount(sessionId);
			map = new HashMap<String, Object>();
			map.put("cartCount", cartCount);
			resp.setContentType("text/html; charset=UTF-8");
			resp.getWriter().print(new Gson().toJson(map));
			break;
		default:
		resp.sendRedirect("/Project/");
			break;
		}
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		dual(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		dual(req, resp);
	}

}

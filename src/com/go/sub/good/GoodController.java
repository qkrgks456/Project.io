package com.go.sub.good;

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

import com.go.main.cafe.CafeDTO;
import com.google.gson.Gson;

@WebServlet({ "/cafeGood", "/cafeGoodList" })
public class GoodController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private void dual(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// url 파악
		String uri = req.getRequestURI();
		String ctx = req.getContextPath();
		String addr = uri.substring(ctx.length());
		HashMap<String, Object> map = null;
		int suc = 0;
		RequestDispatcher dis = null;
		boolean check = false;
		// 세션 아이디 가져오기
		HttpSession session = req.getSession();
		String sessionId = (String) session.getAttribute("loginId");
		GoodService service = new GoodService(req);
		switch (addr) {
		case "/cafeGood":
			System.out.println("카페좋아요");
			if (sessionId != null) {
				int cafeGoodCount = service.cafeGood();
				map = new HashMap<String, Object>();
				map.put("cafeGoodCount", cafeGoodCount);
				resp.setContentType("text/html; charset=UTF-8");
				resp.getWriter().print(new Gson().toJson(map));
			} else {
				resp.sendRedirect("/Project/");
			}
			break;
		case "/cafeGoodList":
			System.out.println("카페좋아요리스트");
			if (sessionId != null) {
				ArrayList<CafeDTO> cafeGoodList = service.cafeGoodList();
				req.setAttribute("cafeGoodList", cafeGoodList);
				dis = req.getRequestDispatcher("myPage/myPageMenu/goodCafe.jsp");
				dis.forward(req, resp);
			} else {
				resp.sendRedirect("/Project/");
			}
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

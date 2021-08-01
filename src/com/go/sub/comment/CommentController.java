package com.go.sub.comment;

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

@WebServlet({ "/cafeCommentInput", "/cafeCommentDel", "/cafeCommentUpdate", "/cafeCommentList" })
public class CommentController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private void dual(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// url 파악
		int suc = 0;
		HashMap<String, Object> map = null;
		RequestDispatcher dis = null;
		boolean check = false;
		String uri = req.getRequestURI();
		String ctx = req.getContextPath();
		String addr = uri.substring(ctx.length());
		CommentService service = new CommentService(req);
		// 세션 아이디 가져오기
		HttpSession session = req.getSession();
		String sessionId = (String) session.getAttribute("loginId");
		switch (addr) {
		case "/cafeCommentInput":
			System.out.println("카페댓글등록");
			map = service.cafeCommentInput();
			if (map != null) {
				map.put("sessionId", sessionId);
				resp.setContentType("text/html; charset=UTF-8");
				resp.getWriter().print(new Gson().toJson(map));
			}
			break;
		case "/cafeCommentDel":
			System.out.println("카페댓글 삭제");
			map = service.cafeCommentDel();
			if (map != null) {
				map.put("sessionId", sessionId);
				resp.setContentType("text/html; charset=UTF-8");
				resp.getWriter().print(new Gson().toJson(map));
			}
			break;
		case "/cafeCommentList":
			System.out.println("카페댓글리스트");
			map = service.cafeCommentList();
			System.out.println(map);
			if (map != null) {
				map.put("sessionId", sessionId);
				resp.setContentType("text/html; charset=UTF-8");
				resp.getWriter().print(new Gson().toJson(map));
			}
			break;

		case "/cafeCommentUpdate":
			System.out.println("카페댓글수정");
			map = service.cafeCommentUpdate();
			if (map != null) {
				map.put("sessionId", sessionId);
				resp.setContentType("text/html; charset=UTF-8");
				resp.getWriter().print(new Gson().toJson(map));
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

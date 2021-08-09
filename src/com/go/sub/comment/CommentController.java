package com.go.sub.comment;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

@WebServlet({ "/cafeCommentInput", "/cafeCommentDel", "/cafeCommentUpdate", "/cafeCommentList", "/cafeCommentReport",
		"/productiptcomment", "/productcommentlist", "/productcommentdel", "/productcommentupdate" ,"/reportCommentList"})

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
			if (sessionId != null) {
				map = service.cafeCommentInput();
				if (map != null) {
					map.put("sessionId", sessionId);
					resp.setContentType("text/html; charset=UTF-8");
					resp.getWriter().print(new Gson().toJson(map));
				}
			} else {
				resp.sendRedirect("/Project/");
			}
			break;
		case "/cafeCommentDel":
			System.out.println("카페댓글 삭제");
			if (sessionId != null) {
				map = service.cafeCommentDel();
				if (map != null) {
					map.put("sessionId", sessionId);
					resp.setContentType("text/html; charset=UTF-8");
					resp.getWriter().print(new Gson().toJson(map));
				}
			} else {
				resp.sendRedirect("/Project/");
			}
			break;
		case "/cafeCommentList":
			System.out.println("카페댓글리스트");
			map = service.cafeCommentList();
			System.out.println(map);
			if (map != null) {
				map.put("sessionId", sessionId);
				System.out.println(map);
				resp.setContentType("text/html; charset=UTF-8");
				resp.getWriter().print(new Gson().toJson(map));
			}
			break;

		case "/cafeCommentUpdate":
			System.out.println("카페댓글수정");
			if (sessionId != null) {
				map = service.cafeCommentUpdate();
				if (map != null) {
					map.put("sessionId", sessionId);
					resp.setContentType("text/html; charset=UTF-8");
					resp.getWriter().print(new Gson().toJson(map));
				}
			} else {
				resp.sendRedirect("/Project/");
			}
			break;
		case "/cafeCommentReport":
			System.out.println("카페 댓글 신고");
			if (sessionId != null) {
				suc = service.cafeCommentReport();
				if (suc > 0) {
					resp.sendRedirect("/Project/report/reportResult.jsp");
				} else {
					req.setAttribute("check", check);
					dis = req.getRequestDispatcher("report/report.jsp");
					dis.forward(req, resp);
				}
			} else {
				resp.sendRedirect("/Project/");
			}
			break;


		case "/productiptcomment":
			System.out.println("상품 댓글 작성 요청");
			String commentContent = req.getParameter("commentContent");
			String productn = req.getParameter("productn");
			System.out.println(commentContent);
			System.out.println(productn);

			if (sessionId != null) {
				map = service.productcmtinput(commentContent, sessionId, productn);
				if (map != null) {
					map.put("sessionId", sessionId);
					resp.setContentType("text/html; charset=UTF-8");
					resp.getWriter().print(new Gson().toJson(map));
				}
			} else {
				resp.sendRedirect("/Project/");
			}

			break;

		case "/productcommentlist":
			System.out.println("상품댓글리스트");
			map = service.productcommentlist();
			if (map != null) {
				map.put("sessionId", sessionId);
				System.out.println(map);
				resp.setContentType("text/html; charset=UTF-8");
				resp.getWriter().print(new Gson().toJson(map));
			}
			break;

		case "/productcommentdel":
			System.out.println("카페댓글 삭제");
			if (sessionId != null) {
				map = service.productcommentdel();
				if (map != null) {
					map.put("sessionId", sessionId);
					resp.setContentType("text/html; charset=UTF-8");
					resp.getWriter().print(new Gson().toJson(map));
				}
			} else {
				resp.sendRedirect("/Project/");
			}
			break;

		case "/productcommentupdate":
			System.out.println("카페 댓글 수정");
			if (sessionId != null) {
				map = service.productcommentupdate();
				if (map != null) {
					map.put("sessionId", sessionId);
					resp.setContentType("text/html; charset=UTF-8");
					resp.getWriter().print(new Gson().toJson(map));
				}
			} else {
				resp.sendRedirect("/Project/");
			}

			break;
		case "/reportCommentList":
			System.out.println("신고댓글 리스트");
			if (sessionId != null) {
				map = service.reportCommentList();
				System.out.println(map);
				req.setAttribute("map", map);
				dis = req.getRequestDispatcher("myPage/commentMenu/reportComment.jsp");
				dis.forward(req, resp);
			}else {
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

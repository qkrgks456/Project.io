package com.go.main.cafe;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet({ "/cafeInput", "/cafeUpdate" })
public class CafeController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private void dual(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// url 파악
		String uri = req.getRequestURI();
		String ctx = req.getContextPath();
		String addr = uri.substring(ctx.length());

		RequestDispatcher dis = null;
		CafeService service = new CafeService(req);
		switch (addr) {
		case "/cafeInput":
			System.out.println("카페 등록");
			int suc = service.cafeInput();
			if(suc>0) {
				resp.sendRedirect("/Project/myPage/cafeMenu/cafeInput/cafeInputResult.jsp");
			}
			break;
		case "/cafeUpdate":

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

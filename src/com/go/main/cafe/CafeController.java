package com.go.main.cafe;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

@WebServlet({ "/cafewrite", "/cafeInfoMyPage", "/ownerCheck","/cafeUpdate" })
public class CafeController extends HttpServlet {
	// 안녕
	private static final long serialVersionUID = 1L;

	private void dual(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// url 파악
		String uri = req.getRequestURI();
		String ctx = req.getContextPath();
		String addr = uri.substring(ctx.length());

		int suc = 0;
		RequestDispatcher dis = null;
		CafeService service = new CafeService(req);
		switch (addr) {
		case "/cafewrite":
			System.out.println("카페 등록");
			suc = service.cafeInput();
			System.out.println(suc);
			if (suc > 0) {
				resp.sendRedirect("cafeInputResult.jsp");
			} 
			if (suc == 0) {
				System.out.println("이거 실행되나?");
				req.setAttribute("suc", suc);
				dis = req.getRequestDispatcher("myPage/cafeMenu/cafeInput/cafeInput.jsp");
				dis.forward(req, resp);
			}
			break;
		case "/ownerCheck":
			System.out.println("사업자 번호 체크");
			boolean ownerCheck = service.ownerCheck();
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("ownerCheck", ownerCheck);
			resp.setContentType("text/html; charset=UTF-8");
			resp.getWriter().print(new Gson().toJson(map));
			break;
			
		case "/cafeInfoMyPage":
			System.out.println("카페정보 마이페이지");		
			CafeDTO dto = service.cafeInfoMyPage();
			System.out.println("dto체크 : "+ dto);
			req.setAttribute("dto", dto);
			dis = req.getRequestDispatcher("myPage/cafeMenu/cafeUpdate/cafeInfo.jsp");
			dis.forward(req, resp);
			break;
		case "/cafeUpdate":
			System.out.println("카페정보 업데이트");
			suc = service.cafeUpdate();
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

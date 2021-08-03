package com.go.main.mainPage;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.go.main.cafe.CafeDTO;

@WebServlet({"/main"})
public class MainController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private void dual(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// url 파악
		String uri = req.getRequestURI();
		String ctx = req.getContextPath();
		String addr = uri.substring(ctx.length());
		RequestDispatcher dis = null;
		MainService service = new MainService(req);
		System.out.println(addr);
		switch (addr) {
		case "/main":
			System.out.println("안녕");
			ArrayList<CafeDTO> list = service.mainPage();
			req.setAttribute("list", list);
			dis = req.getRequestDispatcher("index.jsp");
			dis.forward(req, resp);
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

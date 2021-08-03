package com.go.main.cafe;

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

@WebServlet({"/cafewrite", "/cafeInfoMyPage", "/ownerCheck", "/cafeUpdate", "/cafeInputCheck", "/businessCheck",
		"/businessChange", "/cafeDel", "/cafeExist", "/cafeList", "/cafeDetail", "/confusionInfo",
		"/confusionTableChange", "/standardChange", "/cafeAlarmList", "/cafeAlarmDel", "/realTimeAlarm" })
public class CafeController extends HttpServlet {
	// 안녕
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
		CafeService service = new CafeService(req);
		ArrayList<CafeDTO> cafeAlarmList = null;
		HttpSession session = req.getSession();
		String sessionId = (String) session.getAttribute("loginId");
		switch (addr) {
		case "/cafeExist":
			if (sessionId != null) {
				check = service.cafeExist();
				System.out.println(check);
				if (req.getParameter("menu").equals("a")) {
					req.setAttribute("check", check);
					dis = req.getRequestDispatcher("myPage/cafeMenu/cafeDrop.jsp");
					dis.forward(req, resp);
				} else {
					req.setAttribute("check", check);
					dis = req.getRequestDispatcher("/confusionInfo");
					dis.forward(req, resp);
				}
			} else {
				resp.sendRedirect("/Project/main");
			}

			break;

		case "/cafeInputCheck":
			if (sessionId != null) {
				check = service.cafeInputCheck();
				req.setAttribute("check", check);
				dis = req.getRequestDispatcher("myPage/cafeMenu/cafeInput/cafeInput.jsp");
				dis.forward(req, resp);
			} else {
				resp.sendRedirect("/main");
			}
			break;
		case "/cafewrite":
			System.out.println("카페 등록");
			if (sessionId != null) {
				suc = service.cafeInput();
				System.out.println(suc);
				if (suc > 0) {
					map = new HashMap<String, Object>();
					map.put("suc", suc);
					resp.setContentType("text/html; charset=UTF-8");
					resp.getWriter().print(new Gson().toJson(map));
				} else {
					System.out.println("아따 실패랑게요");
					map = new HashMap<String, Object>();
					map.put("suc", suc);
					resp.setContentType("text/html; charset=UTF-8");
					resp.getWriter().print(new Gson().toJson(map));
				}
			} else {
				resp.sendRedirect("/main");
			}
			break;
		case "/ownerCheck":
			System.out.println("사업자 번호 체크");
			if (sessionId != null) {
				boolean ownerCheck = service.ownerCheck();
				map = new HashMap<String, Object>();
				map.put("businessCheck", true);
				map.put("ownerCheck", ownerCheck);
				resp.setContentType("text/html; charset=UTF-8");
				resp.getWriter().print(new Gson().toJson(map));
			} else {
				resp.sendRedirect("/main");
			}
			break;

		case "/cafeInfoMyPage":
			System.out.println("카페정보");
			if (sessionId != null) {
				CafeDTO dto = service.cafeInfoMyPage();
				System.out.println("dto체크 : " + dto);
				req.setAttribute("dto", dto);
				dis = req.getRequestDispatcher("myPage/cafeMenu/cafeUpdate/cafeInfo.jsp");
				dis.forward(req, resp);
			} else {
				resp.sendRedirect("/main");
			}
			break;
		case "/cafeUpdate":
			if (sessionId != null) {
				System.out.println("카페정보 업데이트");
				suc = service.cafeUpdate();
				if (suc > 0) {
					map = new HashMap<String, Object>();
					map.put("suc", suc);
					map.put("cafeKey", sessionId);
					resp.setContentType("text/html; charset=UTF-8");
					resp.getWriter().print(new Gson().toJson(map));
				}
			} else {
				resp.sendRedirect("/main");
			}
			break;

		case "/businessCheck":
			System.out.println("비즈니스 체크");

			if (sessionId != null) {
				boolean businessCheck = service.businessCheck();
				System.out.println(businessCheck);
				if (businessCheck) {
					req.setAttribute("businessCheck", businessCheck);
					dis = req.getRequestDispatcher("myPage/cafeMenu/businessChange/businessChange.jsp");
					dis.forward(req, resp);
				} else {
					req.setAttribute("businessCheck", businessCheck);
					dis = req.getRequestDispatcher("myPage/cafeMenu/businessChange/businessChangeCheck.jsp");
					dis.forward(req, resp);
				}
			} else {
				resp.sendRedirect("/main");
			}
			break;

		// 이거 없는 기능이에요 이제
		case "/businessChange":
			System.out.println("사업자 변경");
			// suc = service.businessChange();
			break;

		case "/cafeDel":
			System.out.println("카페 삭제 처리(블라인드)");
			if (sessionId != null) {
				suc = service.cafeDel();
				if (suc > 0) {
					map = new HashMap<String, Object>();
					map.put("suc", suc);
					resp.setContentType("text/html; charset=UTF-8");
					resp.getWriter().print(new Gson().toJson(map));
				}
			} else {
				resp.sendRedirect("/main");
			}
			break;

		case "/cafeList":
			System.out.println("카페리스트");
			map = service.cafeList();
			System.out.println(map);
			req.setAttribute("map", map);
			dis = req.getRequestDispatcher("MainCafe/cafeList.jsp");
			dis.forward(req, resp);
			break;
		case "/cafeDetail":
			System.out.println("카페 상세");
				map = service.cafeDetail();
				req.setAttribute("map", map);
				dis = req.getRequestDispatcher("MainCafe/cafe.jsp");
				dis.forward(req, resp);			
			break;
		case "/confusionInfo":
			if (sessionId != null) {
				check = service.cafeExist();
				/* check = Boolean.parseBoolean(); */
				System.out.println(check);
				System.out.println("혼잡도 현재 상태");
				map = service.confusionInfo();
				map.put("check", check);
				req.setAttribute("map", map);
				dis = req.getRequestDispatcher("myPage/cafeMenu/confusion.jsp");
				dis.forward(req, resp);
			} else {
				resp.sendRedirect("/main");
			}
			break;
		case "/confusionTableChange":
			System.out.println("혼잡도 테이블 수정");
			if (sessionId != null) {
				map = service.confusionTableChange();
				resp.setContentType("text/html; charset=UTF-8");
				resp.getWriter().print(new Gson().toJson(map));
			} else {
				resp.sendRedirect("/main");
			}
			break;
		case "/standardChange":
			System.out.println("혼잡도 기준 수정");
			if (sessionId != null) {
				map = service.standardChange();
				resp.setContentType("text/html; charset=UTF-8");
				resp.getWriter().print(new Gson().toJson(map));
			} else {
				resp.sendRedirect("/main");
			}
			break;
		case "/cafeAlarmList":
			System.out.println("회원 좋아요 누른 카페에서 알림오면 리스트");
			if (sessionId != null) {
				cafeAlarmList = service.cafeAlarmList();
				req.setAttribute("cafeAlarmList", cafeAlarmList);
				dis = req.getRequestDispatcher("myPage/myPageMenu/alerm.jsp");
				dis.forward(req, resp);
			} else {
				resp.sendRedirect("/main");
			}
			break;
		case "/cafeAlarmDel":
			System.out.println("알림삭제");
			if (sessionId != null) {
				cafeAlarmList = service.cafeAlarmDel();
				map = new HashMap<String, Object>();
				map.put("cafeAlarmList", cafeAlarmList);
				resp.setContentType("text/html; charset=UTF-8");
				resp.getWriter().print(new Gson().toJson(map));
			} else {
				resp.sendRedirect("/main");
			}

			break;
		case "/realTimeAlarm":
			System.out.println("실시간 알람");
			if (sessionId != null) {
				check = service.realTimeAlarm();
				map = new HashMap<String, Object>();
				map.put("check", check);
				resp.setContentType("text/html; charset=UTF-8");
				resp.getWriter().print(new Gson().toJson(map));
			} else {
				resp.sendRedirect("/main");
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

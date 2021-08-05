package com.go.sub.good;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.go.main.cafe.CafeDTO;

public class GoodService {
	HttpServletRequest req = null;
	GoodDAO dao = null;	
	public GoodService(HttpServletRequest req) {
		this.req = req;
	}

	public int cafeGood() {
		String goodCheckBtn = req.getParameter("goodCheckBtn");
		String cafeKey = req.getParameter("cafeKey");
		dao = new GoodDAO();
		return dao.cafeGood(goodCheckBtn,cafeKey,(String)req.getSession().getAttribute("loginId"));
	}

	public ArrayList<CafeDTO> cafeGoodList() {
		HttpSession session = req.getSession();
		String sessionId = (String) session.getAttribute("loginId");
		dao = new GoodDAO();		
		return dao.cafeGoodList(sessionId);
	}
	
}

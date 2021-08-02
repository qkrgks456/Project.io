package com.go.sub.good;

import javax.servlet.http.HttpServletRequest;

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
	
}

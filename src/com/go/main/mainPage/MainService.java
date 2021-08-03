package com.go.main.mainPage;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import com.go.main.cafe.CafeDTO;

public class MainService {
	HttpServletRequest req = null;
	public MainService(HttpServletRequest req) {
		this.req = req;
	}
	public ArrayList<CafeDTO> mainPage() {
		MainDAO dao = new MainDAO();
		return dao.mainPage();
	}

}

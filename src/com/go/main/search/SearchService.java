package com.go.main.search;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

public class SearchService {
	
	HttpServletRequest req =null;
	
	public SearchService(HttpServletRequest req){
		this.req = req;
	}

	public ArrayList<SearchDTO> namelist(String sresult) {
		SearchDAO dao = new SearchDAO();

		ArrayList<SearchDTO> namelist = dao.namelist(sresult);
		System.out.println("list size : " + namelist.size());
		return namelist;	
	}
	
}

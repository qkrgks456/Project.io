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
		System.out.println("찾은 카페 갯수 : " + namelist.size());
		return namelist;	
	}

	public ArrayList<SearchDTO> productlist(String sresult) {
		SearchDAO dao = new SearchDAO();
		ArrayList<SearchDTO> productlist = dao.productlist(sresult);
		System.out.println("찾은 상품 갯수 : " + productlist.size());		
		return productlist;		
	}
	
	
	
}

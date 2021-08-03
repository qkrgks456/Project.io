package com.go.main.search;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import com.google.gson.Gson;

public class SearchService {
	
	HttpServletRequest req =null;
	HttpServletResponse resp = null;;
	
	public Connection conn = null;
	public ResultSet rs = null;
	public PreparedStatement ps = null;
	
	public SearchService(HttpServletRequest req,HttpServletResponse resp){
		this.req = req;
		this.resp = resp;
		
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Oracle");
			conn = ds.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}		
	}
	

	public void namelist(String sresult) throws IOException {

		SearchDAO dao = new SearchDAO(req, resp);
		ArrayList<SearchDTO> namelist = dao.namelist(sresult);
		System.out.println("찾은 카페 갯수 : " + namelist.size());
		//return namelist;	
		if(namelist != null) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("list", namelist);
			Gson gson = new Gson();
			resp.setContentType("text/html; charset=UTF-8");//한글 깨짐 방지
			try {
				resp.getWriter().println(gson.toJson(map));
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
	}
	

	public ArrayList<SearchDTO> productlist(String sresult) {
		SearchDAO dao = new SearchDAO(req, resp);
		ArrayList<SearchDTO> productlist = dao.productlist(sresult);
		System.out.println("찾은 상품 갯수 : " + productlist.size());		
		return productlist;		
	}

	
	
	public ArrayList<SearchDTO> namelistpic(String sresult) {
		SearchDAO dao = new SearchDAO(req, resp);
		ArrayList<SearchDTO> namelistpic = dao.namelistpic(sresult);
		System.out.println("찾은 카페 갯수2 : " + namelistpic.size());
		return namelistpic;	
	}

	public void Alist() {		
		SearchDAO dao = new SearchDAO(req, resp);
		ArrayList<SearchDTO> Alist = dao.Alist();
		System.out.println("Alsit : " + Alist);
		if(Alist != null) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("Alist", Alist);
			Gson gson = new Gson();
			resp.setContentType("text/html; charset=UTF-8");//한글 깨짐 방지
			try {
				resp.getWriter().println(gson.toJson(map));
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			}
		}


	public void AlistT() {
		SearchDAO dao = new SearchDAO(req, resp);
		ArrayList<SearchDTO> AlistT = dao.AlistT();
		System.out.println("Alsitㅆ : " + AlistT);
		if(AlistT != null) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("AlistT", AlistT);
			Gson gson = new Gson();
			resp.setContentType("text/html; charset=UTF-8");//한글 깨짐 방지
			try {
				resp.getWriter().println(gson.toJson(map));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
}
}
	

	
	


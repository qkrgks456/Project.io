package com.go.main.admin;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

public class AdminService {
	
	HttpServletRequest req=null;
	int success=0;
	AdminDAO dao = new AdminDAO();
	ArrayList<AdminDTO> list=null;
	AdminDTO dto = new AdminDTO();
	
	public AdminService(HttpServletRequest req) {
		
		try {
			req.setCharacterEncoding("UTF-8");
			this.req = req;
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
	}

	public ArrayList<AdminDTO> adminMemberinfoSearch() {
		success=0;
		String adminMember =req.getParameter("adminMember");
		String adminSearchSelect =req.getParameter("adminSearchSelect");
		System.out.println("검색종류: "+adminSearchSelect +" / "+"검색내용: " +adminMember);
		list = dao.adminMemberinfoSearch(adminMember, adminSearchSelect);
		dao.resClose();
		return list;
	}

	public AdminDTO adminMemberDetail() {
		String memberkey = req.getParameter("memberkey");
		System.out.println("디테일 id값이 넘어왔는지 확인: "+ memberkey);
		dto = dao.adminMemberDetail(memberkey);
		dao.resClose();
		return dto;
	}

	public AdminDTO adminMemberBlackAdd() {
		String memberkey = req.getParameter("memberkey");
		String name = req.getParameter("name");
		System.out.println("블랙리스트 추가 id값이 넘어왔는지 확인: "+ memberkey);
		dto = dao.adminMemberBlackAdd(memberkey);
		dao.resClose();
		return dto;
	}

}

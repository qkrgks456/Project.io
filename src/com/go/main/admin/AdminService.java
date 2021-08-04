package com.go.main.admin;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;

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

	public AdminDTO adminMemberBlackAddPage() {
		String memberkey = req.getParameter("blackId");
		String name = req.getParameter("blackName");
		System.out.println("블랙리스트 추가 페이지 id값이 넘어왔는지 확인: "+ memberkey+"/"+name);
		dto = dao.adminMemberBlackAddPage(memberkey, name);
		dao.resClose();
		return dto;
	}

	public int adminMemberBlackMinus(String memberkey) {
		
		success=dao.adminMemberBlackMinus(memberkey);
		dao.resClose();
		return success;
	}

	public int adminMemberBlackAdd(String memberkey) {
		String blackRePort = req.getParameter("blackRePort");
		success = dao.adminMemberBlackAdd(memberkey, blackRePort);
		dao.resClose();
		return success;
	}


	public ArrayList<AdminDTO> adminSearch() {
		list = dao.adminSearch();
		dao.resClose();
		return list;
	}

	public HashMap<String, Object> adminDetail() {
		HashMap<String, Object> map=null;
		String memberkey = req.getParameter("memberkey");
		String sessionId = req.getParameter("sessionId");
		System.out.println("관리자 상세보기할 id: " +memberkey+"/세션: "+sessionId);
		map = dao.adminDetail(memberkey,sessionId);
		dao.resClose();
		return map;
		
	}

	public HashMap<String, Object> authorityDelete() {
		HashMap<String, Object> map=null;
		String memberkey = req.getParameter("memberkey");
		String sessionId = req.getParameter("sessionId");
		System.out.println("멤버와 세션값 확인: " + memberkey+"/세션: "+sessionId);
		
		map = dao.authorityDelete(memberkey,sessionId);
		dao.resClose();
		return map;
	}

	public ArrayList<AdminDTO> adminSelect() {
		
		String adminSearchSelect = req.getParameter("adminSearchSelect");
		String adminSelect  = req.getParameter("adminSelect");
		if(adminSearchSelect.isEmpty()){
			adminSearchSelect = (String) req.getAttribute("adminSearchSelect");
		}
		System.out.println("관리자 임명 데이터 확인 " +adminSearchSelect +"/"+ adminSelect );
		list=dao.adminSelect(adminSearchSelect, adminSelect);
		dao.resClose();
		return list;
	}

	public int memberAppoint() {
		String sessionId = req.getParameter("sessionId");
		String memberKey = req.getParameter("memberKey");
		System.out.println("세션값 확인: "+sessionId+"임명할 멤버: "+memberKey);
		success = dao.memberAppoint(sessionId , memberKey);
		dao.resClose();
		return success;
	}

	public ArrayList<AdminDTO> adminCafeSearch() {
		String cafeSearchSelect = req.getParameter("adminCafeSearchSelect");
		String adminCafeSearch = req.getParameter("adminCafeSearch");
		System.out.println("어드민에서 카페검색 검색종류 : "+cafeSearchSelect+" / 검색내용: " +adminCafeSearch );
		list = dao.adminCafeSearch(cafeSearchSelect, adminCafeSearch);
		dao.resClose();
		return list;
	}

	public AdminDTO adminCafeDetail() {
		String memberKey = req.getParameter("memberKey");
		System.out.println("상세조회할 카페 회원아이디: " +memberKey);
		dto = dao.adminCafeDetail(memberKey);
		dao.resClose();
		return dto;
	}

	public void cafeBlind() {
		String ownerNo = req.getParameter("ownerNo");
		dao.cafeBlind(ownerNo);
		
	}

}

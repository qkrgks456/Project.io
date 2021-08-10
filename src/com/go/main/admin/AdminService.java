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
	//권한 삭제
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
		String cafeKey = req.getParameter("cafeKey");
		success =0;
		if(req.getParameter("success")!=null) {
			success = Integer.parseInt(req.getParameter("success"));
		}
		System.out.println("상세조회할 카페 키: " +cafeKey);
		System.out.println("추가 성공 여부: "+success);
		dto = dao.adminCafeDetail(cafeKey);
		dao.resClose();
		return dto;
	}

	public AdminDTO cafeBlind() {
		String ownerNo = req.getParameter("ownerNo");
		dto = dao.cafeBlind(ownerNo);
		dao.resClose();
		return dto;
	}

	public HashMap<String, Object> cafeBlindAdd() {
		HashMap<String, Object> map=null;
		String cafeBlindRePort = req.getParameter("cafeBlindRePort");
		String cafeBlindId = req.getParameter("cafeBlindId");
		map = dao.cafeBlindAdd(cafeBlindRePort,cafeBlindId);
		dao.resClose();
		return map;
	}

	public HashMap<String, Object> cafeBlindMinus() {
		HashMap<String, Object> map=null;
		String ownerNo = req.getParameter("ownerNo");
		map=dao.cafeBlindMinus(ownerNo);
		dao.resClose();
		return map;
	}

	public ArrayList<AdminDTO> adminProductList() {
		String ProductSearchSelect = req.getParameter("ProductSearchSelect");
		String productSearch = req.getParameter("productSearch");
		System.out.println("검색할 상품정보: " +ProductSearchSelect+"/"+productSearch);
		list=dao.adminProductList(ProductSearchSelect,productSearch);
		dao.resClose();
		return list;
	}

	public AdminDTO adminProductDetail() {
		String productId= req.getParameter("productId");
		System.out.println("상세조회할 상품ID: " +productId);
		success = 0;
		if(req.getParameter("success")!=null) {
			success = Integer.parseInt(req.getParameter("success"));
		}
		dto = dao.adminProductDetail(productId);
		dao.resClose();
		return dto;
		
	}


	public HashMap<String, Object> adminProductBlindAdd() {
		HashMap<String, Object> map=null;
		String productBlindId = req.getParameter("productBlindId");
		String productBlindRePort = req.getParameter("productBlindRePort");
		System.out.println("블라인드 추가할 아이디: "+productBlindId+ "블라인드 사유: "+productBlindRePort);
		map = dao.adminProductBlindAdd(productBlindId,productBlindRePort);
		dao.resClose();
		return map;
	}

	public HashMap<String, Object> adminProductBlindMinus() {
		HashMap<String, Object> map=null;
		String productBlindId = req.getParameter("productBlindId");
		System.out.println("블라인드 해제할 아이디: "+productBlindId);
		map = dao.adminProductBlindMinus(productBlindId);
		dao.resClose();
		return map;
	}

	public ArrayList<AdminDTO> adminCommentSearch() {
		String adminCommentSearchSelect = req.getParameter("adminCommentSearchSelect");
		String adminCommentSearch = req.getParameter("adminCommentSearch");
		System.out.println("검색할 댓글 "+adminCommentSearchSelect+"/"+adminCommentSearch);
		
		list = dao.adminCommentSearch(adminCommentSearchSelect,adminCommentSearch);
		dao.resClose();
		return list;
	}

	public AdminDTO adminCommentDetail() {
		String commentNo = req.getParameter("commentNo");
		System.out.println("상세보기할 댓글 번호: "+commentNo);
		dto = dao.adminCommentDetail(commentNo);
		dao.resClose();
		return dto;
	}

	public ArrayList<AdminDTO> adminReportCommentSearch() {
		String adminReportCommentSearchSelect = req.getParameter("adminReportCommentSearchSelect");
		String adminReportCommentSearch = req.getParameter("adminReportCommentSearch");
		System.out.println("검색할 신고 댓글: "+adminReportCommentSearchSelect+"/"+adminReportCommentSearch);
		list = dao.adminReportCommentSearch(adminReportCommentSearchSelect,adminReportCommentSearch);
		dao.resClose();
		return list;
	}

	public AdminDTO adminReportCommentDetail() {
		String reportCmNo = req.getParameter("reportCmNo");
		System.out.println("상세보기할 신고댓글: "+reportCmNo);
		dto = dao.adminReportCommentDetail(reportCmNo);
		dao.resClose();
		return dto;
	}

	public AdminDTO adminReportCommentform() {
		String reportCmNo = req.getParameter("reportCmNo");
		System.out.println("신고 처리할 form"+ reportCmNo);
		dto = dao.adminReportCommentform(reportCmNo);
		dao.resClose();
		return dto;
	}

	public HashMap<String, Object> adminReportCmProcess() {
		HashMap<String, Object> map=null;
		String reportCmNo = req.getParameter("reportCmNo"); 
		String adminReportCmReason = req.getParameter("adminReportCmReason");
		String sessionId = req.getParameter("sessionId");
		System.out.println("신고처리할 댓글: "+reportCmNo+" / "+adminReportCmReason+"/"+sessionId);
		map = dao.adminReportCmProcess(reportCmNo, adminReportCmReason,sessionId);
		dao.resClose();
		return map;
		
	}

}

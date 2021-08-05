package com.go.main.admin;

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

@WebServlet({"/adminMemberList","/adminMemberListDetail","/adminMemberBlackAddPage","/adminMemberBlackMinus"
		,"/adminMemberBlackAdd","/adminSearch","/adminDetail","/authorityDelete","/adminSelect","/memberAppoint"
		,"/adminCafeSearch","/adminCafeDetail","/cafeBlind","/cafeBlindAdd","/cafeBlindMinus"})
public class AdminController extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		dual(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		dual(req, resp);
		
	}
	
	private void dual(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//주소 가져오기
		String uri = req.getRequestURI();
		String ctx = req.getContextPath();
		String addr = uri.substring(ctx.length());
		System.out.println("---------------------------------------");
		System.out.println("들어온 주소: "+addr);
		ArrayList<AdminDTO> list = null;
		AdminDTO dto = new AdminDTO();
		String memberkey="";
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		AdminService service = new AdminService(req);
		RequestDispatcher dis = null;
		
		int success=0;
		
		switch(addr) {
		case "/adminMemberList":
			System.out.println("어드민에서 멤버리스트 조회");
			list = service.adminMemberinfoSearch();
			req.setAttribute("list", list);
			dis = req.getRequestDispatcher("admin/adminList/adminMemberList/adminMemberList.jsp");
			dis.forward(req,resp);
			break;
			
		case "/adminMemberListDetail":
			System.out.println("어드민에서 회원상세 조회");
			dto = service.adminMemberDetail();
			req.setAttribute("adminMemberDetail", dto);
			dis = req.getRequestDispatcher("admin/adminList/adminMemberList/adminMemberDetail.jsp");
			dis.forward(req,resp);
			break;
			
		case "/adminMemberBlackAddPage":
			System.out.println("어드민에서 멤버 블랙리스트 추가 페이지");
			dto = service.adminMemberBlackAddPage();
			req.setAttribute("adminMemberBlack", dto);
			dis = req.getRequestDispatcher("admin/adminList/adminMemberList/adminMemberBlack.jsp");
			dis.forward(req,resp);
			break;
			
		case "/adminMemberBlackMinus":
			System.out.println("어드민에서 멤버 블랙리스트 해제");
			memberkey = req.getParameter("memberkey");
			System.out.println("블랙리스트 해제할 id확인: "+memberkey);
			
			success =service.adminMemberBlackMinus(memberkey);
			System.out.println("컨트롤러 해제 확인: " + success);
			req.setAttribute("success",success);
			resp.sendRedirect("/Project/adminMemberListDetail?memberkey="+memberkey);
			break;
			
		case "/adminMemberBlackAdd":
			System.out.println("어드민에서 블랙리스트 추가");
			memberkey = req.getParameter("blackId");
			System.out.println("블랙리스트 추가할 id확인: " +memberkey);
			
			success = service.adminMemberBlackAdd(memberkey);
			req.setAttribute("success",success);
			resp.sendRedirect("/Project/adminMemberListDetail?memberkey="+memberkey);
			break;
		
			/*어드민 셀렉트	*/
		case "/adminSearch":
			System.out.println("어드민에서 관리자 조회");
			
			list = service.adminSearch();
			
			req.setAttribute("adminSearch", list);
			dis = req.getRequestDispatcher("admin/adminSelect/adminSearch.jsp");
			dis.forward(req, resp);
			break;
			
		case "/adminDetail":
			System.out.println("어드민에서 관리자 상세보기");
	
			map = service.adminDetail();
			req.setAttribute("adminDetail", map);
			dis = req.getRequestDispatcher("admin/adminSelect/adminDetail.jsp");
			dis.forward(req,resp);
			break;
			
		case "/authorityDelete":
			System.out.println("어드민에서 권한 삭제");
			map = service.authorityDelete();
			System.out.println(map.get("memberkey"));
			req.setAttribute("authorityDelete", map);
			dis = req.getRequestDispatcher("/adminDetail");
			dis.forward(req,resp);
			//resp.sendRedirect("/Project/adminDetail?memberkey="+map.get("memberkey")+"&?suc="+map.get("suc"));
			

			break;
		case "/adminSelect":
			System.out.println("어드민에서 관리자 임명목록");
			list = service.adminSelect();
			req.setAttribute("adminSelect", list);
			dis = req.getRequestDispatcher("admin/adminSelect/adminSelect.jsp");
			dis.forward(req, resp);
			break;
		
		case "/memberAppoint":
			System.out.println("일반회원 부관리자 임명");
			success = service.memberAppoint();
			req.setAttribute("success", success);
			dis = req.getRequestDispatcher("admin/adminSelect/adminSelect.jsp");
			dis.forward(req, resp);
			break;
		case "/adminCafeSearch":
			System.out.println("어드민에서 카페정보 검색");
			list = service.adminCafeSearch();
			req.setAttribute("list", list);
			dis = req.getRequestDispatcher("admin/adminList/adminCafeList/adminCafeList.jsp");
			dis.forward(req, resp);
			break;
			
		case "/adminCafeDetail":
			System.out.println("어드민에서 카페 정보 상세");
			dto = service.adminCafeDetail();
			req.setAttribute("adminCafeDetail", dto);
			dis = req.getRequestDispatcher("admin/adminList/adminCafeList/adminCafeDetail.jsp");
			dis.forward(req, resp);
			break;
		case "/cafeBlind":
			System.out.println("어드민에서 카페 블라인드 추가 페이지");
			dto = service.cafeBlind();
			req.setAttribute("cafeBlind", dto);
			dis = req.getRequestDispatcher("admin/adminList/adminCafeList/adminCafeBlind.jsp");
			dis.forward(req, resp);
			break;
		case "/cafeBlindAdd":
			System.out.println("어드민에서 카페 블라인드 추가");
			map = service.cafeBlindAdd();
			System.out.println("컨트롤러 되돌아오는값 확인: " +success);
			req.setAttribute("cafeKey", map.get("cafeKey"));
			req.setAttribute("success", map.get("success"));
			dis=req.getRequestDispatcher("/adminCafeDetail");
			dis.forward(req, resp);
			break;
			
		case "/cafeBlindMinus":
			System.out.println("어드민에서 카페 블라인드 해제");
			break;
		}
		
		
	}
}
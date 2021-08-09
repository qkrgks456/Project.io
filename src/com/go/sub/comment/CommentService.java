package com.go.sub.comment;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class CommentService {
	int suc = 0;
	CommentDAO dao = null;
	CommentDTO dto = null;
	HttpServletRequest req = null;
	HashMap<String, Object> map = null;
	HashMap<String, Object> resultMap = null;
	public CommentService(HttpServletRequest req) {
		try {
			req.setCharacterEncoding("UTF-8");
			this.req = req;
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public HashMap<String, Object> cafeCommentInput() {
		dao = new CommentDAO();
		String cafeKey = req.getParameter("cafeKey");
		String commentContent = req.getParameter("commentContent");
		int page = 1;
		HttpSession session = req.getSession();
		String sessionId = (String) session.getAttribute("loginId");
		page = dao.cafeCommentInput(sessionId, commentContent, cafeKey);
		if (page!=0) {
			resultMap = dao.cafeCommentList(cafeKey,page);
		}
		dao.resClose();
		return resultMap;
	}

	public HashMap<String, Object> cafeCommentDel() {
		String commentNo = req.getParameter("commentNo");
		String cafeKey = req.getParameter("cafeKey");
		int page = 1;
		dao = new CommentDAO();
		page = dao.cafeCommentDel(commentNo,cafeKey);
		if(page!=0) {
			resultMap = dao.cafeCommentList(cafeKey,page);
		}
		
		dao.resClose();
		return resultMap;
	}

	public HashMap<String, Object> cafeCommentList() {
		String cafeKey = req.getParameter("cafeKey");
		String page = req.getParameter("page");
		System.out.println(cafeKey+" "+page);
		if(page == null) {
			page= "1";
		}
		dao = new CommentDAO();	
		HashMap<String, Object> map = dao.cafeCommentList(cafeKey,Integer.parseInt(page));
		dao.resClose();
		return map;
	}

	public HashMap<String, Object> cafeCommentUpdate() {
		String commentNo = req.getParameter("commentNo");
		String cafeKey = req.getParameter("cafeKey");
		String commentUpdateContent = req.getParameter("commentUpdateContent");
		System.out.println(commentNo+" "+cafeKey+" " +commentUpdateContent);
		int page = 1;
		dao = new CommentDAO();
		page = dao.cafeCommentUpdate(cafeKey,commentNo,commentUpdateContent);
		if(page!=0) {
			resultMap = dao.cafeCommentList(cafeKey,page);
		}
		
		dao.resClose();
		return resultMap;
	}

	public int cafeCommentReport() {
		HttpSession session = req.getSession();
		String sessionId = (String) session.getAttribute("loginId");
		String reportReason = req.getParameter("reportReason");
		String commentNo = req.getParameter("commentNo");
		String cafeKey = req.getParameter("cafeKey");
		System.out.println(commentNo);
		dao = new CommentDAO();
		return dao.cafeCommentReport(reportReason,commentNo,sessionId,cafeKey);
	}

	public HashMap<String,Object> productcmtinput(String commentContent, String sessionId, String productn) {
		dao = new CommentDAO();
		
		System.out.println("pid 찍힘? : " +productn);
		
		int page = 1;	
			page = dao.productcminput(productn,commentContent,sessionId);	
			if (page!=0) {
				resultMap = dao.productcommentlist(productn,page);
			}
			dao.resClose();
			
			return resultMap;
	}

	public HashMap<String, Object> productcommentlist() {
		String productn = req.getParameter("productn");
		String page = req.getParameter("page");
		if(page == null) {
			page= "1";
		}
		dao = new CommentDAO();	
		return dao.productcommentlist(productn,Integer.parseInt(page));
	}

}

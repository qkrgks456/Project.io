package com.go.main.cafe;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


public class CafeService {
	HttpServletRequest req = null;
	CafeUploadService upload = null;
	int suc = 0;
	public CafeService(HttpServletRequest req) {
		try {
			req.setCharacterEncoding("UTF-8");
			this.req = req;
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public int cafeInput() {
		suc = 0;
		// 파일
		upload = new CafeUploadService(req);
		CafeDTO dto = upload.PhotoUpload(); // 사진 업로드
		System.out.println("파일과 파라미터값 dto 잘 받았냐 : " + dto);
		HttpSession session = req.getSession();
		String sessionId = (String)session.getAttribute("loginId");
		System.out.println(sessionId);
		CafeDAO dao = new CafeDAO();
		suc = dao.cafeInput(dto,sessionId);
		if(suc==0) {
			upload.failPhoto(dto);
		}
		return suc;
	}

	public boolean ownerCheck() {

		String ownerNo = req.getParameter("ownerNo");
		CafeDAO dao = new CafeDAO();		
		return dao.ownerCheck(ownerNo);
	}

	public CafeDTO cafeInfoMyPage() {
		HttpSession session = req.getSession();
		String sessionId = (String)session.getAttribute("loginId");
		CafeDAO dao = new CafeDAO();	
		return dao.cafeInfoMyPage(sessionId);
	}

	public int cafeUpdate() {
		//세션값 들고오기
		HttpSession session = req.getSession();
		String sessionId = (String)session.getAttribute("loginId");
		//수정할 파일 업로드
		upload = new CafeUploadService(req);
		CafeDTO dto = upload.PhotoUpload();
		System.out.println(dto);
		CafeDAO dao = new CafeDAO();
		suc = dao.update(dto,sessionId);
		System.out.println("업데이트 성공 여부 : "+suc);
		if(!dto.getDelFileIdx().isEmpty()) {
			imgdel(dto);
		}
		return suc;
	}
	
	public int imgdel(CafeDTO dto) {
		System.out.println("이미지 선택 삭제 처리");
		CafeDAO dao = new CafeDAO();
		int suc = dao.imgdel(dto);
		System.out.println("db삭제여부 : " + suc);
		// 사진파일 삭제
		if(suc>0) {
			upload = new CafeUploadService(req);
			upload.multidel(dto);
		}		
		return suc;
	}

}

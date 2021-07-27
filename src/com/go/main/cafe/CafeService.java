package com.go.main.cafe;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


public class CafeService {
	HttpServletRequest req = null;
	CafeDAO dao = null; 
	
	public CafeService(HttpServletRequest req) {
		try {
			req.setCharacterEncoding("UTF-8");
			this.req = req;
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public int cafeInput() {
		int suc = 0;
		// 파일
		CafeUploadService upload = new CafeUploadService(req);
		CafeDTO dto = upload.PhotoUpload(); // 사진 업로드
		System.out.println("파일과 파라미터값 dto 잘 받았냐 : " + dto);
		HttpSession session = req.getSession();
		String sessionId = (String)session.getAttribute("loginId");
		System.out.println(sessionId);
		dao = new CafeDAO();
		suc = dao.cafeInput(dto,sessionId);
		return suc;
	}

}

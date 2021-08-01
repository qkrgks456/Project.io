package com.go.main.cafe;

import java.sql.SQLException;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


public class CafeService {
	HttpServletRequest req = null;
	CafeUploadService upload = null;
	int suc = 0;
	CafeDAO dao = null;
	CafeDTO dto = null;

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
		dto = upload.PhotoUpload(); // 사진 업로드
		System.out.println("파일과 파라미터값 dto 잘 받았냐 : " + dto);
		HttpSession session = req.getSession();
		String sessionId = (String) session.getAttribute("loginId");
		System.out.println(sessionId);
		dao = new CafeDAO();
		suc = dao.cafeInput(dto, sessionId);
		if (suc == 0) {
			upload.failPhoto(dto);
		}
		return suc;
	}

	public boolean ownerCheck() {

		String ownerNo = req.getParameter("ownerNo");
		dao = new CafeDAO();
		return dao.ownerCheck(ownerNo);
	}

	public CafeDTO cafeInfoMyPage() {
		HttpSession session = req.getSession();
		String sessionId = (String) session.getAttribute("loginId");
		dao = new CafeDAO();
		return dao.cafeInfoMyPage(sessionId);
	}

	public int cafeUpdate() {
		// 세션값 들고오기
		HttpSession session = req.getSession();
		String sessionId = (String) session.getAttribute("loginId");
		// 수정할 파일 업로드
		upload = new CafeUploadService(req);
		dto = upload.PhotoUpload();
		System.out.println(dto);
		dao = new CafeDAO();
		suc = dao.update(dto, sessionId);
		System.out.println("업데이트 성공 여부 : " + suc);
		if (!dto.getDelFileIdx().isEmpty()) {
			imgdel(dto);
		}
		return suc;
	}

	public int imgdel(CafeDTO dto) {
		System.out.println("이미지 선택 삭제 처리");
		dao = new CafeDAO();
		int suc = dao.imgdel(dto);
		System.out.println("db삭제여부 : " + suc);
		// 사진파일 삭제
		if (suc > 0) {
			upload = new CafeUploadService(req);
			upload.multidel(dto);
		}
		return suc;
	}

	public boolean cafeInputCheck() {
		dao = new CafeDAO();
		return dao.cafeInputCheck((String) req.getSession().getAttribute("loginId"));
	}

	public boolean businessCheck() {
		dao = new CafeDAO();
		String businessUserId = req.getParameter("businessUserId");
		String businessUserPw = req.getParameter("businessUserPw");
		String businessNumber = req.getParameter("businessNumber");
		System.out.println(businessUserId+ " "+businessUserPw +" "+ businessNumber);
		return dao.businessCheck(businessUserId,businessUserPw,businessNumber);
	}
	
// 없는 기능
//	public int businessChange() {
//		String ownerNo = req.getParameter("ownerNo");
//		dao = new CafeDAO();
//		return dao.businessChange(ownerNo);
//	}
	// 카페이미지 블라인드
	public int cafeDel() {
		dao = new CafeDAO();
		return dao.cafeDel((String)req.getSession().getAttribute("loginId"));
	}
	// 카페존재여부
	public boolean cafeExist() {
		dao = new CafeDAO();
		return dao.cafeExist((String) req.getSession().getAttribute("loginId"));
	}
	// 카페리스트
	public HashMap<String, Object> cafeList() {
		dao = new CafeDAO();
		String page = req.getParameter("page");
		System.out.println("page : " + page);
		if(page == null) {
			page= "1";
		}
		return dao.cafeList(Integer.parseInt(page));
	}

	public HashMap<String, Object> cafeDetail() {
		// 조회수랑 상세보기 자원정리는 여기서
		String cafeKey = req.getParameter("cafeKey");
		dao = new CafeDAO();
		HashMap<String, Object> map = null;
		String page = req.getParameter("page");
		System.out.println("page : " + page);
		if(page == null) {
			page= "1";
		}
		try {
			dao.conn.setAutoCommit(false);
			if (dao.upHit(cafeKey) > 0) {// 조회수 올리기
			map = dao.cafeDetail(cafeKey,Integer.parseInt(page));// 상세보기
			}
			if (map == null) {// commit || rollback
				dao.conn.rollback();
			} else {
				dao.conn.commit();
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			dao.resClose();
		}
		return map;
	}

}

package com.go.main.member;

import java.util.ArrayList;
import java.util.HashMap;



public class MemberService {

	MemberDAO dao = new MemberDAO();
	boolean result;
	ArrayList<MemberDTO> list=null;
	MemberDTO dto = new MemberDTO();

	// 로그인 서비스
	public boolean login(MemberDTO dto) {

		// dao.resClose();
		return dao.login(dto);

	}

	// 회원가입 서비스
	public int signup(MemberDTO dto) {
		int suc = 0;
		suc = dao.signup(dto);
		return suc;
	}

	// 회원가입 중복확인 서비스
	public boolean signupcheck(String memberKey) {
		boolean suc3 = dao.signupcheck(memberKey);
		return suc3;
	}

	// (login/idFind/idFind.jsp ) 이름 이메일 -> 아이디찾기
	public String findIdByEmail(String name, String email) {

		return dao.findIdByEmail(name, email);
	}

	// (login/passwordFind/passwordFind.jsp) 아이디 , 이름 , 이메일 -> 비밀번호 찾기
	public String findIdByEmailPw(String memberKey, String name, String email) {

		return dao.findIdByEmailPw(memberKey, name, email);
	}



	public int deleteMember(String sessionId) {
		MemberDAO dao = new MemberDAO();
		int memberdel = 0;
		memberdel = dao.deleteMember(sessionId);
		return memberdel;
	
		//return dao.deleteMember(dto);
		
	}

	// 내 정보 가져오기
	public MemberDTO myInfo(String sessionId) {
		return dao.myInfo(sessionId);
	}

	public int memberupdate(MemberDTO dto) {
		return dao.memberupdate(dto);
	}

	public boolean passwordFind(String pw, String memberKey) {
		
		return dao.passwordFind(pw,memberKey);
	}

	public int passwordChange(MemberDTO dto) {
		
		return dao.passwordChange(dto);
	}

	public ArrayList<MemberDTO> cafeMypageCommetList(String sessionId) {
		
		list = dao.cafeMypageCommetList(sessionId);
		dao.resClose();
		return list;
	}

	public ArrayList<MemberDTO> commentReport(String sessionId) {
		
		list = dao.commentReport(sessionId);
		dao.resClose();
		return list;
	}
	
	public ArrayList<MemberDTO> productCommentList(String sessionId) {
		
		list = dao.commentReport(sessionId);
		dao.resClose();
		return list;
	}

	public String getAuthority(String memberKey) {

		return dao.getAuthority(memberKey);
	}
	
}

package com.go.main.member;

public class MemberService {
	
	MemberDAO dao = new MemberDAO();
	boolean result;
	
	public String login(MemberDTO dto){	
		//String id = dao.login(dto);
		boolean id=dao.login(dto);
		dao.resClose();
		return null;
	}
	public boolean signup(MemberDTO dto) {
		result = dao.signup(dto);
		return true;
	}
}

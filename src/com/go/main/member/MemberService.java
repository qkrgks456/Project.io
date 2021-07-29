package com.go.main.member;

public class MemberService {
	
	MemberDAO dao = new MemberDAO();
	boolean result;
	
	public boolean login(MemberDTO dto){	
		
	
		//dao.resClose();
		return dao.login(dto);
	
	}
	
	public int signup(MemberDTO dto) {
		int suc=0;
		suc = dao.signup(dto);
		return suc;
	}
	public boolean signupcheck(String memberKey) {
		boolean suc3=dao.signupcheck(memberKey);
		return suc3;
	}
	
}

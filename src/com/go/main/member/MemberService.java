package com.go.main.member;



public class MemberService {
	
	MemberDAO dao = new MemberDAO();
	boolean result;
	
	
	//로그인 서비스 
	public boolean login(MemberDTO dto){	
		
	
		//dao.resClose();
		return dao.login(dto);
	
	}
	
	//회원가입 서비스 
	public int signup(MemberDTO dto) {
		int suc=0;
		suc = dao.signup(dto);
		return suc;
	}
	
	//회원가입 중복확인 서비스 
	public boolean signupcheck(String memberKey) {
		boolean suc3=dao.signupcheck(memberKey);
		return suc3;
	}
	
	//(login/idFind/idFind.jsp ) 이름 이메일 -> 아이디찾기 
	public String findIdByEmail(String name,String email) {

		return dao.findIdByEmail(name, email);
	}
	
	// (login/passwordFind/passwordFind.jsp) 아이디 , 이름 , 이메일 -> 비밀번호 찾기 
	public String findIdByEmailPw(String memberKey ,String name,String email) {

		return dao.findIdByEmailPw(memberKey, name, email);
	}
	
	//내정보 (myPage/myPageMenu/myInfo.jsp) 비밀번호, 이메일 ,주소 ,이메일수신,혼잡도 알림여부 -> 정보수정 
	public int memberupdate(String PW, String email , String location ,String emailCheck,String congestionCheck) {
		int value=0;
		value = dao.memberupdate(PW, email, location, emailCheck, congestionCheck);
		return value;
	}
	
	public boolean deleteMember(MemberDTO dto) {
		return dao.deleteMember(dto);
	}
}

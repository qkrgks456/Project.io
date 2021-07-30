package com.go.main.member;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.go.main.member.MemberDTO;
import com.go.main.member.MemberService;
import com.google.gson.Gson;

import sun.awt.RepaintArea;

@WebServlet({ "/login", "/logout", "/signup", "/signupcheck", 
	"/findIdByEmail","/findIdByEmailPw","/memberupdate","/deleteMember" })
public class MemberController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private void dual(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		// url 파악
		String uri = req.getRequestURI();
		String context = req.getContextPath();
		String subAddr = uri.substring(context.length());
		System.out.println(subAddr);

		// 변수
		String memberKey = null;
		String pw = null;
		String path = null;
		String pwcheck = null;
		String name = null;
		String email = null;
		String address = null;
		String gender = null;
		String congestionCheck = null;
		String emailCheck = null;
		String location = null;

		int age = 0;
		int result = 0;
		RequestDispatcher dis;
		HttpSession session = req.getSession();
		MemberDTO dto = new MemberDTO();
		MemberService service = new MemberService();

		switch (subAddr) {
		// 로그인 로직(테스트)
		case "/login":

			// 파라미터 체크
			req.setCharacterEncoding("UTF-8");
			memberKey = req.getParameter("InputId");
			pw = req.getParameter("InputPassword");
			path = req.getParameter("path");
			System.out.println(memberKey + " " + pw + " " + path);
			// 값 넣기
			dto.setMemberKey(memberKey);
			dto.setPw(pw);
			// 서비스 일 전달
			// result = service.login(dto); ?
			boolean suc2 = service.login(dto);
			if (suc2) {
				session.setAttribute("loginId", memberKey);
				resp.sendRedirect("index.jsp");
				System.out.println("로그인 성공했습니다");
			} else {
				req.setAttribute("success", "fail");
				dis = req.getRequestDispatcher("login/login.jsp");
				dis.forward(req, resp);
			}
			break;

		// 로그아웃 로직
		case "/logout":
			session.removeAttribute("loginId");
			resp.sendRedirect("index.jsp");
			break;

		case "/signup":
			System.out.println("회원가입");
			// 파라미터 체크
			req.setCharacterEncoding("UTF-8");
			memberKey = req.getParameter("UserId");
			pw = req.getParameter("UserPw");
			pwcheck = req.getParameter("UserPwch");
			name = req.getParameter("UserName");
			email = req.getParameter("UserEmail");
			address = req.getParameter("UserAddress");
			gender = req.getParameter("genderradio");
			location = req.getParameter("select");
			emailCheck = req.getParameter("emailradio");
			congestionCheck = req.getParameter("alertradio");
			System.out.println("회원가입정보 : " + memberKey + " " + pw + " " + pwcheck + /* " " + age + */ " " + name + " "
					+ email + "" + address + "" + gender + "" + location + "" + congestionCheck + "" + emailCheck);
			// 값 넣기
			dto.setMemberKey(memberKey);
			dto.setPw(pw);
			dto.setPw(pwcheck);
			dto.setName(name);
			dto.setEmail(email);
			dto.setGender(gender);
			dto.setLocation(location);
			dto.setEmailCheck(emailCheck);
			dto.setCongestionCheck(congestionCheck);

			// 서비스 일 전달
			// result = service.join(dto);
			result = service.signup(dto);
			System.out.println("result : " + result);
			if (result > 0) {
				resp.sendRedirect("/Project/signUp/signUpresult.jsp");
				//샌드는 경로를 다적어줘야한다.
			} else {
				req.setAttribute("success", "fail");
				dis = req.getRequestDispatcher("signUp/join.jsp");
				//겟리퀘스트 는 상대경로 개념이라서 이렇게 적어주면 된다.
				dis.forward(req, resp);
			}
			break;

		case "/signupcheck":
			System.out.println("중복체크");
			memberKey = req.getParameter("userId");
			System.out.println(memberKey);
			boolean suc = true;
			suc = service.signupcheck(memberKey);

			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("suc", suc);
			resp.setContentType("text/html; charset=UTF-8");
			resp.getWriter().print(new Gson().toJson(map));

			break;
		
			//(login/idFind/idFind.jsp ) 이름 이메일 -> 아이디찾기 
		case "/findIdByEmail": 
			System.out.println("이름 이메일 -> 아이디찾기 ");
			name = req.getParameter("UserName");  //indfind.jsp의 name 값을 넣어야됨 
			email = req.getParameter("UserEmail");//indfind.jsp의 name 값을 넣어야됨 
			System.out.println(name);
			System.out.println(email);
			
			String idchecksuc = service.findIdByEmail(name, email);
			if(idchecksuc.equals("")){
				req.setAttribute("idchecksuc", idchecksuc );
				dis = req.getRequestDispatcher("login/idFind/idFind.jsp");
				//겟리퀘스트 는 상대경로 개념이라서 이렇게 적어주면 된다.
				dis.forward(req, resp);
			}else {
				req.setAttribute("idchecksuc", idchecksuc);
				dis = req.getRequestDispatcher("login/idFind/idFindResult.jsp");
				//겟리퀘스트 는 상대경로 개념이라서 이렇게 적어주면 된다.
				dis.forward(req, resp);
			}
			
			break;
			
			// (login/passwordFind/passwordFind.jsp) 아이디 , 이름 , 이메일 -> 비밀번호 찾기 
		case "findIdByEmailPw":
			System.out.println("아이디 , 이름 , 이메일 -> 비밀번호 찾기 ");
			memberKey = req.getParameter("userId");
			name = req.getParameter("UserName");
			email = req.getParameter("UserEmail");
			System.out.println(memberKey);
			System.out.println(name);
			System.out.println(email);
			/* 수정해야됩니다...
			boolean suc6 = true;
			suc6 = service.findIdByEmailPw(memberKey, name, email);
			HashMap<String, Object> map2 = new HashMap<String, Object>();
			map2.put("suc6", suc6);
			resp.setContentType("text/html; charset=UTF-8");
			resp.getWriter().print(new Gson().toJson(map2));
			*/
			break;
			
			//내정보 (myPage/myPageMenu/myInfo.jsp) 비밀번호, 이메일 ,주소 ,이메일수신,혼잡도 알림여부 -> 정보수정 
			case "memberupdate":
			System.out.println("회원정보수정");
			// 파라미터 체크
			req.setCharacterEncoding("UTF-8");
			pw = req.getParameter("UserPw");
			pwcheck = req.getParameter("UserPwch");
			email = req.getParameter("UserEmail");
			location = req.getParameter("UserAddress");
			emailCheck = req.getParameter("emailsusin");
			congestionCheck = req.getParameter("alertradio");
			System.out.println(pw);
			System.out.println(pwcheck);
			System.out.println(email);
			System.out.println(location);
			System.out.println(emailCheck);
			System.out.println(congestionCheck);
			
			//값넣기
			dto.setPw(pw);
			dto.setPw(pwcheck);
			dto.setEmail(email);
			dto.setLocation(location);
			dto.setEmailCheck(emailCheck);
			dto.setCongestionCheck(congestionCheck);
			
			// 서비스 일 전달
			// result = service.join(dto);
			result = service.signup(dto);
			System.out.println("result : " + result);
			if (result > 0) {
			resp.sendRedirect("/Project/myPage/myPageMenu/myInforesult.jsp");
			//샌드는 경로를 다적어줘야한다.
			} else {
			req.setAttribute("success", "fail");
			dis = req.getRequestDispatcher("myPageMenu/myInfo.jsp");
			//겟리퀘스트 는 상대경로 개념이라서 이렇게 적어주면 된다.
			dis.forward(req, resp);
		}
			break;
			
			case "/deleteMember":
				System.out.println("회원을 삭제합니다.");
				memberKey = req.getParameter("id");
				dto.setMemberKey(memberKey);
				boolean suc7 = true;
				suc7 = service.deleteMember(dto);
				req.setAttribute("success", "del");
				dis = req.getRequestDispatcher("main");
				dis.forward(req, resp);
				break;
		}
		
	
		
	}


	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		dual(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		dual(req, resp);
	}

}

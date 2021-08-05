package com.go.main.member;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.go.main.admin.AdminDTO;
import com.go.main.admin.AdminService;
import com.go.main.member.MemberDTO;
import com.go.main.member.MemberService;
import com.google.gson.Gson;

import sun.awt.RepaintArea;
import sun.print.resources.serviceui_es;

@WebServlet({ "/login", "/logout", "/signup", "/signupcheck", "/findIdByEmail", "/findIdByEmailPw", "/memberupdate",
		"/deleteMember", "/myInfo", "/passwordFind","/passwordChange", "/cafeMypageCommetList" , "/commentReport"})
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
		String idCheck = null;

		int result = 0;
		RequestDispatcher dis;
		HttpSession session = req.getSession();
		MemberDTO dto = new MemberDTO();
		MemberService service = new MemberService();
		Cookie cookie = null;
		String sessionId = (String) session.getAttribute("loginId");
		
		ArrayList<MemberDTO> list = null;

		//HashMap<String, Object> map = new HashMap<String, Object>();
		

		
		
		
		
		
		switch (subAddr) {
		
		// 로그인 로직(테스트)
		case "/login":

			// 파라미터 체크
			req.setCharacterEncoding("UTF-8");         //값을 UTF-8로 받아준다
			memberKey = req.getParameter("InputId");   //멤버키를 login.jsp 에 있는 name=InputId값을 받아온다.
			pw = req.getParameter("InputPassword");		//패스워드를 login.jsp 에 있는 name=InputPassword값을 받아온다.
			idCheck = req.getParameter("idCheck");		//아이디체크를 login.jsp 에 있는 name=idCheck값을 받아온다.

			System.out.println(memberKey + " " + pw + " " + idCheck);
			// 값 넣기
			dto.setMemberKey(memberKey);    //dto에 멤버키 값을 적용
			dto.setPw(pw);					//dto에  패스워드 값을 적용 
			// 서비스 일 전달
			// result = service.login(dto); ?
			boolean suc2 = service.login(dto);   // boolean형 suc2는 서비스에 있는 logindto에 보냄
			if (suc2) {												//만약 suc2
				if (idCheck != null) {								//만약 아이디체크가 널이아니라면
					cookie = new Cookie("memberKey", memberKey);	//새로운쿠키에 멤버키에 멤버키를 받아온다.
					cookie.setPath("/");							//쿠키의 경로
					cookie.setMaxAge(60 * 60 * 24 * 30);			//쿠키의 시간
					resp.addCookie(cookie);							//resp.에 쿠키를 추가 
				} else {											//만약 쿠키가 널이 맞다면
					cookie = new Cookie("memberKey", "");			//새로운 쿠키에 멤버키에 널값을 받아온다.
					cookie.setPath("/");							//쿠키의 경로
					cookie.setMaxAge(0);							//쿠키의시간
					resp.addCookie(cookie);							//resp에 쿠키를 추가 
				}
				session.setAttribute("loginId", memberKey);			//IF가 성공하면 세션에있는 멤버키를 로그인상태로 적용
				resp.sendRedirect("/Project");						//응답을 메인으로 보내준다
				System.out.println("로그인 성공했습니다");				//IDE콘솔에 출력 
			} else {												///만약 실패하면
				req.setAttribute("success", "fail");				
				dis = req.getRequestDispatcher("login/login.jsp");  //로그인 상태 페이지로 보내진다.  
				dis.forward(req, resp);
			}

			break;

		// 로그아웃 로직
		case "/logout":										//로그아웃로직 실행
			session.removeAttribute("loginId");				// 세션에 있는 접속된아이디의 속성을 제거합니다.
			resp.sendRedirect("index.jsp");					//응답을 INDEX로 보내줍니다.
			break;											//멈춤
		
		//회원가입 로직 
		case "/signup":
			System.out.println("회원가입");			//IDE에 회원가입출력
			// 파라미터 체크
			req.setCharacterEncoding("UTF-8");			   //UTF8 적용
			memberKey = req.getParameter("UserId");			//singup/join.jsp 에 name=UserId 값을 파라미터로 받아온다.
			pw = req.getParameter("UserPw");				//singup/join.jsp 에 name=UserPw 값을 파라미터로 받아온다.
			pwcheck = req.getParameter("UserPwch");			//singup/join.jsp 에 name=UserPwch 값을 파라미터로 받아온다.
			name = req.getParameter("UserName");			//singup/join.jsp 에 name=UserName 값을 파라미터로 받아온다.
			email = req.getParameter("UserEmail");			//singup/join.jsp 에 name=UserEmail 값을 파라미터로 받아온다.
			address = req.getParameter("UserAddress");		//singup/join.jsp 에 name=UserAddress 값을 파라미터로 받아온다.
			gender = req.getParameter("genderradio");		//singup/join.jsp 에 name=genderradio 값을 파라미터로 받아온다.
			location = req.getParameter("userLocation");	//singup/join.jsp 에 name=userlocation 값을 파라미터로 받아온다.
			emailCheck = req.getParameter("emailradio");	//singup/join.jsp 에 name=emailradio 값을 파라미터로 받아온다.
			congestionCheck = req.getParameter("alertradio");	//singup/join.jsp 에 name=alertradio 값을 파라미터로 받아온다.
			System.out.println("회원가입정보 : " + memberKey + " " + pw + " " + pwcheck + /* " " + age + */ " " + name + " "
					+ email + "" + address + "" + gender + "" + location + "" + congestionCheck + "" + emailCheck);
			// 값 넣기
			dto.setMemberKey(memberKey);				//dto 
			dto.setPw(pw);
			dto.setPw(pwcheck);
			dto.setName(name);
			dto.setEmail(email);
			dto.setGender(gender);
			dto.setLocation(location);
			dto.setEmailCheck(emailCheck);
			dto.setCongestionCheck(congestionCheck);
			dto.setAddress(address);

			result = service.signup(dto);			
			System.out.println("result : " + result);
			if (result > 0) {
				resp.sendRedirect("/Project/signUp/signUpresult.jsp");
				// 샌드는 경로를 다적어줘야한다.
			} else {
				req.setAttribute("success", "fail");
				dis = req.getRequestDispatcher("signUp/join.jsp");
				// 겟리퀘스트 는 상대경로 개념이라서 이렇게 적어주면 된다.
				dis.forward(req, resp);
			}
			break;
			
			
		//중복확인 로직 
		case "/signupcheck":
			System.out.println("중복체크");
			memberKey = req.getParameter("userId");
			System.out.println(memberKey);
			boolean suc = true;
			suc = service.signupcheck(memberKey);

			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("memberKey", memberKey);
			map.put("suc", suc);
			resp.setContentType("text/html; charset=UTF-8");
			resp.getWriter().print(new Gson().toJson(map));

			break;
			
		// 이름 이메일->아이디찾기 로직 
		// (login/idFind/idFind.jsp ) 이름 이메일 -> 아이디찾기
		case "/findIdByEmail":
			System.out.println("이름 이메일 -> 아이디찾기 ");
			name = req.getParameter("UserName"); // indfind.jsp의 name 값을 넣어야됨
			email = req.getParameter("UserEmail");// indfind.jsp의 name 값을 넣어야됨
			System.out.println(name);
			System.out.println(email);

			String idchecksuc = service.findIdByEmail(name, email);
			if (idchecksuc.equals("")) {
				idchecksuc = "false";// 이것을 추가시켜줘야지 빨간색 경고표시가 뜬다.
				req.setAttribute("idchecksuc", idchecksuc);
				dis = req.getRequestDispatcher("login/idFind/idFind.jsp");
				// 겟리퀘스트 는 상대경로 개념이라서 이렇게 적어주면 된다.
				dis.forward(req, resp);
			} else {
				req.setAttribute("idchecksuc", idchecksuc);
				dis = req.getRequestDispatcher("login/idFind/idFindResult.jsp");
				// 겟리퀘스트 는 상대경로 개념이라서 이렇게 적어주면 된다.
				dis.forward(req, resp);
			}

			break;
			
		// 아이디,이름,이메일 -> 비밀번호 찾기 로직 
		// (login/passwordFind/passwordFind.jsp) 아이디 , 이름 , 이메일 -> 비밀번호 찾기
		case "/findIdByEmailPw":
			System.out.println("아이디 , 이름 , 이메일 -> 비밀번호 찾기 ");
			memberKey = req.getParameter("UserId");
			name = req.getParameter("UserName");
			email = req.getParameter("UserEmail");
			System.out.println(memberKey);
			System.out.println(name);
			System.out.println(email);

			String pwchecksuc = service.findIdByEmailPw(memberKey, name, email);
			if (pwchecksuc.equals("")) {
				pwchecksuc = "false";
				req.setAttribute("pwchecksuc", pwchecksuc);
				dis = req.getRequestDispatcher("login/passwordFind/passwordFind.jsp");
				// 겟리퀘스트 는 상대경로 개념이라서 이렇게 적어주면 된다.
				dis.forward(req, resp);
			} else {
				req.setAttribute("pwchecksuc", pwchecksuc);
				dis = req.getRequestDispatcher("login/passwordFind/passwordFindResult.jsp");
				// 겟리퀘스트 는 상대경로 개념이라서 이렇게 적어주면 된다.
				dis.forward(req, resp);
			}

			break;

		// 내 정보 보여주기 로직 
		case "/myInfo":
			System.out.println("내 정보 보여주기 ");
			String updateSuc = req.getParameter("sucupdate");
			dto = service.myInfo(sessionId);
			if (updateSuc != null) {
				req.setAttribute("updateSuc", updateSuc);
				req.setAttribute("dto", dto);
				dis = req.getRequestDispatcher("myPage/myPageMenu/myInfo.jsp");
				// 겟리퀘스트 는 상대경로 개념이라서 이렇게 적어주면 된다.
				dis.forward(req, resp);
			} else {
				req.setAttribute("dto", dto);
				dis = req.getRequestDispatcher("myPage/myPageMenu/myInfo.jsp");
				// 겟리퀘스트 는 상대경로 개념이라서 이렇게 적어주면 된다.
				dis.forward(req, resp);
			}
			break;

			
			
			
			
			
		// 내정보 (myPage/myPageMenu/myInfo.jsp) 비밀번호, 이메일 ,주소 ,이메일수신,혼잡도 알림여부 -> 정보수정
		case "/memberupdate":
			System.out.println("회원정보수정 합니다.");
			// 파라미터 체크
			name = req.getParameter("UserName");
			email = req.getParameter("UserEmail");
			address = req.getParameter("UserAddress");
			location = req.getParameter("select");
			emailCheck = req.getParameter("emailcheckchange");
			congestionCheck = req.getParameter("alertradiochange");
			System.out.println(name);
			System.out.println(email);
			System.out.println(address);
			System.out.println(location);
			System.out.println(emailCheck);
			System.out.println(congestionCheck);

			// 값넣기
			dto.setName(name);
			dto.setEmail(email);
			dto.setAddress(address);
			dto.setLocation(location);
			dto.setEmailCheck(emailCheck);
			dto.setCongestionCheck(congestionCheck);
			dto.setMemberKey(sessionId);
			int sucupdate = service.memberupdate(dto);
			if (sucupdate > 0) {
				req.setAttribute("sucupdate", sucupdate);
				dis = req.getRequestDispatcher("myInfo?sucupdate=" + sucupdate);
				// 겟리퀘스트 는 상대경로 개념이라서 이렇게 적어주면 된다.
				dis.forward(req, resp);
			} else {
				req.setAttribute("success", "fail");
				// dis = req.getRequestDispatcher("myPageMenu/myInfo.jsp");
				dis = req.getRequestDispatcher("myPage/myPageMenu/myInfomyInforesult.jsp");
				// 겟리퀘스트 는 상대경로 개념이라서 이렇게 적어주면 된다.
				dis.forward(req, resp);
			}
			break;

		case "/deleteMember":
			System.out.println("회원을 삭제합니다.");

			int memberdel = service.deleteMember(sessionId);
			System.out.println("성공 했나요? : " + memberdel);
			if (memberdel > 0) {
				session.removeAttribute("loginId");
				resp.sendRedirect("/Project/");
			}

			break;
		
			//myPage/myPageMenu/passChange.jsp --> 비밀번호 변경 확인 로직
		case "/passwordFind":
			System.out.println(" -> 아이디찾기 ");
			memberKey=req.getParameter("UserId");
			pw = req.getParameter("UserPw"); // passChange.jsp의 name 값을 넣어야됨
			System.out.println(pw);
			System.out.println(memberKey);			
			boolean check = service.passwordFind(pw,memberKey);
			
			if (check) {
				resp.sendRedirect("/Project/myPage/myPageMenu/passChange.jsp");
			} else {
				req.setAttribute("pwfindsuc", check);
				dis = req.getRequestDispatcher("myPage/myPageMenu/passChangeCheck.jsp");
				// 겟리퀘스트 는 상대경로 개념이라서 이렇게 적어주면 된다.
				dis.forward(req, resp);
			}
	
			break;
			
			//비밀번호 변경 로직 
		case"/passwordChange":
			System.out.println("비밀번호를 수정합니다.");
			pw = req.getParameter("UserPws"); 
			System.out.println(pw);
			System.out.println(sessionId);
			dto.setPw(pw);
			dto.setMemberKey(sessionId);
			int sucpassChange = service.passwordChange(dto);
			System.out.println("성공 했나요? : " + sucpassChange);
			if (sucpassChange > 0) {
				session.removeAttribute("loginId");
				resp.sendRedirect("/Project/");
			}
	
			break;
			
		
		case "/cafeMypageCommetList":
			System.out.println("내정보에있는 댓글리스트를 보여줍니다.");
			
			list = service.cafeMypageCommetList(sessionId);
			System.out.println("list"+list);
			req.setAttribute("cafeMypageCommetList", list);
			dis = req.getRequestDispatcher("myPage/commentMenu/cafeComment.jsp");
			dis.forward(req, resp);
			break;
			
		case "/commentReport":
			System.out.println("내정보에있는 댓글신고리스트를 보여줍니다.");
			
			list = service.cafeMypageCommetList(sessionId);
			System.out.println("list"+list);
			req.setAttribute("commentReport", list);
			dis = req.getRequestDispatcher("myPage/commentMenu/reportComment.jsp");
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

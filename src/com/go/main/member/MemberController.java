package com.go.main.member;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.go.main.member.MemberDTO;
import com.go.main.member.MemberService;

@WebServlet({"/login","/logout","/signup"})
public class MemberController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private void dual(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
		// url 파악
		String uri = req.getRequestURI();
		String context = req.getContextPath();
		String subAddr = uri.substring(context.length());
		System.out.println(subAddr);
		
		// 변수
		String memberKey = null; 
		String pw = null; 
		String path =null;
		String pwcheck = null;
		String name =null;
		String email=null;
		String address=null;
		String gender=null;
		String congestionCheck=null;
		String emailCheck=null;
		String location=null;
		
		int age = 0;
		boolean result = false;
		RequestDispatcher dis;
		HttpSession session = req.getSession();
		MemberDTO dto = new MemberDTO();
		MemberService service = new MemberService();
		
		
		switch (subAddr) {
		// 로그인 로직(테스트)
		case "/login": 
			PrintWriter out = resp.getWriter();
			memberKey = req.getParameter("InputId");
			pw = req.getParameter("InputPassword");
			path = req.getParameter("path");
			System.out.println(memberKey+" "+pw+" "+path);
			if(memberKey.equals("qkrgks456")&&pw.equals("qkr123")) {
				session.setAttribute("loginId", memberKey);
				out.print("1");
				out.flush();
				out.close();
			}else {
				out.print("2");
				out.flush();
				out.close();
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
						address= req.getParameter("UserAddress");
						gender=req.getParameter("genderradio");
						location =req.getParameter("select");
						emailCheck =req.getParameter("emailradio");
						congestionCheck=req.getParameter("alertradio");
						System.out.println("회원가입정보 : " + memberKey + " " + pw + " " + pwcheck
								+ /* " " + age + */ " " + name + " " + email+ "" +address + "" +gender+""+location+""+congestionCheck+""+emailCheck);
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
				//result = service.join(dto);
			result =service.signup(dto);
					System.out.println("result : "+result);
				if (result) {
					req.setAttribute("success", "true");
					dis = req.getRequestDispatcher("index.jsp");
					dis.forward(req, resp);
				} else {
						req.setAttribute("success", "false");
						dis = req.getRequestDispatcher("index.jsp");
						dis.forward(req, resp);
					}
			break;
		}
		
		
	}
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		dual(req,resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		dual(req,resp);
	}

}

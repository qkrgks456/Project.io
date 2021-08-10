package com.go.main.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.go.main.member.MemberDTO;
import com.go.sub.comment.CommentDTO;
import com.go.main.cafe.CafeDTO;

public class MemberDAO {

	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	boolean result = false;
	String sql = null;
	MemberDTO dto = null;
	CafeDTO CafeDTO = null;
	CommentDTO CommentDTO = null;
	ArrayList<MemberDTO> list = null;

	public MemberDAO() {
		try {
			// 1. Context 가져오기
			Context ctx = new InitialContext();
			// 2. name으로 Resource 가져와 DataSource 변환
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Oracle");
			// 3. Connection 가져오기
			conn = ds.getConnection();
			System.out.println("member커넥션 : " + conn);
		} catch (Exception e) {
			e.printStackTrace();

		}

	}

	public boolean login(MemberDTO dto) {
		sql = "SELECT memberkey FROM users WHERE memberkey=? AND pw=? AND deleteCheck='N'";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, dto.getMemberKey());
			ps.setString(2, dto.getPw());
			rs = ps.executeQuery();
			if (rs.next()) {
				result = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			resClose();
		}
		return result;
	}

	// return null;

	public int signup(MemberDTO dto) {
		int suc = 0;

		sql = "INSERT INTO users (memberKey,pw,name,gender,email"
				+ ",emailCheck,congestionCheck,deleteCheck,authority,location,address) "
				+ "VALUES(?,?,?,?,?,?,?,'N','일반',?,?)"; // DTO 10개
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, dto.getMemberKey());
			ps.setString(2, dto.getPw());
			ps.setString(3, dto.getName());
			ps.setString(4, dto.getGender());
			ps.setString(5, dto.getEmail());
			ps.setString(6, dto.getEmailCheck());
			ps.setString(7, dto.getCongestionCheck());
			ps.setString(8, dto.getLocation());
			ps.setString(9, dto.getAddress());

			suc = ps.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			resClose();
		}

		return suc;
	}

	public boolean signupcheck(String memberkey) {
		sql = "SELECT memberkey FROM users WHERE memberkey=? ";
		boolean suc4 = false;

		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, memberkey);
			rs = ps.executeQuery();
			suc4 = rs.next();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			resClose();
		}
		return suc4;
	}

	// (login/idFind/idFind.jsp ) 이름 이메일 -> 아이디찾기
	public String findIdByEmail(String name, String email) {

		String sql = "SELECT memberKey FROM users Where name=? and email=? ";
		String memberKey = null;
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, name);
			ps.setString(2, email);
			rs = ps.executeQuery();

			if (rs.next()) {
				memberKey = rs.getString("memberKey");

			} else {
				memberKey = "";
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			resClose();
		}
		System.out.println(memberKey);
		return memberKey;
	}

	// (login/passwordFind/passwordFind.jsp) 아이디 , 이름 , 이메일 -> 비밀번호 찾기
	public String findIdByEmailPw(String memberKey, String name, String email) {

		String sql = "SELECT pw FROM users Where memberKey=? and name=? and email=? ";
		String PW = null;
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, memberKey);
			ps.setString(2, name);
			ps.setString(3, email);
			rs = ps.executeQuery();

			if (rs.next()) {
				PW = rs.getString("PW"); // 디비에서 가져온 cnt 를 저장
			} else {
				PW = "";
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			resClose();
		}
		return PW;

	}

	// 내정보 (myPage/myPageMenu/myInfo.jsp) 비밀번호, 이메일 ,주소 ,이메일수신,혼잡도 알림여부 -> 정보수정
	public int memberupdate(MemberDTO dto) {
		int sucupdate = 0;
		String sql = "update users set name=?, email=? , address=? ,location=?,emailCheck=?,congestionCheck=? where memberkey=? ";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, dto.getName());
			ps.setString(2, dto.getEmail());
			ps.setString(3, dto.getAddress());
			ps.setString(4, dto.getLocation());
			ps.setString(5, dto.getEmailCheck());
			ps.setString(6, dto.getCongestionCheck());
			ps.setString(7, dto.getMemberKey());
			sucupdate = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			resClose();
		}
		return sucupdate;
	}

	/// Project/myPage/myPageMenu/memberDrop.jsp
	// 회원탈퇴
	public int deleteMember(String sessionId) {
		int memberdel = 0;
		String sql = "UPDATE users SET deleteCheck = 'Y' WHERE memberkey=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, sessionId);
			// ps.setString(2, dto.getMemberKey());
			memberdel = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			resClose();
		}
		return memberdel;
	}

	public boolean passwordFind(String pw, String memberKey) {
		boolean passFindCheck = false;
		try {
			String sql = "SELECT * FROM users Where memberKey=? AND pw=? ";
			ps = conn.prepareStatement(sql);
			ps.setString(1, memberKey);
			ps.setString(2, pw);
			rs = ps.executeQuery();
			if (rs.next()) {
				passFindCheck = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			resClose();
		}
		return passFindCheck;
	}

	public int passwordChange(MemberDTO dto) {
		int sucpassChange = 0;
		System.out.println("이거와?" + dto.getPw());
		try {
			String sql = "UPDATE users SET pw=? WHERE memberkey=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, dto.getPw());
			ps.setString(2, dto.getMemberKey());
			sucpassChange = ps.executeUpdate();
			System.out.println("이거와?" + dto.getPw());
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			resClose();
		}
		return sucpassChange;
	}

	public void resClose() {
		try {
			if (rs != null && !rs.isClosed()) {
				rs.close();
			}
			if (ps != null && !ps.isClosed()) {
				ps.close();
			}
			if (conn != null && !conn.isClosed()) {
				conn.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 내정보 가져오기
	public MemberDTO myInfo(String sessionId) {
		dto = new MemberDTO();
		try {
			String sql = "SELECT name,email,address,location,emailCheck,congestionCheck FROM users WHERE memberKey=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, sessionId);
			rs = ps.executeQuery();
			if (rs.next()) {
				dto.setName(rs.getString("name"));
				dto.setEmail(rs.getString("email"));
				dto.setAddress(rs.getString("address"));
				dto.setLocation(rs.getString("location"));
				dto.setEmailCheck(rs.getString("emailCheck"));
				dto.setCongestionCheck(rs.getString("congestionCheck"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			resClose();
		}
		return dto;
	}

	public ArrayList<MemberDTO> cafeMypageCommetList(String sessionId) {
		System.out.println("내정보 카페댓글 조회 ");
		sql = "select cm.division,cm.memberKey,cm.cm_content,c.cafeName" + " FROM(SELECT division,memberKey,cm_content "
				+ "FROM cm WHERE memberKey=? and commentDel='N' ORDER BY commentNo)cm "
				+ "LEFT OUTER JOIN cafeInfo c ON cm.division=c.cafeKey WHERE c.cafeDel='N'";

		ArrayList<MemberDTO> list = new ArrayList<MemberDTO>();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, sessionId);
			System.out.println("세션아이디" + sessionId);

			rs = ps.executeQuery();
			while (rs.next()) {
				dto = new MemberDTO();
				dto.setDivision(rs.getString("division"));
				dto.setCm_content(rs.getString("cm_content"));
				dto.setCafeName(rs.getString("cafeName"));
				list.add(dto);

			}
		} catch (SQLException e) {

			e.printStackTrace();
		}
		return list;

	}

	// 내정보 신고댓글리스트 /mypage/commentMenu/reportCommnet.jsp
	public ArrayList<MemberDTO> commentReport(String sessionId) {
		System.out.println("내정보 신고댓글 조회 ");

		sql = "select cr.division, c.cm_content, cr.reportReason, cr.processStatus,cr.managers from cm c "
				+ "left outer join cmreport cr ON c.commentNo = cr.commentNo WHERE memberKey =?";

		ArrayList<MemberDTO> list = new ArrayList<MemberDTO>();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, sessionId);
			System.out.println("세션아이디" + sessionId);

			rs = ps.executeQuery();
			while (rs.next()) {
				dto = new MemberDTO();
				dto.setDivision(rs.getString("division"));
				dto.setCm_content(rs.getString("cm_content"));
				dto.setReportReason(rs.getString("reportReason"));
				dto.setProcessStatus(rs.getString("processStatus"));
				dto.setManagers(rs.getString("managers"));
				list.add(dto);

			}
		} catch (SQLException e) {

			e.printStackTrace();
		}
		return list;

	}

	// 내정보 상품 댓글리스트
	public ArrayList<MemberDTO> productCommentList(String sessionId) {
		System.out.println("내정보 상품댓글 조회 ");
		System.out.println("세션아이디" + sessionId);
		list = new ArrayList<MemberDTO>();
		sql = "select p.productName, c.cm_content,p.productId from "
				+ "product p left outer join cm c ON c.division = p.productId "
				+ "where c.memberKey = ? AND c.commentDel='N'";

		ArrayList<MemberDTO> list = new ArrayList<MemberDTO>();
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, sessionId);
			rs = ps.executeQuery();
			while (rs.next()) {
			dto = new MemberDTO();
			dto.setCmProductname(rs.getString("productName"));
			dto.setCm_content(rs.getString("cm_content"));
			dto.setProductId(rs.getInt("productId"));
			list.add(dto);
			}
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
			
		
		return list;

	}

	public String getAuthority(String memberKey) {
		String authority = null;
		try {
			sql = "SELECT authority FROM users WHERE memberKey=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, memberKey);
			rs = ps.executeQuery();
			if (rs.next()) {
				authority = rs.getString("authority");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			resClose();
		}
		return authority;
	}

}

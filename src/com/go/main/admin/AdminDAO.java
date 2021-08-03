package com.go.main.admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class AdminDAO {

	Connection conn = null;
	ResultSet rs = null;
	PreparedStatement ps = null;

	AdminDTO dto = null;
	ArrayList<AdminDTO> list = null;
	List<AdminDTO> dtoList=null;
	String sql = "";
	int success = 0;

	public AdminDAO() {

		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Oracle");
			conn = ds.getConnection();
			System.out.println("admin DB연결체크 : " + conn);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public ArrayList<AdminDTO> adminMemberinfoSearch(String adminMember, String adminSearchSelect) {
		ArrayList<AdminDTO> list=null;
		System.out.println("dao까지 연결확인: " + adminSearchSelect + "/" + adminMember);
		sql = "SELECT u.memberKey , u.name , bb.statuscheck, ou.ownerno, u.deletecheck FROM users u LEFT OUTER JOIN blackList bb ON u.memberKey = bb.memberKey LEFT OUTER JOIN ownerUser ou ON u.memberKey=ou.memberKey WHERE u.memberkey LIKE ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, "%" + adminMember + "%");
			rs = ps.executeQuery();

			/* 값이 있다면 */
			if (rs.next()) {
				success = 1;

				dto = new AdminDTO();
				list = new ArrayList<AdminDTO>();
				dto.setMemberkey(rs.getString("memberKey"));
				dto.setName(rs.getString("name"));
				dto.setBlackStatus(rs.getString("statuscheck"));
				dto.setOwnerNo(rs.getString("ownerNo"));
				dto.setDeleteCheck(rs.getString("deleteCheck"));

				System.out.println("dto에 값 저장: " + dto.getMemberkey() + "/" + dto.getName() + "/" + dto.getBlackStatus()
						+ "/" + dto.getOwnerNo() + "/" + dto.getDeleteCheck());
				list.add(dto);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return list;
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

	public AdminDTO adminMemberDetail(String memberkey) {
		System.out.println("어드민 dao까지 연결확인: " + memberkey);
		sql = "SELECT u.memberKey, u.name, u.email, u.location, u.gender, u.emailcheck"
				+ " , u.CONGESTIONCHECK, b.statuscheck, b.blackreport,b.blackreporter FROM users u"
				+ " LEFT OUTER JOIN blackList b on u.memberKey = b.memberKey where u.memberKey = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, memberkey);
			rs = ps.executeQuery();
			if (rs.next()) {
				dto = new AdminDTO();
				dto.setMemberkey(rs.getString("memberKey"));
				dto.setName(rs.getString("name"));
				dto.setEmail(rs.getString("email"));
				dto.setLocation(rs.getString("location"));
				dto.setGender(rs.getString("gender"));
				dto.setEmailCheck(rs.getString("emailcheck"));
				dto.setCongestionCheck(rs.getString("CONGESTIONCHECK"));
				dto.setBlackStatus(rs.getString("statuscheck"));
				dto.setBlackReport(rs.getString("blackreport"));
				dto.setBlackReporter(rs.getString("blackreporter"));

				System.out.println("DTO에 어드민 디테일값 저장: " + dto.getMemberkey() + "/" + dto.getName() + "/"
						+ dto.getEmail() + "/" + dto.getLocation() + "/" + dto.getGender() + "/" + dto.getEmailCheck()
						+ "/" + dto.getCongestionCheck() + "/" + dto.getBlackStatus() + "/" + dto.getBlackReport() + "/"
						+ dto.getBlackReporter());
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return dto;
	}

	public AdminDTO adminMemberBlackAddPage(String memberkey, String name) {
		System.out.println("블랙리스트 추가페이지 dao까지 연결확인: " + memberkey + "/" + name);
		sql = "SELECT u.memberkey, u.name FROM users u";

		dto = new AdminDTO();
		dto.setMemberkey(memberkey);
		dto.setName(name);
		return dto;
	}

	public int adminMemberBlackMinus(String memberkey) {
		System.out.println("블랙리스트 해제 dao까지 연결확인: " + memberkey);
		sql = "DELETE FROM blackList where memberKey = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, memberkey);
			success = ps.executeUpdate();
			System.out.println("삭제 성공 여부: " + success);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return success;

	}

	public int adminMemberBlackAdd(String memberkey, String blackRePort) {
		System.out.println("블랙리스트 추가페이지 dao까지 연결확인: " + memberkey + "/" + blackRePort);
		sql = "INSERT INTO blackList(blacklistno,memberkey,blackreport,blackreporter,statusCheck) VALUES(blacklistNo_seq.nextval,?,?,'admin2','Y')";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, memberkey);
			ps.setString(2, blackRePort);
			success = ps.executeUpdate();
			System.out.println("블랙리스트 추가성공 여부: " + success);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return success;
	}

	

	public ArrayList<AdminDTO> adminSearch() {
		System.out.println("관리자 조회 DAO");
		sql = "SELECT memberKey, name, email, gender, authority FROM users WHERE authority = ? ";
		ArrayList<AdminDTO> list = new ArrayList<AdminDTO>();
		try {
			ps = conn.prepareStatement(sql);
			/* ps.setString(1, "판매자"); */
			ps.setString(1, "일반");
			rs = ps.executeQuery();
			while (rs.next()) {
				dto = new AdminDTO();
				dto.setMemberkey(rs.getString("memberKey"));
				dto.setName(rs.getString("name"));
				dto.setEmail(rs.getString("email"));
				dto.setGender(rs.getString("gender"));
				dto.setAuthority(rs.getString("authority"));
				System.out.println("어드민 관리자 조회: " + dto.getMemberkey()+"/"+dto.getName()+"/"+dto.getEmail()+"/"+dto.getGender()+"/"+dto.getAuthority());
				list.add(dto);
			}
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
		
			return list;
	}

	public HashMap<String, Object> adminDetail(String memberkey, String sessionId) {
		System.out.println("어드민에서 관리자 상세보기 DAO연결:" +memberkey+"/로그인한 관리자: " + sessionId );
		HashMap<String,Object> map = new HashMap<String,Object>();
		sql = "SELECT memberKey,name,email,address,authority FROM users WHERE memberKey = ?";
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1, memberkey);
			rs = ps.executeQuery();
			if(rs.next()) {
				dto = new AdminDTO();
				dto.setMemberkey(rs.getString("memberKey"));
				dto.setName(rs.getString("name"));
				dto.setEmail(rs.getString("email"));
				dto.setAddress(rs.getString("address"));
				dto.setAuthority(rs.getString("authority"));
				System.out.println("관리자  상세 조회: " + dto.getMemberkey()+"/"+dto.getName()+"/"+dto.getEmail()+"/"+dto.getAddress()+"/"+dto.getAuthority());
			}
			sql = "SELECT * FROM users WHERE authority = '최고관리자' AND memberkey = ? ";
			success = 0;
			try {
				ps = conn.prepareStatement(sql);
				ps.setString(1, sessionId);
				rs = ps.executeQuery();
				if(!rs.next()) {
					System.out.println("관리자 권한이 없습니다.");
					
				}
				else {
					System.out.println("관리자 권한 확인완료");
					success = 1;
				}
			} catch (SQLException e) {
				
				e.printStackTrace();
			}
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
		map.put("suc", success);
		map.put("dto", dto);
		return map;
		
	}

	public HashMap<String, Object> authorityDelete(String memberkey, String sessionId) {
		System.out.println("어드민 관리자 삭제값 조회할 id: " + memberkey+"/로그인한 관리자: " + sessionId );
		HashMap<String,Object> map = new HashMap<String,Object>();
		sql = "SELECT * FROM users WHERE authority = '최고관리자' AND memberkey = ? ";
		success = 0;
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, sessionId);
			rs = ps.executeQuery();
			if(!rs.next()) {
				System.out.println("관리자 권한이 없습니다.");
			}
			else {
				System.out.println("관리자 권한 확인완료");
				success = 1;
			}
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
		map.put("suc", success);
		
		return map;
		
	}
	


}

package com.go.main.admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;


import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class AdminDAO {

	Connection conn = null;
	ResultSet rs = null;
	PreparedStatement ps = null;

	AdminDTO dto = null;
	ArrayList<AdminDTO> list = null;
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
		switch(adminSearchSelect) {
		case "memberkey":
			sql = "SELECT u.memberKey , u.name , bb.statuscheck, ou.ownerno, u.deletecheck FROM users u LEFT OUTER JOIN blackList bb ON u.memberKey = bb.memberKey LEFT OUTER JOIN ownerUser ou ON u.memberKey=ou.memberKey WHERE u.memberkey LIKE ?";
			break;
		case "name":
			sql = "SELECT u.memberKey , u.name , bb.statuscheck, ou.ownerno, u.deletecheck FROM users u LEFT OUTER JOIN blackList bb ON u.memberKey = bb.memberKey LEFT OUTER JOIN ownerUser ou ON u.memberKey=ou.memberKey WHERE u.name LIKE ?";
			break;
		case "email":
			sql = "SELECT u.memberKey , u.name , bb.statuscheck, ou.ownerno, u.deletecheck FROM users u LEFT OUTER JOIN blackList bb ON u.memberKey = bb.memberKey LEFT OUTER JOIN ownerUser ou ON u.memberKey=ou.memberKey WHERE u.email LIKE ?";
			break;
		}
		
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
		sql = "SELECT memberKey, name, email, gender, authority FROM users WHERE authority = ? OR authority=? ";
		ArrayList<AdminDTO> list = new ArrayList<AdminDTO>();
		try {
			ps = conn.prepareStatement(sql);
			/* ps.setString(1, "판매자"); */
			ps.setString(1, "일반");
			ps.setString(2, "부관리자");
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
		//임시 관리자 아이디
		//String sessionId2 = "sunwoolee1";
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
			success = 1;
			try {
				ps = conn.prepareStatement(sql);
				ps.setString(1, sessionId);
				rs = ps.executeQuery();
				if(!rs.next()) {
					System.out.println("관리자 권한이 없습니다.");
				}
				else {
					System.out.println("관리자 권한 확인완료");
					success = 0;
				}
			} catch (SQLException e) {
				
				e.printStackTrace();
			}
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
		map.put("suc", success);
		map.put("dto", dto);
		map.put("session", sessionId);
		return map;
		
	}

	public HashMap<String, Object> authorityDelete(String memberkey, String sessionId) {
		System.out.println("어드민 관리자 삭제값 조회할 id: " + memberkey+"/로그인한 관리자: " + sessionId );
		HashMap<String,Object> map = new HashMap<String,Object>();
		//String sessionId2 = "sunwoolee1";
		int delauthority =0;
		int delcheck = 0;
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
				success = 0;
				
					sql = "SELECT authority from users where memberkey= ?";
		
						ps = conn.prepareStatement(sql);
						ps.setString(1, memberkey);
						rs=ps.executeQuery();
						if(rs.next()) {
							String authority = rs.getString("authority");
							if(authority.equals("일반")) {
								delauthority = 0;
							}
							else if(authority.equals("부관리자")) {
								delauthority = 1;
								sql="UPDATE users set authority = '일반' where memberkey=?";
								ps = conn.prepareStatement(sql);
								ps.setString(1, memberkey);
								delcheck = ps.executeUpdate();
								if(delcheck==1) {System.out.println(memberkey+ "가 부관리자->일반회원으로 수정");
							}
				
							}
						}
					
				}
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
		
		
		 
			
	
		
		map.put("suc", success);
		map.put("memberkey", memberkey);
		map.put("delauthority", delauthority);
		map.put("delcheck", delcheck);
		return map;
		
	}

	public ArrayList<AdminDTO> adminSelect(String adminSearchSelect, String adminSelect) {
		System.out.println("관리자 임명 데이터 dao전달확인: "+"검색메뉴: "+adminSearchSelect+"/"+"검색내용: "+adminSelect);
		list = new ArrayList<AdminDTO>();
		
		switch(adminSearchSelect) {
		case "memberkey":
			sql = "SELECT memberkey, name, email, gender from users WHERE authority = '일반' AND memberkey LIKE ? ";
			break;
		case "name":
			sql = "SELECT memberkey, name, email, gender from users WHERE authority = '일반' AND name LIKE ? ";
			break;
		case "email":
			sql = "SELECT memberkey, name, email, gender from users WHERE authority = '일반' AND email LIKE ? ";
			break;
		}
		
		//목록조회
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, "%" + adminSelect + "%");
			rs = ps.executeQuery();
			//목록받기
			while(rs.next()) {
				dto = new AdminDTO();
				dto.setMemberkey(rs.getString("memberkey"));
				dto.setName(rs.getString("name"));
				dto.setEmail(rs.getString("email"));
				dto.setGender(rs.getString("gender"));
				System.out.println("어드민 셀렉트 dao 받아온 값 출력: "+ dto.getMemberkey()+"/"+dto.getName()+"/"+dto.getEmail()+"/"+dto.getGender());
				list.add(dto);
			}
			//최고 관리자가 아닐때

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
		
	}
	

	 

	public int memberAppoint(String sessionId, String memberKey) {
		System.out.println("임명 세션/ memberkey값 dao도착 확인: "+sessionId+"/"+ memberKey);
		//최고관리자가 아니라면 x 1값을 반환하여 권한없음 표시, 최고관리자라면 내용 진행 0반환
 		success=0;
		sql = "SELECT * FROM users WHERE authority='최고관리자' AND memberkey = ? "; 
		//관리자 구분값
		//임의의 최고관리자
		String session2 = "sunwoolee1";
		try {
			ps = conn.prepareStatement(sql); 
			ps.setString(1, session2); 
			rs = ps.executeQuery(); 
			
			//최고 관리자일때 
			if(rs.next()) {
				
				System.out.println("최고관리자 회원입니다.");
				sql = "UPDATE users SET authority = '부관리자' WHERE memberkey= ? ";
				ps = conn.prepareStatement(sql); 
				ps.setString(1, memberKey);
				success=ps.executeUpdate();
				if(success>0) {
				System.out.println(memberKey + "일반 회원 -> 부관리자");
				}
				success=0;
			}
			else if(!rs.next()) {
				success=1;
			}
			
			
		}
		
		
		
		catch (SQLException e) { 
		e.printStackTrace(); 
		}
		return success;
	}
	//카페정보
	public ArrayList<AdminDTO> adminCafeSearch(String cafeSearchSelect, String adminCafeSearch) {
		System.out.println("어드민 카페정보 검색 dao연결 확인: " +cafeSearchSelect +" 에서  "+adminCafeSearch +"검색");
		list = new ArrayList<AdminDTO>();
		switch(cafeSearchSelect) {
		case "memberkey":
			sql = "SELECT u.memberkey, u.name, c.cafeName, c.cafeDel FROM users u Inner JOIN ownerUser ou ON u.memberkey = ou.memberkey LEFT OUTER JOIN  cafeInfo c ON ou.ownerNo=c.ownerNo WHERE u.memberkey LIKE ? AND ou.ownerNo is not null";
			break;
		case "email":
			sql = "SELECT u.memberkey, u.name, c.cafeName, c.cafeDel FROM users u Inner JOIN ownerUser ou ON u.memberkey = ou.memberkey LEFT OUTER JOIN  cafeInfo c ON ou.ownerNo=c.ownerNo WHERE u.email LIKE ? AND ou.ownerNo is not null";
			break;
		case "cafeName":
			sql = "SELECT u.memberkey, u.name, c.cafeName, c.cafeDel FROM users u Inner JOIN ownerUser ou ON u.memberkey = ou.memberkey LEFT OUTER JOIN  cafeInfo c ON ou.ownerNo=c.ownerNo WHERE c.cafeName LIKE ? AND ou.ownerNo is not null";
			break;
		case "cafeNo":
			sql = "SELECT u.memberkey, u.name, c.cafeName, c.cafeDel FROM users u Inner JOIN ownerUser ou ON u.memberkey = ou.memberkey LEFT OUTER JOIN  cafeInfo c ON ou.ownerNo=c.ownerNo WHERE c.cafeNo LIKE ? AND ou.ownerNo is not null";
			break;
		}
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, "%"+ adminCafeSearch+"%");
			rs= ps.executeQuery();
			
			while(rs.next()) {
				System.out.println("불러오기 성공");
				dto = new AdminDTO();
				dto.setMemberkey(rs.getString("memberKey"));
				dto.setName(rs.getString("name"));
				dto.setCafeName(rs.getString("cafeName"));
				dto.setCafeDel(rs.getString("cafeDel"));
				System.out.println("리스트에 저장되는 값: " +dto.getMemberkey()+"/"+dto.getName() +"/"+ dto.getCafeName()+"/"+ dto.getCafeDel());
				list.add(dto);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return list;
	}

	public AdminDTO adminCafeDetail(String memberKey) {
		System.out.println("상세조회할 카페 dao 연결 확인: " + memberKey);
		sql="SELECT u.name, u.email, c.cafeName, c.ownerNo, c.cafeLocation, c.cafeDel, cg.cafeTotalTable, cb.blindReason FROM users u"+
		" INNER JOIN ownerUser ou ON u.memberkey = ou.memberkey"+
		" LEFT OUTER JOIN  cafeInfo c ON ou.ownerNo=c.ownerNo"+ 
		" LEFT OUTER JOIN congestion cg ON c.cafeKey = cg.cafeKey"+
		" LEFT OUTER JOIN cafeBlind cb ON c.cafeKey = cb.cafeKey WHERE u.memberkey = ? ";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, memberKey);
			rs= ps.executeQuery();
			if(rs.next()) {
				System.out.println("카페 상세조회 성공");
				dto = new AdminDTO();
				dto.setCafeName(rs.getString("cafeName"));
				dto.setEmail(rs.getString("email"));
				dto.setName(rs.getString("name"));
				dto.setOwnerNo(rs.getString("ownerNo"));
				dto.setCafeLocation(rs.getString("cafeLocation"));
				dto.setCafeTotalTable(rs.getInt("cafeTotalTable"));
				dto.setCafeDel(rs.getString("cafeDel"));
				dto.setBlindReason(rs.getString("blindReason"));
				System.out.println("어드민 카페 상세 dto 값 입력 확인: " +dto.getCafeName()+"/"+ dto.getMemberkey()+"/"+ dto.getEmail()+"/"+ dto.getCafeLocation() +"/"+dto.getCafeTotalTable() +"/"+dto.getCafeDel()+"/"+dto.getOwnerNo()+"/"+dto.getBlindReason());
			}
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
		
		return dto;
	}

	public void cafeBlind(String ownerNo) {
		System.out.println("블라인드 추가할 사업자 키 dao 연결확인: "+ownerNo);
		sql="";
		
	}


}

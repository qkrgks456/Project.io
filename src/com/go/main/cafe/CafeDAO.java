package com.go.main.cafe;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class CafeDAO {

	public Connection conn = null;
	public ResultSet rs = null;
	public PreparedStatement ps = null;
	CafeDTO dto = null;

	public CafeDAO() {
		try {
			// DB접속
			Context ctx = new InitialContext();
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Oracle");
			conn = ds.getConnection();
			System.out.println("DB체크 : " + conn);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 자원정리
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

	public int cafeInput(CafeDTO dto, String sessionId) {
		int suc = 0;
		HashMap<String, Object> businessfilenames = dto.getBusinessfilenames();
		ArrayList<HashMap<String, Object>> maparr = dto.getMaparr();
		try {

			String sql = "SELECT cafeKey FROM cafeInfo WHERE cafeKey=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, sessionId);
			rs = ps.executeQuery();
			// 회원아이디가 카페정보에 없다면
			if (!rs.next()) {
				sql = "INSERT INTO ownerUser(ownerNo,memberKey) VALUES(?,?)";
				ps = conn.prepareStatement(sql);
				ps.setString(1, dto.getOnnerNo());
				ps.setString(2, sessionId);
				suc = ps.executeUpdate();
				sql = "INSERT INTO image(fileIdx,division,oriFileName,newFileName) VALUES(image_seq.NEXTVAL,?,?,?)";
				ps = conn.prepareStatement(sql);
				ps.setString(1, dto.getOnnerNo());
				ps.setString(2, (String) businessfilenames.get("oriFileName"));
				ps.setString(3, (String) businessfilenames.get("newFileName"));
				suc = ps.executeUpdate();
				if (suc > 0) {
					sql = "INSERT INTO cafeInfo"
							+ "(cafeKey,ownerNo,cafeName,cafeLocation,cafeAddress,cafePhone,cafeDetail,cafeTime"
							+ ",parkingCheck,petCheck,childCheck,rooftopCheck,groupCheck,cafeDel,openCheck,conFusion)"
							+ "VALUES" + "(?,?,?,?,?,?,?,?,?,?,?,?,?,'N','Y','보통')";
					ps = conn.prepareStatement(sql);
					ps.setString(1, sessionId);
					ps.setString(2, dto.getOnnerNo());
					ps.setString(3, dto.getCafeName());
					ps.setString(4, dto.getCafeLocation());
					ps.setString(5, dto.getCafeAddress());
					ps.setString(6, dto.getCafePhone());
					ps.setString(7, dto.getCafeDetail());
					ps.setString(8, dto.getCafeTime());
					ps.setString(9, dto.getParkingCheck());
					ps.setString(10, dto.getPetCheck());
					ps.setString(11, dto.getChildCheck());
					ps.setString(12, dto.getRooftopCheck());
					ps.setString(13, dto.getGroupCheck());
					suc = ps.executeUpdate();
					for (HashMap<String, Object> map : maparr) {
						sql = "INSERT INTO image(fileIdx,division,oriFileName,newFileName) VALUES(image_seq.NEXTVAL,?,?,?)";
						ps = conn.prepareStatement(sql);
						ps.setString(1, sessionId);
						ps.setString(2, (String) map.get("oriFileName"));
						ps.setString(3, (String) map.get("newFileName"));
						suc = ps.executeUpdate();
					}
				}
			} else { // 회원아이디가 카페정보에 있다면
				suc = 0;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			resClose();
		}
		return suc;
	}

	public boolean ownerCheck(String ownerNo) {
		String sql = "SELECT ownerNo FROM cafeInfo WHERE ownerNo = ?";
		boolean ownerCheck = false;
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, ownerNo);
			rs = ps.executeQuery();
			ownerCheck = rs.next();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			resClose();
		}
		return ownerCheck;
	}

	public CafeDTO cafeInfoMyPage(String sessionId) {
		ArrayList<HashMap<String, Object>> maparr = new ArrayList<HashMap<String, Object>>();
		HashMap<String, Object> map = null;
		System.out.println("안녕");
		try {
			dto = new CafeDTO();
			String sql = "SELECT cafeName,cafeLocation,cafeAddress,cafePhone,cafeDetail,cafeTime"
					+ ",parkingCheck,petCheck,childCheck,rooftopCheck,groupCheck FROM cafeInfo WHERE cafeDel='N' AND openCheck='Y' AND cafeKey = ?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, sessionId);
			rs = ps.executeQuery();
			if (rs.next()) {
				dto.setCafeName(rs.getString("cafeName"));
				dto.setCafeLocation(rs.getString("cafeLocation"));
				dto.setCafeAddress(rs.getString("cafeAddress"));
				dto.setCafePhone(rs.getString("cafePhone"));
				dto.setCafeDetail(rs.getString("cafeDetail"));
				dto.setCafeTime(rs.getString("cafeTime"));
				dto.setParkingCheck(rs.getString("parkingCheck"));
				dto.setPetCheck(rs.getString("petCheck"));
				dto.setChildCheck(rs.getString("childCheck"));
				dto.setRooftopCheck(rs.getString("rooftopCheck"));
				dto.setGroupCheck(rs.getString("groupCheck"));
			}
			sql = "SELECT newFileName,fileIdx FROM image WHERE division = ?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, sessionId);
			rs = ps.executeQuery();
			while (rs.next()) {
				map = new HashMap<String, Object>();
				map.put("newFileName", rs.getString("newFileName"));
				map.put("fileIdx", rs.getString("fileIdx"));
				if (map.get("fileIdx") != null) {
					maparr.add(map);
				}
			}
			if (map != null) {
				dto.setMaparr(maparr);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			resClose();
		}
		System.out.println("maparr 있냐 : " + maparr);
		return dto;
	}

	public int update(CafeDTO dto, String sessionId) {
		int suc = 0;
		ArrayList<HashMap<String, Object>> maparr = dto.getMaparr();
		try {
			String sql = "UPDATE cafeinfo SET cafeName=?,cafeAddress=?,cafePhone=?,cafeTime=?,cafeDetail=?"
					+ ",cafeLocation=?,parkingCheck=?,petCheck=?,childCheck=?,rooftopCheck=?,groupCheck=? WHERE cafeKey=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, dto.getCafeName());
			ps.setString(2, dto.getCafeAddress());
			ps.setString(3, dto.getCafePhone());
			ps.setString(4, dto.getCafeTime());
			ps.setString(5, dto.getCafeDetail());
			ps.setString(6, dto.getCafeLocation());
			ps.setString(7, dto.getParkingCheck());
			ps.setString(8, dto.getPetCheck());
			ps.setString(9, dto.getChildCheck());
			ps.setString(10, dto.getRooftopCheck());
			ps.setString(11, dto.getGroupCheck());
			ps.setString(12, sessionId);
			suc = ps.executeUpdate();
			if (suc > 0) {
				if (maparr != null) {
					for (HashMap<String, Object> map : maparr) {
						sql = "INSERT INTO image(fileIdx,division,oriFileName,newFileName) VALUES(image_seq.NEXTVAL,?,?,?)";
						ps = conn.prepareStatement(sql);
						ps.setString(1, sessionId);
						ps.setString(2, (String) map.get("oriFileName"));
						ps.setString(3, (String) map.get("newFileName"));
						ps.executeUpdate();
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			resClose();
		}
		return suc;
	}

	public int imgdel(CafeDTO dto) {
		int suc = 0;
		ArrayList<String> delFileIdx = dto.getDelFileIdx();
		ArrayList<String> newFileNames = new ArrayList<String>();
		try {
			String sql = "SELECT newFileName FROM image WHERE fileIdx = ?";
			for (String fileIdx : delFileIdx) {
				ps = conn.prepareStatement(sql);
				ps.setString(1, fileIdx);
				rs = ps.executeQuery();
				if (rs.next()) {
					newFileNames.add(rs.getString("newFileName"));
				}
			}
			dto.setNewFileNames(newFileNames);
			if (dto.getDelFileIdx() != null) {
				sql = "DELETE FROM image WHERE fileIdx=?";
				for (String fileIdx : delFileIdx) {
					ps = conn.prepareStatement(sql);
					ps.setInt(1, Integer.parseInt(fileIdx));
					suc = ps.executeUpdate();
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			resClose();
		}
		return suc;
	}

	public boolean cafeInputCheck(String loginId) {
		boolean check = false;
		try {
			String sql = "SELECT cafeKey FROM cafeInfo WHERE (cafeDel='N' OR cafeDel='Y') AND cafeKey=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, loginId);
			rs = ps.executeQuery();
			check = rs.next();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			resClose();
		}
		System.out.println(check);
		return check;

	}

	public boolean businessCheck(String businessUserId, String businessUserPw, String businessNumber) {
		boolean check = false;
		String sql = "SELECT u.memberKey,u.pw,o.ownerNo FROM " + "ownerUser o LEFT OUTER JOIN users u  "
				+ "ON u.memberKey=o.memberKey WHERE u.memberKey=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, businessUserId);
			rs = ps.executeQuery();
			if (rs.next()) {
				if (rs.getString("memberKey").equals(businessUserId) && rs.getString("ownerNo").equals(businessNumber)
						&& rs.getString("pw").equals(businessUserPw)) {
					check = true;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			resClose();
		}

		return check;
	}

	public int cafeDel(String cafeKey) {
		int suc = 0;
		try {
			String sql = "UPDATE cafeinfo SET cafeDel='Y' WHERE cafeKey=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, cafeKey);
			suc = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			resClose();
		}
		return suc;
	}

	public boolean cafeExist(String loginId) {
		boolean check = false;
		try {
			String sql = "SELECT cafeKey FROM cafeInfo WHERE cafeDel='N' AND cafeKey=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, loginId);
			rs = ps.executeQuery();
			check = rs.next();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			resClose();
		}

		return check;
	}

	public HashMap<String, Object> cafeList(int page) {
		ArrayList<CafeDTO> list = new ArrayList<CafeDTO>();
		HashMap<String, Object> map = new HashMap<String, Object>();
		// 한블럭당 페이지 갯수
		int pageLength = 5;
		// 블럭 인덱스
		int currentBlock = page % pageLength == 0 ? page / pageLength : (page / pageLength) + 1;
		// 시작페이지
		int startPage = (currentBlock - 1) * pageLength + 1;
		// 끝페이지
		int endPage = startPage + pageLength - 1;
		System.out.println("시작 페이지 : " + startPage + " / 끝 페이지 : " + endPage);
		// 노출할 데이터 갯수
		int pagePerCnt = 8;
		try {
			String sql = "SELECT c.cafeKey,c.cafeName,c.cafeLocation,c.cafeDetail,c.confusion,i.newfilename "
					+ "FROM (SELECT division,newFileName FROM image WHERE ROWID IN "
					+ "(SELECT MIN(ROWID) FROM image GROUP BY division)) i "
					+ "LEFT OUTER JOIN cafeInfo c ON i.division= c.cafeKey "
					+ "WHERE c.cafeDel='N' AND c.openCheck='Y'";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				dto = new CafeDTO();
				dto.setCafeKey(rs.getString("cafeKey"));
				dto.setCafeName(rs.getString("cafeName"));
				dto.setCafeLocation(rs.getString("cafeLocation"));
				dto.setCafeDetail(rs.getString("cafeDetail"));
				dto.setConfusion(rs.getString("confusion"));
				dto.setNewFileName(rs.getString("newfilename"));
				list.add(dto);
			}
			int total = totalCount(); // 총 게시글 수 가져옵시다
			// 총 게시글 수에 나올 페이지수 나눠서 짝수면 나눠주고 홀수면 +1
			int totalPages = total % pagePerCnt == 0 ? total / pagePerCnt : (total / pagePerCnt) + 1;
			if (totalPages == 0) {
				totalPages = 1;
			}
			// 끝지점을 맨 마지막 페이지로 지정
			if (endPage > totalPages) {
				endPage = totalPages;
			}
			map.put("list", list);
			map.put("totalPage", totalPages);
			map.put("currPage", page);
			map.put("pageLength", pageLength);
			map.put("startPage", startPage);
			map.put("endPage", endPage);
			System.out.println("총 갯수" + total);
			System.out.println("토탈 페이지" + totalPages);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			resClose();
		}
		return map;
	}

	public int totalCount() throws SQLException {
		String sql = "SELECT COUNT(cafeKey) "
				+ "FROM (SELECT division,newFileName FROM image WHERE ROWID IN "
				+ "(SELECT MIN(ROWID) FROM image GROUP BY division)) i "
				+ "LEFT OUTER JOIN cafeInfo c ON i.division= c.cafeKey "
				+ "WHERE c.cafeDel='N' AND c.openCheck='Y'";
		ps = conn.prepareStatement(sql);
		rs = ps.executeQuery();
		int total = 0;
		if (rs.next()) {
			total = rs.getInt(1);
		}
		return total;
	}

}

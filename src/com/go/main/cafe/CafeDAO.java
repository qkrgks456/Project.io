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
		System.out.println("닫힘");
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
							+ ",parkingCheck,petCheck,childCheck,rooftopCheck,groupCheck,cafeDel,openCheck,conFusion,bHit,cafeNum)"
							+ "VALUES" + "(?,?,?,?,?,?,?,?,?,?,?,?,?,'N','Y','보통',0,cafe_seq.NEXTVAL)";
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
			sql = "SELECT newFileName,fileIdx FROM image WHERE division = ? ORDER BY fileIdx";
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
			String sql = "SELECT cafeKey FROM cafeInfo WHERE openCheck='Y' AND cafeDel='N' AND cafeKey=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, loginId);
			rs = ps.executeQuery();
			check = rs.next();
		} catch (Exception e) {
			e.printStackTrace();
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
		int end = page * pagePerCnt;
		int start = (end - pagePerCnt);
		System.out.println(start);
		System.out.println(end);
		try {
			String sql = "SELECT b.cafeKey,b.newfilename,b.cafeName,b.cafeNum,b.cafeLocation,"
					+ "b.cafeDetail,b.confusion,b.bHit,c.cafeTotalTable,c.cafeCurrentTable FROM"
					+ "(SELECT cafeKey,newfilename,cafeName,cafeNum,cafeLocation,cafeDetail,confusion,bHit FROM"
					+ "(SELECT i.newfilename,c.cafeName,c.cafeNum,c.cafeKey,c.cafeLocation,c.cafeDetail,c.confusion,c.bHit FROM"
					+ "(SELECT division,newFileName FROM image WHERE ROWID IN (SELECT MIN(ROWID) FROM image GROUP BY division)) i "
					+ "LEFT OUTER JOIN cafeInfo c ON i.division= c.cafeKey WHERE c.cafeDel='N' AND c.openCheck='Y')"
					+ "ORDER BY cafeNum DESC OFFSET (?) ROWS FETCH FIRST (?) ROWS ONLY) b "
					+ "LEFT OUTER JOIN congestion c ON b.cafeKey = c.cafeKey";
//			String sql = "SELECT cafeKey,newfilename,cafeName,cafeNum,cafeLocation,cafeDetail,confusion,bHit "
//					+ "FROM (SELECT i.newfilename,c.cafeName,c.cafeNum,c.cafeKey,c.cafeLocation,c.cafeDetail,c.confusion,c.bHit "
//					+ "FROM (SELECT division,newFileName FROM image "
//					+ "WHERE ROWID IN (SELECT MIN(ROWID) FROM image GROUP BY division)) i "
//					+ "LEFT OUTER JOIN cafeInfo c ON i.division= c.cafeKey WHERE c.cafeDel='N' AND c.openCheck='Y')"
//					+ "ORDER BY cafeNum DESC OFFSET (?) ROWS FETCH FIRST (?) ROWS ONLY";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, start);
			ps.setInt(2, end);
			rs = ps.executeQuery();
			while (rs.next()) {
			dto = new CafeDTO();
				dto.setCafeKey(rs.getString("cafeKey"));
				dto.setCafeName(rs.getString("cafeName"));
				dto.setCafeLocation(rs.getString("cafeLocation"));
				dto.setCafeDetail(rs.getString("cafeDetail"));
				dto.setConfusion(rs.getString("confusion"));
				dto.setNewFileName(rs.getString("newfilename"));
				dto.setbHit(rs.getInt("bHit"));
				dto.setCafeTotalTable(rs.getInt("cafeTotalTable"));
				dto.setCafeCurrentTable(rs.getInt("cafeCurrentTable"));
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
		} 
		return map;
	}

	public HashMap<String, Object> cafeDetail(String cafeKey, int page, String sessionId) {
		ArrayList<CafeDTO> commentList = new ArrayList<CafeDTO>();
		ArrayList<String> fileList = new ArrayList<String>();
		HashMap<String, Object> map = new HashMap<String, Object>();
		int cafePage = 0;
		try {
			// 카페정보가져오기
			String sql = "SELECT cafeKey,cafeName,cafeLocation,cafeDetail,cafeAddress,cafeTime,cafePhone"
					+ ",parkingCheck,petCheck,childCheck,rooftopCheck,groupCheck"
					+ ",confusion,bHit FROM cafeInfo WHERE cafeDel='N' AND openCheck='Y' AND cafeKey=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, cafeKey);
			rs = ps.executeQuery();
			if (rs.next()) {
				map.put("cafeKey", rs.getString("cafeKey"));
				map.put("cafeName", rs.getString("cafeName"));
				map.put("cafeLocation", rs.getString("cafeLocation"));
				map.put("cafeDetail", rs.getString("cafeDetail"));
				map.put("cafeAddress", rs.getString("cafeAddress"));
				map.put("cafeTime", rs.getString("cafeTime"));
				map.put("cafePhone", rs.getString("cafePhone"));
				map.put("parkingCheck", rs.getString("parkingCheck"));
				map.put("petCheck", rs.getString("petCheck"));
				map.put("childCheck", rs.getString("childCheck"));
				map.put("rooftopCheck", rs.getString("rooftopCheck"));
				map.put("groupCheck", rs.getString("groupCheck"));
				map.put("confusion", rs.getString("confusion"));
				map.put("bHit", rs.getInt("bHit"));
			}
			// 좋아요 개수
			sql = "SELECT COUNT(likeNo) FROM good WHERE division=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, cafeKey);
			rs = ps.executeQuery();
			if (rs.next()) {
				map.put("goodCount", rs.getInt(1));
			}
			// 좋아요 눌렀는지 안눌렀는지 상태 체크
			sql = "SELECT likeNo FROM good WHERE memberKey=? AND division=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, sessionId);
			ps.setString(2, cafeKey);
			rs = ps.executeQuery();
			if (rs.next()) {
				map.put("goodCheck", false);
			} else {
				map.put("goodCheck", true);
			}
			// 댓글 갯수
			sql = "SELECT COUNT(commentNo) FROM cm WHERE division=? AND commentDel='N'";
			ps = conn.prepareStatement(sql);
			ps.setString(1, cafeKey);
			rs = ps.executeQuery();
			if (rs.next()) {
				map.put("commentCount", rs.getInt(1));
			}
			// 메인 이미지 가져오기
			sql = "SELECT newFileName FROM image WHERE "
					+ "fileIdx = (SELECT MIN(fileIdx) FROM image WHERE division=?)";
			ps = conn.prepareStatement(sql);
			ps.setString(1, cafeKey);
			rs = ps.executeQuery();
			if (rs.next()) {
				map.put("mainImage", rs.getString(1));
			}
			// 이미지 가져오기
			sql = "SELECT newFileName FROM image WHERE division=? ORDER BY fileIdx";
			ps = conn.prepareStatement(sql);
			ps.setString(1, cafeKey);
			rs = ps.executeQuery();
			while (rs.next()) {
				fileList.add(rs.getString(1));
			}
			map.put("fileList", fileList);
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
			int end = page * pagePerCnt;
			int start = (end - pagePerCnt) + 1;
			// 댓글 가져오기
			sql = "SELECT commentNo,cm_content,memberKey FROM "
					+ "(SELECT ROW_NUMBER() OVER(ORDER BY commentNo) AS rnum,commentNo,cm_content,memberKey FROM cm WHERE division=? AND commentDel='N')"
					+ "WHERE rnum BETWEEN ? AND ?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, cafeKey);
			ps.setInt(2, start);
			ps.setInt(3, end);
			rs = ps.executeQuery();
			while (rs.next()) {
				dto = new CafeDTO();
				dto.setCommentNo(rs.getString("commentNo"));
				dto.setCm_content(rs.getString("cm_content"));
				dto.setMemberKey(rs.getString("memberKey"));
				commentList.add(dto);
			}
			int total = totalComment(cafeKey); // 총 댓글 수 가져옵시다
			// 총 게시글 수에 나올 페이지수 나눠서 짝수면 나눠주고 홀수면 +1
			int totalPages = total % pagePerCnt == 0 ? total / pagePerCnt : (total / pagePerCnt) + 1;
			if (totalPages == 0) {
				totalPages = 1;
			}
			// 끝지점을 맨 마지막 페이지로 지정
			if (endPage > totalPages) {
				endPage = totalPages;
			}
			// 디테일에서 리스트로 돌아갈시 페이지 반환
			int cafePages = 1;
			// 노출할 데이터 갯수
			int cafePagesPerCnts = 8;
			while (true) {
				// 데이터의 시작과 끝
				int cafeEnds = cafePages * cafePagesPerCnts;
				int cafeStarts = (cafeEnds - cafePagesPerCnts);
				sql = "SELECT cafeKey FROM"
						+ "(SELECT cafeKey FROM cafeInfo ORDER BY cafeNum DESC OFFSET ? ROWS FETCH FIRST ? ROWS ONLY)"
						+ "WHERE cafeKey=?";
				ps = conn.prepareStatement(sql);
				ps.setInt(1, cafeStarts);
				ps.setInt(2, cafeEnds);
				ps.setString(3, cafeKey);
				rs = ps.executeQuery();
				if (rs.next()) {
					break;
				} else {
					cafePages++;
				}
			}
			map.put("cafePages", cafePages);
			map.put("commentList", commentList);
			map.put("totalPage", totalPages);
			map.put("currPage", page);
			map.put("pageLength", pageLength);
			map.put("startPage", startPage);
			map.put("endPage", endPage);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}

	// 댓글 총개수
	private int totalComment(String cafeKey) throws SQLException {
		String sql = "SELECT COUNT(commentNo) FROM cm WHERE division = ? AND commentDel='N'";
		ps = conn.prepareStatement(sql);
		ps.setString(1, cafeKey);
		rs = ps.executeQuery();
		int total = 0;
		if (rs.next()) {
			total = rs.getInt(1);
		}
		return total;
	}

	// 카페정보 총 갯수
	public int totalCount() throws SQLException {
		String sql = "SELECT COUNT(cafeKey) FROM cafeInfo";
		ps = conn.prepareStatement(sql);
		rs = ps.executeQuery();
		int total = 0;
		if (rs.next()) {
			total = rs.getInt(1);
		}
		return total;
	}

	// 조회수
	public int upHit(String cafeKey) {

		String sql = "UPDATE cafeInfo SET bHit = bHit+1 WHERE cafeKey=?";
		int success = 0;
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, cafeKey);
			success = ps.executeUpdate();
			System.out.println("조회수 올리기 성공 : " + success);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return success;
	}

	// 상품리스트 담기
	public HashMap<String, Object> productList(HashMap<String, Object> map, String cafeKey) {
		ArrayList<CafeDTO> productList = new ArrayList<CafeDTO>();
		ArrayList<CafeDTO> sellProductList = new ArrayList<CafeDTO>();
		try {
			String sql = "SELECT p.productName,p.price,p.explanation,i.newfilename "
					+ "FROM product p LEFT OUTER JOIN image i ON p.productID = i.division "
					+ "WHERE delCheck='N' AND selCheck='N' AND p.cafeKey=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, cafeKey);
			rs = ps.executeQuery();
			while (rs.next()) {
				dto = new CafeDTO();
				dto.setProductName(rs.getString("productName"));
				dto.setPrice(rs.getInt("price"));
				dto.setExplanation(rs.getString("explanation"));
				dto.setNewFileName(rs.getString("newfilename"));
				productList.add(dto);
			}
			sql = "SELECT p.productId,p.productName,p.price,p.explanation,i.newfilename "
					+ "FROM product p LEFT OUTER JOIN image i ON p.productID = i.division "
					+ "WHERE delCheck='N' AND selCheck='Y' AND p.cafeKey=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, cafeKey);
			rs = ps.executeQuery();
			while (rs.next()) {
				dto = new CafeDTO();
				dto.setProductId(rs.getInt("productId"));
				dto.setProductName(rs.getString("productName"));
				dto.setPrice(rs.getInt("price"));
				dto.setExplanation(rs.getString("explanation"));
				dto.setNewFileName(rs.getString("newfilename"));
				sellProductList.add(dto);
			}
			map.put("productList", productList);
			map.put("sellProductList", sellProductList);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return map;
	}

	// 혼잡도 좌석 변경
	public HashMap<String, Object> confusionTableChange(String sessionId, int cafeTotalTable, int cafeCurrentTable) {
		int suc = 0;
		HashMap<String, Object> map = new HashMap<String, Object>();
		ArrayList<String> goodMemberKey = new ArrayList<String>();
		String cafeName = "";
		try {
			//카페이름 가져오기
			String sql = "SELECT cafeName FROM cafeInfo WHERE cafeKey=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, sessionId);
			rs = ps.executeQuery();
			if(rs.next()) {
				cafeName = rs.getString("cafeName");
			}
			sql = "SELECT * FROM congestion WHERE cafeKey = ?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, sessionId);
			rs = ps.executeQuery();
			if (rs.next()) {
				sql = "UPDATE congestion SET cafeTotalTable = ?,cafeCurrentTable = ? WHERE cafeKey = ?";
				ps = conn.prepareStatement(sql);
				ps.setInt(1, cafeTotalTable);
				ps.setInt(2, cafeCurrentTable);
				ps.setString(3, sessionId);
				suc = ps.executeUpdate();
			} else {
				sql = "INSERT INTO congestion VALUES(?,?,?)";
				ps = conn.prepareStatement(sql);
				ps.setString(1, sessionId);
				ps.setInt(2, cafeTotalTable);
				ps.setInt(3, cafeCurrentTable);
				suc = ps.executeUpdate();
			}
			if (suc > 0) {
				sql = "SELECT * FROM congestionStandard WHERE cafeKey = ?";
				ps = conn.prepareStatement(sql);
				ps.setString(1, sessionId);
				rs = ps.executeQuery();
				if (rs.next()) {
					int leisurely = rs.getInt("leisurely");
					int normal = rs.getInt("normal");
					int congest = rs.getInt("congest");
					if (cafeCurrentTable >= normal && cafeCurrentTable <= congest) {
						sql = "UPDATE cafeInfo SET confusion=? WHERE cafeKey =?";
						ps = conn.prepareStatement(sql);
						ps.setString(1, "혼잡");
						ps.setString(2, sessionId);
						suc = ps.executeUpdate();
						if (suc > 0) {
							sql = "SELECT u.memberKey FROM good g LEFT OUTER JOIN users u "
									+ "ON u.memberKey=g.memberKey "
									+ "WHERE g.division=? AND u.congestionCheck='Y'";
							ps = conn.prepareStatement(sql);
							ps.setString(1, sessionId);
							rs = ps.executeQuery();
							while (rs.next()) {
								goodMemberKey.add(rs.getString("memberKey"));
							}
							for (String memberKey : goodMemberKey) {
								sql = "INSERT INTO alarm(alarmNum,memberKey,alarmContent,alarmCheck) VALUES(alarm_seq.NEXTVAL,?,?,'N')";
								ps = conn.prepareStatement(sql);
								ps.setString(1, memberKey);
								ps.setString(2, cafeName+"의 혼잡도가 혼잡입니다");
								ps.executeUpdate();
							}
						}
					} else if (cafeCurrentTable >= leisurely && cafeCurrentTable <= normal) {
						sql = "UPDATE cafeInfo SET confusion=? WHERE cafeKey =?";
						ps = conn.prepareStatement(sql);
						ps.setString(1, "보통");
						ps.setString(2, sessionId);
						suc = ps.executeUpdate();
						if (suc > 0) {
							sql = "SELECT u.memberKey FROM good g LEFT OUTER JOIN users u "
									+ "ON u.memberKey=g.memberKey "
									+ "WHERE g.division=? AND u.congestionCheck='Y'";
							ps = conn.prepareStatement(sql);
							ps.setString(1, sessionId);
							rs = ps.executeQuery();
							while (rs.next()) {
								goodMemberKey.add(rs.getString("memberKey"));
							}
							for (String memberKey : goodMemberKey) {
								sql = "INSERT INTO alarm(alarmNum,memberKey,alarmContent,alarmCheck) VALUES(alarm_seq.NEXTVAL,?,?,'N')";
								ps = conn.prepareStatement(sql);
								ps.setString(1, memberKey);
								ps.setString(2, cafeName+"의 혼잡도가 보통입니다");
								ps.executeUpdate();
							}
						}
					} else if (cafeCurrentTable <= leisurely) {
						sql = "UPDATE cafeInfo SET confusion=? WHERE cafeKey =?";
						ps = conn.prepareStatement(sql);
						ps.setString(1, "쾌적");
						ps.setString(2, sessionId);
						suc = ps.executeUpdate();
						if (suc > 0) {
							sql = "SELECT u.memberKey FROM good g LEFT OUTER JOIN users u "
									+ "ON u.memberKey=g.memberKey "
									+ "WHERE g.division=? AND u.congestionCheck='Y'";
							ps = conn.prepareStatement(sql);
							ps.setString(1, sessionId);
							rs = ps.executeQuery();
							while (rs.next()) {
								goodMemberKey.add(rs.getString("memberKey"));
							}
							for (String memberKey : goodMemberKey) {
								sql = "INSERT INTO alarm(alarmNum,memberKey,alarmContent,alarmCheck) VALUES(alarm_seq.NEXTVAL,?,?,'N')";
								ps = conn.prepareStatement(sql);
								ps.setString(1, memberKey);
								ps.setString(2, cafeName+"의 혼잡도가 쾌적입니다");
								ps.executeUpdate();
							}
						}
					}
				}
				if (suc > 0) {
					sql = "SELECT * FROM congestion WHERE cafeKey = ?";
					ps = conn.prepareStatement(sql);
					ps.setString(1, sessionId);
					rs = ps.executeQuery();
					if (rs.next()) {
						map.put("cafeTotalTable", rs.getInt("cafeTotalTable"));
						map.put("cafeCurrentTable", rs.getInt("cafeCurrentTable"));
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			resClose();
		}

		return map;
	}

	// 혼잡도 정보 나타나기
	public HashMap<String, Object> confusionInfo(String sessionId) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		try {
			
			String sql = "SELECT cafeTotalTable,cafeCurrentTable FROM congestion WHERE cafeKey=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, sessionId);
			rs = ps.executeQuery();
			if (rs.next()) {
				map.put("cafeTotalTable", rs.getInt("cafeTotalTable"));
				map.put("cafeCurrentTable", rs.getInt("cafeCurrentTable"));
			}
			sql = "SELECT leisurely,normal,congest from congestionStandard WHERE cafeKey=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, sessionId);
			rs = ps.executeQuery();
			if (rs.next()) {
				map.put("leisurely", rs.getInt("leisurely"));
				map.put("normal", rs.getInt("normal"));
				map.put("congest", rs.getInt("congest"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			resClose();
		}
		return map;
	}

	// 혼잡도 기준 변경
	public HashMap<String, Object> standardChange(String sessionId, int leisurely, int normal, int congest) {
		int suc = 0;
		HashMap<String, Object> map = new HashMap<String, Object>();
		ArrayList<String> goodMemberKey = new ArrayList<String>();
		String cafeName = "";
		try {
			//카페이름 가져오기
			String sql = "SELECT cafeName FROM cafeInfo WHERE cafeKey=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, sessionId);
			rs = ps.executeQuery();
			if(rs.next()) {
				cafeName = rs.getString("cafeName");
			}
			sql = "SELECT * FROM congestionStandard WHERE cafeKey = ?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, sessionId);
			rs = ps.executeQuery();
			if (rs.next()) {
				sql = "UPDATE congestionStandard SET leisurely = ?,normal = ?,congest=? WHERE cafeKey = ?";
				ps = conn.prepareStatement(sql);
				ps.setInt(1, leisurely);
				ps.setInt(2, normal);
				ps.setInt(3, congest);
				ps.setString(4, sessionId);
				suc = ps.executeUpdate();
			} else {
				sql = "INSERT INTO congestionStandard VALUES(?,?,?,?)";
				ps = conn.prepareStatement(sql);
				ps.setString(1, sessionId);
				ps.setInt(2, leisurely);
				ps.setInt(3, normal);
				ps.setInt(4, congest);
				suc = ps.executeUpdate();
			}
			if (suc > 0) {
				sql = "SELECT * FROM congestion WHERE cafeKey = ?";
				ps = conn.prepareStatement(sql);
				ps.setString(1, sessionId);
				rs = ps.executeQuery();
				if (rs.next()) {
					int cafeCurrentTable = rs.getInt("cafeCurrentTable");
					if (cafeCurrentTable >= normal && cafeCurrentTable <= congest) {
						sql = "UPDATE cafeInfo SET confusion=? WHERE cafeKey =?";
						ps = conn.prepareStatement(sql);
						ps.setString(1, "혼잡");
						ps.setString(2, sessionId);
						suc = ps.executeUpdate();
						if (suc > 0) {
							sql = "SELECT u.memberKey FROM good g LEFT OUTER JOIN users u "
									+ "ON u.memberKey=g.memberKey "
									+ "WHERE g.division=? AND u.congestionCheck='Y'";
							ps = conn.prepareStatement(sql);
							ps.setString(1, sessionId);
							rs = ps.executeQuery();
							while (rs.next()) {
								goodMemberKey.add(rs.getString("memberKey"));
							}
							for (String memberKey : goodMemberKey) {
								sql = "INSERT INTO alarm(alarmNum,memberKey,alarmContent,alarmCheck) VALUES(alarm_seq.NEXTVAL,?,?,'N')";
								ps = conn.prepareStatement(sql);
								ps.setString(1, memberKey);
								ps.setString(2, cafeName+"의 혼잡도가 혼잡입니다");
								ps.executeUpdate();
							}
						}
					} else if (cafeCurrentTable >= leisurely && cafeCurrentTable <= normal) {
						sql = "UPDATE cafeInfo SET confusion=? WHERE cafeKey =?";
						ps = conn.prepareStatement(sql);
						ps.setString(1, "보통");
						ps.setString(2, sessionId);
						suc = ps.executeUpdate();
						if (suc > 0) {
							sql = "SELECT u.memberKey FROM good g LEFT OUTER JOIN users u "
									+ "ON u.memberKey=g.memberKey "
									+ "WHERE g.division=? AND u.congestionCheck='Y'";
							ps = conn.prepareStatement(sql);
							ps.setString(1, sessionId);
							rs = ps.executeQuery();
							while (rs.next()) {
								goodMemberKey.add(rs.getString("memberKey"));
							}
							for (String memberKey : goodMemberKey) {
								sql = "INSERT INTO alarm(alarmNum,memberKey,alarmContent,alarmCheck) VALUES(alarm_seq.NEXTVAL,?,?,'N')";
								ps = conn.prepareStatement(sql);
								ps.setString(1, memberKey);
								ps.setString(2, cafeName+"의 혼잡도가 보통입니다");
								ps.executeUpdate();
							}
						}
					} else if (cafeCurrentTable <= leisurely) {
						sql = "UPDATE cafeInfo SET confusion=? WHERE cafeKey =?";
						ps = conn.prepareStatement(sql);
						ps.setString(1, "쾌적");
						ps.setString(2, sessionId);
						suc = ps.executeUpdate();
						if (suc > 0) {
							sql = "SELECT u.memberKey FROM good g LEFT OUTER JOIN users u "
									+ "ON u.memberKey=g.memberKey "
									+ "WHERE g.division=? AND u.congestionCheck='Y'";
							ps = conn.prepareStatement(sql);
							ps.setString(1, sessionId);
							rs = ps.executeQuery();
							while (rs.next()) {
								goodMemberKey.add(rs.getString("memberKey"));
							}
							for (String memberKey : goodMemberKey) {
								sql = "INSERT INTO alarm(alarmNum,memberKey,alarmContent,alarmCheck) VALUES(alarm_seq.NEXTVAL,?,?,'N')";
								ps = conn.prepareStatement(sql);
								ps.setString(1, memberKey);
								ps.setString(2, cafeName+"의 혼잡도가 쾌적입니다");
								ps.executeUpdate();
							}
						}
					}
				}
			}
			if (suc > 0) {
				sql = "SELECT * FROM congestionStandard WHERE cafeKey = ?";
				ps = conn.prepareStatement(sql);
				ps.setString(1, sessionId);
				rs = ps.executeQuery();
				if (rs.next()) {
					map.put("leisurely", rs.getInt("leisurely"));
					map.put("normal", rs.getInt("normal"));
					map.put("congest", rs.getInt("congest"));
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			resClose();
		}
		return map;
	}

	public ArrayList<CafeDTO> cafeAlarmList(String sessionId) {
		ArrayList<CafeDTO> cafeAlarmList = new ArrayList<CafeDTO>();
		try {
			String sql = "SELECT * FROM alarm WHERE memberKey = ?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, sessionId);
			rs = ps.executeQuery();
			if(rs.next()) {
				sql = "UPDATE alarm SET alarmCheck = 'Y' WHERE memberKey=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1, sessionId);
				ps.executeUpdate();
			}
			sql= "SELECT alarmContent,alarmNum FROM alarm WHERE memberKey=? ORDER BY alarmNum";
			ps = conn.prepareStatement(sql);
			ps.setString(1, sessionId);
			rs= ps.executeQuery();
			while(rs.next()) {
				dto = new CafeDTO();
				dto.setAlarmContent(rs.getString("alarmContent"));
				dto.setAlarmNum(rs.getInt("alarmNum"));
				cafeAlarmList.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return cafeAlarmList;
	}

	public int cafeAlarmDel(ArrayList<Integer> cafeAlarmDelNumArr) {
		int suc = 0;
		try {
			for (Integer alarmNum : cafeAlarmDelNumArr) {
				String sql = "DELETE FROM alarm WHERE alarmNum=?";
				ps = conn.prepareStatement(sql);
				ps.setInt(1, alarmNum);
				suc = ps.executeUpdate();
			}			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return suc;
	}

	public boolean realTimeAlarm(String sessionId) {
		boolean check = false;
		try {
			String sql = "SELECT * FROM alarm WHERE memberKey=? AND alarmCheck='N'";
			ps = conn.prepareStatement(sql);
			ps.setString(1, sessionId);
			rs = ps.executeQuery();
			if(rs.next()) {
				check = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			resClose();
		}
		return check;
	}

	public ArrayList <CafeDTO> inputCafeInfo() {
		ArrayList <CafeDTO> inputCafeList = new ArrayList<CafeDTO>();
	    try {
	    	String sql = "SELECT cafeKey,cafeName,cafePhone FROM cafeInfo WHERE openCheck = 'N'";
	    	ps = conn.prepareStatement(sql);
	    	rs = ps.executeQuery();
	    	while(rs.next()) {
	    		dto = new CafeDTO();
	    		dto.setCafeKey(rs.getString("cafeKey"));
	    		dto.setCafeName(rs.getString("cafeName"));
	    		dto.setCafePhone(rs.getString("cafePhone"));
	    		inputCafeList.add(dto);
	    	}
	    }catch (Exception e) {
			e.printStackTrace();
		}finally {
			resClose();
		}
		return inputCafeList;
	}
}

package com.go.sub.comment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class CommentDAO {

	public Connection conn = null;
	public ResultSet rs = null;
	public PreparedStatement ps = null;
	String sql = null;
	int suc = 0;
	CommentDTO dto = null;

	public CommentDAO() {
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

	public int cafeCommentInput(String sessionId, String commentContent, String cafeKey) {
		int commentNo = 0;
		int page = 1;
		try {
			sql = "INSERT INTO cm (commentNo,commentDel,memberKey,division,cm_content) VALUES(cm_seq.NEXTVAL,'N',?,?,?)";
			ps = conn.prepareStatement(sql, new String[] { "commentNo" });
			ps.setString(1, sessionId);
			ps.setString(2, cafeKey);
			ps.setString(3, commentContent);
			ps.executeUpdate();
			rs = ps.getGeneratedKeys();
			if (rs.next()) {
				commentNo = rs.getInt(1);
			}
			while (true) {
				// 노출할 데이터 갯수
				int pagePerCnt = 8;
				// 데이터의 시작과 끝
				int end = page * pagePerCnt;
				int start = (end - pagePerCnt) + 1;
				sql = "SELECT commentNo,cm_content,memberKey FROM "
						+ "(SELECT ROW_NUMBER() OVER(ORDER BY commentNo) AS rnum,commentNo,cm_content,memberKey FROM cm WHERE division=? AND commentDel='N')"
						+ "WHERE (rnum BETWEEN ? AND ?) AND commentNo=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1, cafeKey);
				ps.setInt(2, start);
				ps.setInt(3, end);
				ps.setInt(4, commentNo);
				rs = ps.executeQuery();
				if (rs.next()) {
					break;
				} else {
					page++;
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return page;
	}

	public HashMap<String, Object> cafeCommentList(String cafeKey, int page) {
		ArrayList<CommentDTO> list = new ArrayList<CommentDTO>();
		HashMap<String, Object> map = new HashMap<String, Object>();
		try {
			sql = "SELECT commentNo,cm_content,memberKey FROM "
					+ "(SELECT ROW_NUMBER() OVER(ORDER BY commentNo) AS rnum,commentNo,cm_content,memberKey FROM cm WHERE division=? AND commentDel='N')"
					+ "WHERE rnum BETWEEN ? AND ?";
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
			System.out.println("시작" + start);
			System.out.println("끝" + end);
			ps = conn.prepareStatement(sql);
			ps.setString(1, cafeKey);
			ps.setInt(2, start);
			ps.setInt(3, end);
			rs = ps.executeQuery();
			while (rs.next()) {
				dto = new CommentDTO();
				dto.setCommentNo(rs.getString("commentNo"));
				dto.setMemberKey(rs.getString("memberKey"));
				dto.setCm_content(rs.getString("cm_content"));
				list.add(dto);
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
			sql = "SELECT COUNT(commentNo) FROM cm WHERE commentDel='N' AND division=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, cafeKey);
			rs = ps.executeQuery();
			if (rs.next()) {
				map.put("commentCount", rs.getInt(1));
			}

			System.out.println(list);
			map.put("list", list);
			map.put("totalPage", totalPages);
			map.put("currPage", page);
			map.put("pageLength", pageLength);
			map.put("startPage", startPage);
			map.put("endPage", endPage);
			map.put("cafeKey", cafeKey);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			resClose();
		}
		return map;
	}

	public int cafeCommentDel(String commentNo, String cafeKey) {
		int page = 1;
		try {
			while (true) {
				// 노출할 데이터 갯수
				int pagePerCnt = 8;
				// 데이터의 시작과 끝
				int end = page * pagePerCnt;
				int start = (end - pagePerCnt) + 1;
				sql = "SELECT commentNo,cm_content,memberKey FROM "
						+ "(SELECT ROW_NUMBER() OVER(ORDER BY commentNo) AS rnum,commentNo,cm_content,memberKey FROM cm WHERE division=? AND commentDel='N')"
						+ "WHERE (rnum BETWEEN ? AND ?) AND commentNo=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1, cafeKey);
				ps.setInt(2, start);
				ps.setInt(3, end);
				ps.setInt(4, Integer.parseInt(commentNo));
				rs = ps.executeQuery();
				if (rs.next()) {
					break;
				} else {
					page++;
				}
			}
			sql = "UPDATE cm SET commentDel='Y' WHERE commentNo = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, Integer.parseInt(commentNo));
			suc = ps.executeUpdate();

			if (suc > 0 && page != 1) {
				while (true) { // 노출할 데이터 갯수 
					// 데이터의 시작과 끝
					int pagePerCnt = 8; 
					int end = page * pagePerCnt;
					int start = (end - pagePerCnt) + 1;
					sql = "SELECT commentNo,cm_content,memberKey FROM "
							+ "(SELECT ROW_NUMBER() OVER(ORDER BY commentNo) AS rnum,commentNo,cm_content,memberKey FROM cm WHERE division=? AND commentDel='N')"
							+ "WHERE (rnum BETWEEN ? AND ?)";
					ps = conn.prepareStatement(sql);
					ps.setString(1, cafeKey);
					ps.setInt(2, start);
					ps.setInt(3, end);
					rs = ps.executeQuery();
					if (rs.next()) {
						break;
					} else {
						page--;
					}
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return page;
	}

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

	public int cafeCommentUpdate(String cafeKey,String commentNo, String commentUpdateContent) {
		int page = 1;
		try {
			sql = "UPDATE cm SET cm_content=? WHERE commentNo=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, commentUpdateContent);
			ps.setString(2, commentNo);
			suc = ps.executeUpdate();
			if(suc>0) {
				while (true) {
					// 노출할 데이터 갯수
					int pagePerCnt = 8;
					// 데이터의 시작과 끝
					int end = page * pagePerCnt;
					int start = (end - pagePerCnt) + 1;
					sql = "SELECT commentNo,cm_content,memberKey FROM "
							+ "(SELECT ROW_NUMBER() OVER(ORDER BY commentNo) AS rnum,commentNo,cm_content,memberKey FROM cm WHERE division=? AND commentDel='N')"
							+ "WHERE (rnum BETWEEN ? AND ?) AND commentNo=?";
					ps = conn.prepareStatement(sql);
					ps.setString(1, cafeKey);
					ps.setInt(2, start);
					ps.setInt(3, end);
					ps.setInt(4, Integer.parseInt(commentNo));
					rs = ps.executeQuery();
					if (rs.next()) {
						break;
					} else {
						page++;
					}
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return page;
	}

	public int cafeCommentReport(String reportReason, String commentNo, String sessionId, String cafeKey) {
		try {
			sql = "INSERT INTO cmReport(reportCmNo,commentNo,reportReason,cmReporter,division) "
					+ "VALUES(cmReport_seq.NEXTVAL,?,?,?,?)";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, Integer.parseInt(commentNo));
			ps.setString(2, reportReason);
			ps.setString(3, sessionId);
			ps.setString(4, cafeKey);
			suc = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			resClose();
		}
		return suc;
	}
}

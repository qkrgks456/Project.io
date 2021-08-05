package com.go.sub.good;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.go.main.cafe.CafeDTO;

public class GoodDAO {

	public Connection conn = null;
	public ResultSet rs = null;
	public PreparedStatement ps = null;
	String sql = null;

	public GoodDAO() {
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

	public int cafeGood(String goodCheckBtn, String cafeKey, String sessionId) {
		int suc = 0;
		int cafeGoodCount = 0;
		try {
			sql = "SELECT likeNo FROM good WHERE memberKey = ? AND division = ?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, sessionId);
			ps.setString(2, cafeKey);
			rs = ps.executeQuery();
			if (rs.next()) {
				sql = "DELETE FROM good WHERE memberKey = ? AND division = ?";
				ps = conn.prepareStatement(sql);
				ps.setString(1, sessionId);
				ps.setString(2, cafeKey);
				suc = ps.executeUpdate();
				if (suc > 0) {
					sql = "SELECT COUNT(likeNo) FROM good WHERE division=?";
					ps = conn.prepareStatement(sql);
					ps.setString(1, cafeKey);
					rs = ps.executeQuery();
					if (rs.next()) {
						cafeGoodCount = rs.getInt(1);
					}
				}
			} else {
				sql = "INSERT INTO good (likeNo,division,memberKey) VALUES(good_seq.NEXTVAL,?,?)";
				ps = conn.prepareStatement(sql);
				ps.setString(1, cafeKey);
				ps.setString(2, sessionId);
				suc = ps.executeUpdate();
				if (suc > 0) {
					sql = "SELECT COUNT(likeNo) FROM good WHERE division=?";
					ps = conn.prepareStatement(sql);
					ps.setString(1, cafeKey);
					rs = ps.executeQuery();
					if (rs.next()) {
						cafeGoodCount = rs.getInt(1);
					}
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			resClose();
		}
		return cafeGoodCount;
	}

	public ArrayList<CafeDTO> cafeGoodList(String sessionId) {
		ArrayList<CafeDTO> cafeGoodList = new ArrayList<CafeDTO>();
		CafeDTO dto = null;
		try {
			String sql = "SELECT newfilename,cafeName,cafeKey,cafeDetail,cafeAddress,g.likeNo "
					+ "FROM(SELECT i.newfilename,c.cafeName,c.cafeKey,c.cafeDetail,c.cafeAddress "
					+ "FROM (SELECT division,newFileName FROM image WHERE ROWID IN "
					+ "(SELECT MIN(ROWID) FROM image GROUP BY division)) i "
					+ "LEFT OUTER JOIN cafeInfo c ON i.division= c.cafeKey "
					+ "WHERE c.cafeDel='N' AND c.openCheck='Y')c "
					+ "LEFT OUTER JOIN good g ON c.cafeKey=g.division "
					+ "WHERE g.memberKey=? ORDER BY g.likeNo";
			ps = conn.prepareStatement(sql);
			ps.setString(1, sessionId);
			rs = ps.executeQuery();
			while(rs.next()) {
				dto = new CafeDTO();
				dto.setNewFileName(rs.getString("newfilename"));
				dto.setCafeName(rs.getString("cafeName"));
				dto.setCafeKey(rs.getString("cafeKey"));
				dto.setCafeDetail(rs.getString("cafeDetail"));
				dto.setCafeAddress(rs.getString("cafeAddress"));
				cafeGoodList.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			resClose();
		}
		return cafeGoodList;
	}
}

package com.go.sub.good;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

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
}

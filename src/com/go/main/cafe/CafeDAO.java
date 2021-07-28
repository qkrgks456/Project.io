package com.go.main.cafe;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class CafeDAO {

	public Connection conn = null;
	public ResultSet rs = null;
	public PreparedStatement ps = null;
	String sql = null;
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
		// 몰라
		
		sql = "INSERT INTO ownerUser(ownerNo,memberKey) VALUES(?,?)";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, dto.getOnnerNo());
			ps.setString(2, sessionId);
			suc = ps.executeUpdate();
			if (suc > 0) {
				sql = "INSERT INTO cafeInfo"
						+ "(cafeKey,ownerNo,cafeName,cafeLocation,cafeAddress,cafePhone,cafeDetail,cafeTime"
						+ ",parkingCheck,petCheck,childCheck,rooftopCheck,groupCheck,cafeDel,openCheck)"
						+ "VALUES"
						+ "(cafeInfo_seq.NEXTVAL,?,?,?,?,?,?,?,?,?,?,?,?,'N','Y')";
				ps = conn.prepareStatement(sql);
				ps.setString(1, dto.getOnnerNo());
				ps.setString(2, dto.getCafeName());
				ps.setString(3, dto.getCafeLocation());
				ps.setString(4, dto.getCafeAddress());
				ps.setString(5, dto.getCafePhone());
				ps.setString(6, dto.getCafeDetail());
				ps.setString(7, dto.getCafeTime());
				ps.setString(8, dto.getParkingCheck());
				ps.setString(9, dto.getPetCheck());
				ps.setString(10, dto.getChildCheck());
				ps.setString(11, dto.getRooftopCheck());
				ps.setString(12, dto.getGroupCheck());
				suc = ps.executeUpdate();
				System.out.println("안녕");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			resClose();
		}
		return suc;
	}

	public boolean ownerCheck(String ownerNo) {
		sql = "SELECT ownerNo FROM cafeInfo WHERE ownerNo = ?";
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

}

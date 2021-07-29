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
	String sql = null;
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

			sql = "SELECT cafeKey FROM cafeInfo WHERE cafeKey=?";
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
						ps.setString(1, dto.getOnnerNo());
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

	public CafeDTO cafeInfoMyPage(String sessionId) {
		ArrayList<HashMap<String, Object>> maparr = new ArrayList<HashMap<String,Object>>();
		HashMap<String, Object> map = null;
		try {
			dto = new CafeDTO();
			sql = "SELECT cafeName,cafeLocation,cafeAddress,cafePhone,cafeDetail,cafeTime"
					+ ",parkingCheck,petCheck,childCheck,rooftopCheck,groupCheck FROM cafeInfo WHERE cafeKey = ?";
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
			while(rs.next()) {
				map = new HashMap<String, Object>();
				map.put("newFileName",rs.getString("newFileName"));
				map.put("fileIdx",rs.getString("fileIdx"));
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
		System.out.println("maparr 있냐 : "+maparr);
		return dto;
	}

}

package com.go.main.mainPage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.go.main.cafe.CafeDTO;


public class MainDAO {
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;

	public MainDAO() {
		try {
			// 1. Context 가져오기
			Context ctx = new InitialContext();
			// 2. name으로 Resource 가져와 DataSource 변환
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Oracle");
			// 3. Connection 가져오기
			conn = ds.getConnection();
			System.out.println("커넥션 : " + conn);
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

	public HashMap<String, Object> mainPage(String sessionId) {
		ArrayList<CafeDTO> goodList = new ArrayList<CafeDTO>();
		ArrayList<CafeDTO> bHitList = new ArrayList<CafeDTO>();
		HashMap<String, Object> map = new HashMap<String, Object>();
		CafeDTO dto = new CafeDTO();
		String location = null;
		try {		
			// 상위 좋아요 4개 데이터
			String sql = "SELECT s.cafeKey,s.newfilename,s.cafeName,s.cafeNum,s.cafeLocation,s.cafeDetail,s.confusion,s.bHit,g.co "
					+ "FROM (SELECT i.newfilename,c.cafeName,c.cafeNum,c.cafeKey,c.cafeLocation,c.cafeDetail,c.confusion,c.bHit "
					+ "FROM (SELECT division,newFileName FROM image WHERE fileIdx IN (SELECT MIN(fileIdx) FROM image GROUP BY division)) i "
					+ "LEFT OUTER JOIN cafeInfo c ON i.division= c.cafeKey WHERE c.cafeDel='N' AND c.openCheck='Y') s "
					+ "LEFT OUTER JOIN (SELECT division,COUNT(likeNo)co FROM good GROUP BY(division)) g ON g.division = s.cafeKey "
					+ "ORDER BY g.co DESC OFFSET 0 ROWS FETCH FIRST 4 ROWS ONLY";
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
				dto.setbHit(rs.getInt("bHit"));
				dto.setGoodCount(rs.getInt("co"));
				goodList.add(dto);
			}
			if(sessionId == null) {
				sql = "SELECT cafeKey,newfilename,cafeName,cafeNum,cafeLocation,cafeDetail,confusion,bHit "
						+ "FROM (SELECT i.newfilename,c.cafeName,c.cafeNum,c.cafeKey,c.cafeLocation"
						+ ",c.cafeDetail,c.confusion,c.bHit FROM "
						+ "(SELECT division,newFileName FROM image WHERE fileIdx IN "
						+ "(SELECT MIN(fileIdx) FROM image GROUP BY division)) i "
						+ "LEFT OUTER JOIN cafeInfo c ON i.division= c.cafeKey "
						+ "WHERE c.cafeDel='N' AND c.openCheck='Y') "
						+ "ORDER BY bHit DESC OFFSET 0 ROWS FETCH FIRST 4 ROWS ONLY";	
				ps = conn.prepareStatement(sql);
				rs = ps.executeQuery();
				while(rs.next()) {
					dto = new CafeDTO();
					dto.setCafeKey(rs.getString("cafeKey"));
					dto.setCafeName(rs.getString("cafeName"));
					dto.setCafeLocation(rs.getString("cafeLocation"));
					dto.setCafeDetail(rs.getString("cafeDetail"));
					dto.setConfusion(rs.getString("confusion"));
					dto.setNewFileName(rs.getString("newfilename"));				
					dto.setbHit(rs.getInt("bHit"));	
					bHitList.add(dto);
				}
			}else {
				sql ="SELECT location FROM users WHERE memberKey=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1, sessionId);
				rs = ps.executeQuery();
				if(rs.next()) {
					location = rs.getString("location");
				}
				System.out.println(location);
				sql = "SELECT cafeKey,newfilename,cafeName,cafeNum,cafeLocation,cafeDetail,confusion,bHit "
						+ "FROM (SELECT i.newfilename,c.cafeName,c.cafeNum,c.cafeKey,c.cafeLocation"
						+ ",c.cafeDetail,c.confusion,c.bHit FROM "
						+ "(SELECT division,newFileName FROM image WHERE fileIdx IN "
						+ "(SELECT MIN(fileIdx) FROM image GROUP BY division)) i "
						+ "LEFT OUTER JOIN cafeInfo c ON i.division= c.cafeKey "
						+ "WHERE c.cafeDel='N' AND c.openCheck='Y' AND c.cafeLocation=?) "
						+ "ORDER BY bHit DESC OFFSET 0 ROWS FETCH FIRST 4 ROWS ONLY";	
				ps = conn.prepareStatement(sql);
				ps.setString(1, location);
				rs = ps.executeQuery();
				while(rs.next()) {
					dto = new CafeDTO();
					dto.setCafeKey(rs.getString("cafeKey"));
					dto.setCafeName(rs.getString("cafeName"));
					dto.setCafeLocation(rs.getString("cafeLocation"));
					dto.setCafeDetail(rs.getString("cafeDetail"));
					dto.setConfusion(rs.getString("confusion"));
					dto.setNewFileName(rs.getString("newfilename"));				
					dto.setbHit(rs.getInt("bHit"));	
					bHitList.add(dto);
				}
				
				if(bHitList.size()<4) {
					bHitList.clear();
					sql = "SELECT cafeKey,newfilename,cafeName,cafeNum,cafeLocation,cafeDetail,confusion,bHit "
							+ "FROM (SELECT i.newfilename,c.cafeName,c.cafeNum,c.cafeKey,c.cafeLocation"
							+ ",c.cafeDetail,c.confusion,c.bHit FROM "
							+ "(SELECT division,newFileName FROM image WHERE fileIdx IN "
							+ "(SELECT MIN(fileIdx) FROM image GROUP BY division)) i "
							+ "LEFT OUTER JOIN cafeInfo c ON i.division= c.cafeKey "
							+ "WHERE c.cafeDel='N' AND c.openCheck='Y') "
							+ "ORDER BY bHit DESC OFFSET 0 ROWS FETCH FIRST 4 ROWS ONLY";	
					ps = conn.prepareStatement(sql);
					rs = ps.executeQuery();
					while(rs.next()) {
						dto = new CafeDTO();
						dto.setCafeKey(rs.getString("cafeKey"));
						dto.setCafeName(rs.getString("cafeName"));
						dto.setCafeLocation(rs.getString("cafeLocation"));
						dto.setCafeDetail(rs.getString("cafeDetail"));
						dto.setConfusion(rs.getString("confusion"));
						dto.setNewFileName(rs.getString("newfilename"));				
						dto.setbHit(rs.getInt("bHit"));	
						bHitList.add(dto);
					}
				}			
			}			
			System.out.println(bHitList);
			map.put("goodList", goodList);
			map.put("bHitList", bHitList);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			resClose();
		}
		return map;
	}

	public int cartCount(String sessionId) {
		String sql = "SELECT COUNT(cartId) FROM cart WHERE memberKey=?";
		int cartCount = 0;
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, sessionId);
			rs = ps.executeQuery();
			if(rs.next()) {
				cartCount = rs.getInt(1);
			}		
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			resClose();
		}
		
		return cartCount;
	}
	
	
}

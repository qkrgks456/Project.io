package com.go.main.mainPage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

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

	public ArrayList<CafeDTO> mainPage() {
		ArrayList<CafeDTO> list = new ArrayList<CafeDTO>();
		
		try {		
			// 상위 좋아요 4개 데이터
			String sql = "SELECT s.cafeKey,s.newfilename,s.cafeName,s.cafeNum,s.cafeLocation,s.cafeDetail,s.confusion,s.bHit,g.co "
					+ "FROM (SELECT i.newfilename,c.cafeName,c.cafeNum,c.cafeKey,c.cafeLocation,c.cafeDetail,c.confusion,c.bHit "
					+ "FROM (SELECT division,newFileName FROM image WHERE ROWID IN (SELECT MIN(ROWID) FROM image GROUP BY division)) i "
					+ "LEFT OUTER JOIN cafeInfo c ON i.division= c.cafeKey WHERE c.cafeDel='N' AND c.openCheck='Y') s "
					+ "LEFT OUTER JOIN (SELECT division,COUNT(likeNo)co FROM good GROUP BY(division)) g ON g.division = s.cafeKey "
					+ "ORDER BY g.co DESC OFFSET 0 ROWS FETCH FIRST 4 ROWS ONLY";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				CafeDTO dto = new CafeDTO();
				dto.setCafeKey(rs.getString("cafeKey"));
				dto.setCafeName(rs.getString("cafeName"));
				dto.setCafeLocation(rs.getString("cafeLocation"));
				dto.setCafeDetail(rs.getString("cafeDetail"));
				dto.setConfusion(rs.getString("confusion"));
				dto.setNewFileName(rs.getString("newfilename"));				
				dto.setbHit(rs.getInt("bHit"));
				dto.setGoodCount(rs.getInt("co"));
				list.add(dto);
			}			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			resClose();
		}
		
		
		return list;
	}
	
	
}

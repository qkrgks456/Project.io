package com.go.main.product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import com.go.main.cafe.CafeDTO;
import com.go.main.search.SearchDTO;

public class ProductDAO {

	HttpServletRequest req = null;
	HttpServletResponse resp = null;
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;

	public ProductDAO(HttpServletRequest req, HttpServletResponse resp) {// 커넥션 생성
		this.req = req;
		this.resp = resp;
		try {
			Context ctx = new InitialContext();// 1. Context 가져오기
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Oracle");// 2. name 으로 Resource 가져와 DataSource 로
																					// 변환
			conn = ds.getConnection();// 3. Connection 가져오기
			System.out.println(conn);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void resClose() {// 자원 반납
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
			System.out.println("conn close" + conn);
			System.out.println("isClose() : " + conn.isClosed());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public int productjoin(ProductDTO dto, String sessionId) {
		int suc = 0;
		String sql = "INSERT INTO product(productid,cafekey,productName,Price,explanation,productQuantity,selCheck,categoryName) VALUES(product_seq.nextval,?,?,?,?,?,?,?)";

		try {
			ps = conn.prepareStatement(sql, new String[] { "productId" });
			ps.setString(1, sessionId);
			ps.setString(2, dto.getProductName());
			ps.setInt(3, dto.getPrice());
			ps.setString(4, dto.getExplanation());
			ps.setInt(5, dto.getProductQuantity());
			ps.setString(6, dto.getSelCheck());
			ps.setString(7, dto.getCategoryName());
			ps.executeUpdate();
			rs = ps.getGeneratedKeys();
			if (rs.next()) {
				sql = "INSERT INTO image(fileidx,division,oriFileName,newFileName)" + "VALUES(image_seq.NEXTVAL,?,?,?)";
				ps = conn.prepareStatement(sql);
				suc = rs.getInt(1);
				System.out.println("suc 받아짐? :" + suc);
				ps.setInt(1, suc);
				ps.setString(2, dto.getOriFileName());
				ps.setString(3, dto.getNewFileName());
				ps.executeUpdate();

			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			resClose();
		}
		return suc;
	}

	public ArrayList<ProductDTO> productlistWD() {
		String sql = "SELECT p.productname,p.explanation,p.productid,p.categoryname,i.newfilename from product p left outer join image i on i.division=p.productid WHERE categoryname='원두'";
		ArrayList<ProductDTO> productlistWD = null;
		ProductDTO dto = null;

		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			productlistWD = new ArrayList<ProductDTO>();
			while (rs.next()) {
				dto = new ProductDTO();
				dto.setProductName(rs.getString("productName"));
				dto.setExplanation(rs.getString("explanation"));
				dto.setProductId(rs.getInt("productId"));
				dto.setNewFileName(rs.getString("newFileName"));
				dto.setCategoryName(rs.getString("categoryName"));
				productlistWD.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			resClose();
		}
		return productlistWD;
	}

	public ArrayList<ProductDTO> productlistMD() {
		String sql = "SELECT p.productname,p.explanation,p.productid,p.categoryname,i.newfilename from product p left outer join image i on i.division=p.productid WHERE categoryname='엠디'";
		ArrayList<ProductDTO> productlistMD = null;
		ProductDTO dto = null;

		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			productlistMD = new ArrayList<ProductDTO>();
			while (rs.next()) {
				dto = new ProductDTO();
				dto.setProductName(rs.getString("productName"));
				dto.setExplanation(rs.getString("explanation"));
				dto.setProductId(rs.getInt("productId"));
				dto.setNewFileName(rs.getString("newFileName"));
				dto.setCategoryName(rs.getString("categoryName"));
				productlistMD.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			resClose();
		}

		return productlistMD;
	}

	public HashMap<String, Object> productdetail(String wdId, int page, String sessionId) {
		ArrayList<ProductDTO> commentList = new ArrayList<ProductDTO>();
		ProductDTO dto = null;
		HashMap<String, Object> map = new HashMap<String, Object>();

		String sql = "SELECT p.productname,p.explanation,p.productid,p.categoryname,i.newfilename,p.price from product p left outer join image i on i.division=p.productid WHERE p.productid=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, wdId);
			rs = ps.executeQuery();
			if (rs.next()) {
				/*
				 * dto = new ProductDTO(); dto.setProductName(rs.getString("productName"));
				 * dto.setExplanation(rs.getString("explanation"));
				 * dto.setProductId(rs.getInt("productid"));
				 * dto.setCategoryName(rs.getString("categoryname"));
				 * dto.setPrice(rs.getInt("Price"));
				 * dto.setNewFileName(rs.getString("newFileName"));
				 */

				map.put("productName", rs.getString("productName"));
				map.put("explanation", rs.getString("explanation"));
				map.put("productid", rs.getString("productid"));
				map.put("categoryname", rs.getString("categoryname"));
				map.put("price", rs.getString("Price"));
				map.put("newFileName", rs.getString("newFileName"));
			}
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
			ps.setString(1, wdId);
			ps.setInt(2, start);
			ps.setInt(3, end);
			rs = ps.executeQuery();
			while (rs.next()) {
				dto = new ProductDTO();
				dto.setCommentNo(rs.getString("commentNo"));
				dto.setCm_content(rs.getString("cm_content"));
				dto.setMemberKey(rs.getString("memberKey"));
				commentList.add(dto);
			}
			int total = totalComment(wdId); // 총 댓글 수 가져옵시다
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
				sql = "SELECT productid FROM"
						+ "(SELECT productid FROM product ORDER BY productid DESC OFFSET ? ROWS FETCH FIRST ? ROWS ONLY)"
						+ "WHERE productid=?";
				ps = conn.prepareStatement(sql);
				ps.setInt(1, cafeStarts);
				ps.setInt(2, cafeEnds);
				ps.setString(3, wdId);
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

	public HashMap<String, Object> productdetailT(String mdId, int page, String sessionId) {
		ArrayList<ProductDTO> commentList = new ArrayList<ProductDTO>();
		ProductDTO dto = null;
		HashMap<String, Object> map = new HashMap<String, Object>();

		String sql = "SELECT p.productname,p.explanation,p.productid,p.categoryname,i.newfilename,p.price from product p left outer join image i on i.division=p.productid WHERE p.productid=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, mdId);
			rs = ps.executeQuery();
			if (rs.next()) {
				/*
				 * dto = new ProductDTO(); dto.setProductName(rs.getString("productName"));
				 * dto.setExplanation(rs.getString("explanation"));
				 * dto.setProductId(rs.getInt("productid"));
				 * dto.setCategoryName(rs.getString("categoryname"));
				 * dto.setPrice(rs.getInt("Price"));
				 * dto.setNewFileName(rs.getString("newFileName"));
				 */

				map.put("productName", rs.getString("productName"));
				map.put("explanation", rs.getString("explanation"));
				map.put("productid", rs.getString("productid"));
				map.put("categoryname", rs.getString("categoryname"));
				map.put("price", rs.getString("Price"));
				map.put("newFileName", rs.getString("newFileName"));
			}

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
			ps.setString(1, mdId);
			ps.setInt(2, start);
			ps.setInt(3, end);
			rs = ps.executeQuery();
			while (rs.next()) {
				dto = new ProductDTO();
				dto.setCommentNo(rs.getString("commentNo"));
				dto.setCm_content(rs.getString("cm_content"));
				dto.setMemberKey(rs.getString("memberKey"));
				commentList.add(dto);
			}
			map.put("commentList", commentList);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return map;
	}

	// 댓글 총개수
	private int totalComment(String mdId) throws SQLException {
		String sql = "SELECT COUNT(commentNo) FROM cm WHERE division = ? AND commentDel='N'";
		ps = conn.prepareStatement(sql);
		ps.setString(1, mdId);
		rs = ps.executeQuery();
		int total = 0;
		if (rs.next()) {
			total = rs.getInt(1);
		}
		return total;
	}

	public ArrayList<ProductDTO> prosearch(String prosearchresult) {
		String sql = "select p.productname,p.explanation,p.productid,i.newfilename from product p left outer join image i on i.division=p.productid WHERE productname LIKE ?";
		ArrayList<ProductDTO> prosearch = null;
		ProductDTO dto = null;

		try {
			prosearch = new ArrayList<ProductDTO>();
			ps = conn.prepareStatement(sql);
			ps.setString(1, "%" + prosearchresult + "%");
			rs = ps.executeQuery();
			while (rs.next()) {
				dto = new ProductDTO();
				dto.setProductName(rs.getString("productName"));
				dto.setExplanation(rs.getString("explanation"));
				dto.setProductId(rs.getInt("productid"));
				dto.setNewFileName(rs.getString("newFileName"));
				prosearch.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			resClose();
		}
		return prosearch;
	}

//카트에 넣기
	public int cartinsert(String sessionId) {
		String qty = req.getParameter("quantity");
		String pid = req.getParameter("productn");
		System.out.println(pid);
		int suc = 0;

		String sql = "insert into cart(memberkey,productid,amount,cartId) values(?, ?, ?,cart_seq.NEXTVAL)";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, sessionId);
			ps.setString(2, pid);
			ps.setString(3, qty);
			suc = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return suc;
	}

//장바구니 리스트에 뿌리기

	public ArrayList<ProductDTO> cartlist(String sessionId) {
		String sql = "SELECT p.productId, p.productname, p.price, p.productquantity, i.newfilename from "
				+ "(SELECT p.productId, p.productname, p.price, p.productquantity "
				+ "from users u, product p, cart c where c.memberkey=? and u.memberKey=c.memberKey and p.productId=c.productId "
				+ "order by p.productId) p left outer join image i on i.division=p.productid";
		ArrayList<ProductDTO> cartlist = null;
		ProductDTO dto = null;
		try {
			cartlist = new ArrayList<ProductDTO>();
			ps = conn.prepareStatement(sql);
			ps.setString(1, sessionId);
			rs = ps.executeQuery();
			while (rs.next()) {
				dto = new ProductDTO();
				dto.setProductName(rs.getString("productname"));
				dto.setProductQuantity(rs.getInt("productquantity"));
				dto.setPrice(rs.getInt("price"));
				dto.setNewFileName(rs.getString("newfilename"));
				dto.setProductId(rs.getInt("productId"));
				cartlist.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			resClose();
		}
		return cartlist;
	}

	public HashMap<String, Object> myProductList(String sessionId) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		ArrayList<ProductDTO> myProductList = new ArrayList<ProductDTO>();
		ProductDTO dto = null;
		try {
			String sql = "SELECT productId,productName,price,productQuantity FROM product WHERE cafeKey=? AND delCheck='N' AND selCheck='Y'";
			ps = conn.prepareStatement(sql);
			ps.setString(1, sessionId);
			rs = ps.executeQuery();
			while (rs.next()) {
				dto = new ProductDTO();
				dto.setProductId(rs.getInt("productId"));
				dto.setProductName(rs.getString("productName"));
				dto.setPrice(rs.getInt("price"));
				dto.setProductQuantity(rs.getInt("productQuantity"));
				myProductList.add(dto);
			}
			map.put("myProductList", myProductList);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			resClose();
		}
		return map;
	}

	public int productListDel(String[] delproductId) {
		int suc = 0;
		try {
			for (String productId : delproductId) {
				String sql = "UPDATE product SET delCheck = 'Y' WHERE productId = ?";
				ps = conn.prepareStatement(sql);
				ps.setString(1, productId);
				suc = ps.executeUpdate();
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return suc;
	}
	

	//구매내역 배열 가져오기
	public HashMap<String, Object> purchaseInsert(String sessionId, String pid, String qty, String prc) {
		HashMap<String, Object> map =new HashMap<String, Object>();
		int suc1 = 0;
		String sql = "INSERT INTO purchase(orderNo,memberkey,productid,buyamount,buyprice) values(pur_seq.NEXTVAL,?, ?, ?, ?)";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, sessionId);
			ps.setString(2, pid);
			ps.setString(3, qty);
			ps.setString(4, prc);
			suc1 = ps.executeUpdate();
			map.put("suc", suc1);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return map;
	

	}

	// 구매내역 리스트에 뿌리기

	public ArrayList<ProductDTO> purchaseList(String sessionId) {
		String sql = "SELECT p.productname,p.productId,p.productquantity,p.price, i.newfilename from product p left outer join image i on i.division=p.productid";
		ArrayList<ProductDTO> purchaseList = null;
		ProductDTO dto = null;
		try {
			purchaseList = new ArrayList<ProductDTO>();
			ps = conn.prepareStatement(sql);
			ps.setString(1, sessionId);
			rs = ps.executeQuery();
			while (rs.next()) {
				dto = new ProductDTO();
				dto.setNewFileName(rs.getString("newfilename"));
				dto.setProductName(rs.getString("productname"));
				dto.setProductQuantity(rs.getInt("productquantity"));
				dto.setPrice(rs.getInt("price"));
				// dto.setProductId(rs.getInt("productId"));
				purchaseList.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			resClose();
		}
		return purchaseList;
	}

}

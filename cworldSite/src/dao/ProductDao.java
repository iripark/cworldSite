package dao;

import static db.jdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class ProductDao {

	private static ProductDao productDao;	
	private Connection conn;
	private ProductDao() {}
	public static ProductDao getInstance() {
		if (productDao == null) productDao = new ProductDao();
		return productDao;
	}
	public void setConnection(Connection conn) {
		this.conn = conn;
	}	
	
	public int getProductCount(String where) { // 검색된 상품의 총 개수를 구하여 리턴하는메소드
		Statement stmt = null;	
		ResultSet rs = null;	
		int rcnt = 0;
		try {
			stmt = conn.createStatement();
			String sql = "select count(*) from t_product_info a where a.pi_isview='y' " + where;
			rs = stmt.executeQuery(sql);
			if (rs.next())	rcnt = rs.getInt(1);
		} catch(Exception e) {
			System.out.println("ProductDao클래스의 getProductCount() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}	
		return rcnt;
	}
	
	public ArrayList<PdtInfo> getProductList(int cpage, int psize, String where, String orderBy){
		ArrayList<PdtInfo> productList = new ArrayList<PdtInfo>();
		// 게시글들을 저장할 목록 객체
		PdtInfo productInfo = null;
		// freedom에 저장할 하나의 게시글 정보를 담을 인스턴스
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement();
			String sql = "select a.pi_id, a.pi_img1, a.pi_name, a.pi_dc, a.pi_price, "
					+ "a.pi_price*(100 - a.pi_dc)/100 realPrice, a.pi_score, a.pi_jjim, "
					+ "a.pi_srcnt, a.pi_special, sum(b.ps_stock) stock "
					+ "from t_product_info a, t_product_stock b "
					+ "where a.pi_id = b.pi_id and a.pi_isview='y'" + where
					+ "group by a.pi_id " + orderBy + " limit " + (cpage - 1) * psize + ", " + psize;
			rs = stmt.executeQuery(sql);
			while(rs.next()) {	// 루프를 돌면서 rs에 들어있는 게시글 정보들을 freeList에 저장
				productInfo = new PdtInfo();
				productInfo.setPi_id(rs.getString("pi_id"));
				productInfo.setPi_img1(rs.getString("pi_img1"));
				productInfo.setPi_name(rs.getString("pi_name"));
				productInfo.setPi_dc(rs.getInt("pi_dc"));
				productInfo.setPi_price(rs.getInt("pi_price"));
				productInfo.setRealPrice(rs.getInt("realPrice"));
				productInfo.setPi_srcnt(rs.getInt("pi_srcnt"));
				productInfo.setPi_jjim(rs.getInt("pi_jjim"));
				productInfo.setPi_score(rs.getDouble("pi_score"));
				productInfo.setPi_special(rs.getString("pi_special"));
				productInfo.setStock(rs.getInt("stock"));
				productList.add(productInfo);
			} 	
		} catch (Exception e) {
			System.out.println("ProductDao클래스의 getProductList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}
		return productList;
	}
	
	public ArrayList<PdtCtgrSmall> getSmallList(String pcb){
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<PdtCtgrSmall> smallList = new ArrayList<PdtCtgrSmall>();
		PdtCtgrSmall pcs = null;
		
		try {
			stmt = conn.createStatement();
			String sql = "select * from t_product_ctgr_small where pcb_id = '" + pcb + "' ";
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				pcs = new PdtCtgrSmall();
				pcs.setPcb_id(rs.getString("pcb_id"));
				pcs.setPcs_id(rs.getString("pcs_id"));
				pcs.setPcs_name(rs.getString("pcs_name"));
				smallList.add(pcs);
			}
			
		} catch (Exception e) {
			System.out.println("ProductDao클래스의 getSmallList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs); close(stmt);
		}
		
		return smallList;
	}
	public PdtInfo getProductView(String piid) {
		PdtInfo pdtInfo = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.createStatement();
			String sql = "select a.*, b.pcb_name, c.pcs_name "
					+ "from t_product_info a, t_product_ctgr_big b, t_product_ctgr_small c "
					+ "where a.pcs_id = c.pcs_id and a.pcb_id = b.pcb_id "
					+ "and pi_isview = 'y' and pi_id = '" + piid + "' ";
			rs = stmt.executeQuery(sql);
			if(rs.next()) {
				pdtInfo = new PdtInfo();
				pdtInfo.setPi_id(piid);
				pdtInfo.setPcb_id(rs.getString("pcb_id"));
				pdtInfo.setPcbName(rs.getString("pcb_name"));
				pdtInfo.setPcs_id(rs.getString("pcs_id"));
				pdtInfo.setPcsName(rs.getString("pcs_name"));
				pdtInfo.setPi_name(rs.getString("pi_name"));
				pdtInfo.setPi_price(rs.getInt("pi_price"));
				pdtInfo.setPi_cost(rs.getInt("pi_cost"));
				pdtInfo.setPi_dc(rs.getInt("pi_dc"));
				pdtInfo.setPi_dfee(rs.getInt("pi_dfee"));
				pdtInfo.setPi_img1(rs.getString("pi_img1"));
				pdtInfo.setPi_img2(rs.getString("pi_img2"));
				pdtInfo.setPi_img3(rs.getString("pi_img3"));
				pdtInfo.setPi_desc(rs.getString("pi_desc"));
				pdtInfo.setPi_special(rs.getString("pi_special"));
				pdtInfo.setPi_read(rs.getInt("pi_read"));
				pdtInfo.setPi_score(rs.getDouble("pi_score"));
				pdtInfo.setPi_review(rs.getInt("pi_review"));
				pdtInfo.setPi_jjim(rs.getInt("pi_jjim"));
				pdtInfo.setPi_srcnt(rs.getInt("pi_srcnt"));
				pdtInfo.setPi_isview(rs.getString("pi_isview"));
				pdtInfo.setPi_date(rs.getString("pi_date"));
				
				pdtInfo.setStockList(getStockList(piid));
			}
		} catch(Exception e) {
			System.out.println("ProductViewDao클래스의 getProductView() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs); close(stmt);
		}	
		return pdtInfo;
		}
		
	public ArrayList<PdtStock> getStockList(String piid) {
		ArrayList<PdtStock> pdtStockList = new ArrayList<PdtStock>();
		PdtStock pdtStock = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.createStatement();
			String sql = "select * from t_product_stock where ps_isview = 'y' and pi_id = '" + piid + "' ";
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				pdtStock = new PdtStock();
				pdtStock.setPi_id(rs.getString("pi_id"));
				pdtStock.setPs_idx(rs.getInt("ps_idx"));
				pdtStock.setPs_sale(rs.getInt("ps_sale"));
				pdtStock.setPs_opt(rs.getString("ps_opt"));
				pdtStock.setPs_stock(rs.getInt("ps_stock"));
				pdtStockList.add(pdtStock);
			}
		} catch(Exception e) {
			System.out.println("ProductDao클래스의 getStockList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs); close(stmt);
		}	
		return pdtStockList;
	}
	public int readUpdate(String piid) {
		int result = 0;
		Statement stmt = null;
		
		try {
			stmt = conn.createStatement();
			String sql = "update t_product_info set pi_read = pi_read + 1 where pi_id = '" + piid + "' ";
			result = stmt.executeUpdate(sql);		
		} catch(Exception e) {
			System.out.println("ProductViewDao클래스의 readUpdate() 메소드 오류");
			e.printStackTrace();
		} finally {
				close(stmt);
		}	
		return result;
	}
	
	public ArrayList<ReviewInfo> getReviewList(String piid) {
		ArrayList<ReviewInfo> reviewList = new ArrayList<ReviewInfo>();
		ReviewInfo ri = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "select *, "
					+ "if(date(rl_date) = curdate(), concat(hour(now()) - hour(rl_date),'시간 전'), " + 
					"concat(datediff(now(), rl_date),'일 전')) wdate "
					+ "from t_review_list where pi_id = '" + piid + "' order by rl_date desc limit 0, 99";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				ri = new ReviewInfo();
				ri.setRl_idx(rs.getInt("rl_idx"));
				ri.setMi_id(rs.getString("mi_id"));
				ri.setOi_id(rs.getString("oi_id"));
				ri.setPi_id(rs.getString("pi_id"));
				ri.setPs_idx(rs.getInt("ps_idx"));
				ri.setRl_pname(rs.getString("rl_pname"));
				ri.setRl_title(rs.getString("rl_title"));
				ri.setRl_content(rs.getString("rl_content"));
				ri.setRl_img(rs.getString("rl_img"));
				ri.setRl_score(rs.getDouble("rl_score"));
				ri.setRl_read(rs.getInt("rl_read"));
				ri.setRl_ip(rs.getString("rl_ip"));
				ri.setRl_date(rs.getString("wdate"));
				ri.setRl_isview(rs.getString("rl_isview"));
				reviewList.add(ri);
			}
		} catch(Exception e) {
			System.out.println("ProductDao클래스의 getReviewList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs); close(stmt);
		}	
		
		return reviewList;
	}
}

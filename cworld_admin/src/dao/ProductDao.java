package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;
import dao.*;

public class ProductDao {
	private static ProductDao productDao;	
	private Connection conn;			
	private ProductDao() {}
	public static ProductDao getInstance() {
		if (productDao == null) {
			productDao = new ProductDao();
		}		
		return productDao;
	}
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public int getProductCount(String where) {
	// 검색된 상품의 총 개수를 구하여 리턴하는 메소드
		int rcnt = 0;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "select count(a.pi_id) from t_product_info a, t_product_stock b where a.pi_id = b.pi_id " + where;
			
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			rs.next();
			rcnt = rs.getInt(1);
		} catch(Exception e) {
			System.out.println("ProductDao 클래스의 getProductCount() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		
		return rcnt;
	}
	public ArrayList<ProductInfo> getProductList(int cpage, int psize, String where) {
	// 검색된 상품의 목록을 구하여 ArrayList<ProductInfo>로 리턴하는 메소드
		ArrayList<ProductInfo> productList = new ArrayList<ProductInfo>();
		ProductInfo pi = null;
		Statement stmt = null;
		ResultSet rs = null;
		int start = psize * (cpage - 1);
		try {
			String sql = "select a.pi_id, a.pi_img1, a.pi_img2, a.pi_img3, a.pi_name, a.pi_dc, a.pi_price, a.pi_dcprice, a.pi_special, b.ps_idx, b.ps_opt, b.ps_stock stock, b.ps_isview from t_product_info a, t_product_stock b where a.pi_id = b.pi_id " + where + " order by a.pi_date desc limit " + start + ", " + psize;
			
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				pi = new ProductInfo();
				pi.setPi_id(rs.getString("pi_id"));
				pi.setPi_img1(rs.getString("pi_img1"));
				pi.setPi_img2(rs.getString("pi_img2"));
				pi.setPi_img3(rs.getString("pi_img3"));
				pi.setPi_name(rs.getString("pi_name"));
				pi.setPi_dc(rs.getInt("pi_dc"));
				pi.setPi_price(rs.getInt("pi_price"));
				pi.setPi_dcprice(rs.getInt("pi_dcprice"));
				pi.setPs_isview(rs.getString("ps_isview"));
				pi.setPi_special(rs.getString("pi_special"));
				pi.setStock(rs.getInt("stock"));
				pi.setOpt(rs.getString("ps_opt"));
				pi.setPs_idx(rs.getInt("ps_idx"));
				productList.add(pi);
			}
		} catch(Exception e) {
			System.out.println("ProductDao 클래스의 getProductList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		return productList;
	}
	public ArrayList<PdtCtgrSmall> getSmallList(String pcb) {
		ArrayList<PdtCtgrSmall> smallList = new ArrayList<PdtCtgrSmall>();
		PdtCtgrSmall pcs = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "select * from t_product_ctgr_small where pcb_id = '" + pcb + "' ";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				pcs = new PdtCtgrSmall();
				pcs.setPcs_id(rs.getString("pcs_id"));
				pcs.setPcs_name(rs.getString("pcs_name"));
				pcs.setPcb_id(rs.getString("pcb_id"));
				smallList.add(pcs);
			}
		} catch(Exception e) {
			System.out.println("ProductDao 클래스의 getSmallList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		
		return smallList;
	}
	public ProductInfo getPdtInfo(String pi_id, int ps_idx) {
		ProductInfo pi = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "select a.pcb_id, a.pcs_id, a.pi_id, a.pi_img1, a.pi_img2, a.pi_img3, a.pi_desc, a.pi_name, a.pi_cost, a.pi_dc, a.pi_price, a.pi_dcprice, a.pi_dfee, a.pi_special, b.ps_stock stock, b.ps_opt, b.ps_isview from t_product_info a, t_product_stock b where a.pi_id = b.pi_id and a.pi_id = '" + pi_id + "' and b.ps_idx = " + ps_idx;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next()) {
				pi = new ProductInfo();
				pi.setPcb_id(rs.getString("pcb_id"));
				pi.setPcs_id(rs.getString("pcs_id"));
				pi.setPi_id(rs.getString("pi_id"));
				pi.setPi_img1(rs.getString("pi_img1"));
				pi.setPi_img2(rs.getString("pi_img2"));
				pi.setPi_img3(rs.getString("pi_img3"));
				pi.setPi_desc(rs.getString("pi_desc"));
				pi.setPi_name(rs.getString("pi_name"));
				pi.setPi_dc(rs.getInt("pi_dc"));
				pi.setPi_cost(rs.getInt("pi_cost"));
				pi.setPi_price(rs.getInt("pi_price"));
				pi.setPi_dcprice(rs.getInt("pi_dcprice"));
				pi.setPi_dfee(rs.getInt("pi_dfee"));
				pi.setPi_special(rs.getString("pi_special"));
				pi.setPs_isview(rs.getString("ps_isview"));
				pi.setStock(rs.getInt("stock"));
				pi.setOpt(rs.getString("ps_opt"));
				pi.setPs_idx(ps_idx);
			}//a.pi_special, b.ps_stock stock, b.ps_opt, b.ps_isview
		} catch(Exception e) {
			System.out.println("ProductDao 클래스의 getPdtInfo() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		
		return pi;
	}
	public int pdtUpdate(ProductInfo pi, int ps_stock, String ps_opt) {
		int result = 0;
		Statement stmt = null;
		
		try {
			String sql = "update t_product_info set pcb_id = '" + pi.getPcb_id() + "', pcs_id = '" + pi.getPcs_id() + "', pi_id = '" + pi.getPi_id() + "', pi_name = '" + pi.getPi_name() + "', pi_price = " + pi.getPi_price() + ", pi_cost = " + pi.getPi_cost() + ", pi_dc = " + pi.getPi_dc() + ", pi_dcprice = " + pi.getPi_dcprice() + ", pi_dfee = " + pi.getPi_dfee() + ", pi_img1 = '" + pi.getPi_img1() + "', pi_img2 = '" + pi.getPi_img2() + "', pi_img3 = '" + pi.getPi_img3() + "', pi_desc = '" + pi.getPi_desc() + "', pi_special = '" + pi.getPi_special() + "', pi_isview = '" + pi.getPi_isview() + "' where pi_id = '" + pi.getPi_id() + "'";
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
			System.out.println(result);
			
			sql = "update t_product_stock set ps_stock = " + ps_stock + ", ps_isview = '" + pi.getPi_isview() + "' where pi_id = '" + pi.getPi_id() + "' and ps_opt = '" + ps_opt + "';";
			result += stmt.executeUpdate(sql);
			System.out.println(result);
			
		} catch(Exception e) {
			System.out.println("ProductDao 클래스의 pdtUpdate() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);
		}
		return result;
	}
	public int getRentCount(String where) {
		int rcnt = 0;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "select count(a.ord_idx) from t_order_rent_detail a, t_order_info b where a.oi_id = b.oi_id " + where;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			rs.next();
			rcnt = rs.getInt(1);
					
		} catch(Exception e) {
			System.out.println("ProductDao 클래스의 getRentCount() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		
		return rcnt;
	}
	public ArrayList<RentInfo> getRentList(int cpage, int psize, String where) {
		ArrayList<RentInfo> rentList = new ArrayList<RentInfo>();
		RentInfo ri = null;
		Statement stmt = null;
		ResultSet rs = null;
		int start = psize * (cpage - 1);
		try {
			String sql = "select a.*, b.mi_id from t_order_rent_detail a, t_order_info b where a.oi_id = b.oi_id " + where + " order by b.oi_date desc limit " + start + ", " + psize;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				ri = new RentInfo();
				ri.setMi_id(rs.getString("mi_id"));
				ri.setPi_id(rs.getString("pi_id"));
				ri.setOi_id(rs.getString("oi_id"));
				ri.setOrd_idx(rs.getInt("ord_idx"));
				ri.setOrd_cnt(rs.getInt("ord_cnt"));
				ri.setPs_idx(rs.getInt("ps_idx"));
				ri.setOrd_edate(rs.getString("ord_edate"));
				ri.setOrd_isreturn(rs.getString("ord_isreturn"));
				ri.setOrd_pimg(rs.getString("ord_pimg"));
				ri.setOrd_pname(rs.getString("ord_pname"));
				ri.setOrd_price(rs.getInt("ord_price"));
				ri.setOrd_redate(rs.getString("ord_redate"));
				ri.setOrd_sdate(rs.getString("ord_sdate"));
				ri.setMemberInfo(getMemberInfo(rs.getString("mi_id")));
				rentList.add(ri);
			}
		} catch(Exception e) {
			System.out.println("ProductDao 클래스의 getRentList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		
		return rentList;
	}
	public MemberInfo getMemberInfo(String miid) {
		MemberInfo mi = null;
		Statement stmt = null;
		ResultSet rs = null;
		MemberListDao memberListDao = MemberListDao.getInstance();
		try {
			MemberListDao md = MemberListDao.getInstance();
			md.setConnection(conn);
			String sql = "select * from t_member_info where mi_id = '" + miid + "'"; 
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if(rs.next()) {
				mi = new MemberInfo();
				mi.setMi_id(rs.getString("mi_id"));
				mi.setMi_pw(rs.getString("mi_pw"));
				mi.setMi_name(rs.getString("mi_name"));
				mi.setMi_gender(rs.getString("mi_gender"));
				mi.setMi_birth(rs.getString("mi_birth"));
				mi.setMi_mail(rs.getString("mi_mail"));
				mi.setMi_phone(rs.getString("mi_phone"));
				mi.setMi_point(rs.getInt("mi_point"));
				mi.setMi_join(rs.getString("mi_join"));
				mi.setMi_last(rs.getString("mi_last"));
				mi.setMi_status(rs.getString("mi_status"));
				mi.setMi_visited(rs.getInt("mi_visited"));
				mi.setMi_adv(rs.getString("mi_adv"));
				mi.setAddrList(memberListDao.getAddrList(rs.getString("mi_id")));
				
			}
		} catch(Exception e) {
			System.out.println("ProductDao 클래스의 getMemberInfo() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		return mi;
	}
	public int isReturnUpdate(int idx, String isRe, int cnt, int psidx) {
		int result = 0, able = 2;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.createStatement();
			String sql1 = "";
			if (isRe.equals("b")) {
				sql1 = "select count(*) from t_order_rent_detail where datediff(left(ord_sdate, 10), now()) <= 0 and ord_idx = " + idx;
				rs = stmt.executeQuery(sql1);
				rs.next();
				able = rs.getInt(1);
				close(rs);
			} else if (isRe.equals("c") || isRe.equals("d")) {
				sql1 = "select count(*) from t_order_rent_detail where datediff(left(ord_edate, 10), now()) <= 0 and ord_idx = " + idx;
				rs = stmt.executeQuery(sql1);
				rs.next();
				able = rs.getInt(1);
				close(rs);
			}	
			
			
			if (able == 1 || able == 2) {
				String sql = "update t_order_rent_detail set ord_isreturn = '" + isRe + "' where ord_idx = " + idx;
				result = stmt.executeUpdate(sql);
				if (isRe.equals("c") && result == 1) {
					sql = "update t_product_stock set ps_stock = ps_stock + " + cnt + " where ps_idx = " + psidx;
					result = stmt.executeUpdate(sql);
					System.out.println(psidx + "dao");
				}
			}
			
		} catch(Exception e) {
			System.out.println("ProductDao 클래스의 isReturnUpdate() 메소드 오류");
			e.printStackTrace();
		} finally {

			close(stmt);
		}
		
		return result;
	}
	
}

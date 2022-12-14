package dao;

import static db.jdbcUtil.*;

import java.io.PrintWriter;
import java.sql.*;
import java.text.*;
import java.util.ArrayList;

import vo.OrderCart;


public class CartDao {
	private static CartDao cartDao;	
	private Connection conn;
	private CartDao() {}

	public static CartDao getInstance() {
		if (cartDao == null) cartDao = new CartDao();
		return cartDao;
	}
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	public int cartInsert(String miid, String piid, int psidx, int count, String sdate, String edate) {
		int result = 0;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement();
			String sql = "select oc_idx from t_order_cart_rent  where mi_id = '" + miid + "' and pi_id = '" + piid + "' and ocr_sdate = '" + sdate + "' and ocr_edate = '" + edate + "' ";
			rs = stmt.executeQuery(sql);
			if (rs.next()) {
				int tmpOcidx = rs.getInt("oc_idx");
				sql = "update t_order_cart set oc_cnt = oc_cnt + '" + count + "' where mi_id = '" + miid + "' and pi_id = '" + piid + "' and ps_idx = '" + psidx + "' and oc_idx = '" + tmpOcidx + "' ";
				result = stmt.executeUpdate(sql);
			} else {
				sql = "insert into t_order_cart (mi_id, pi_id, ps_idx, oc_cnt) values ('" + miid + "', '" + piid + "', '" + psidx + "', '" + count + "')";
				result = stmt.executeUpdate(sql);

				sql = "select max(oc_idx) ocidx from t_order_cart";
				rs = stmt.executeQuery(sql);
				rs.next(); 
				String ocidx = rs.getString("ocidx");
				close(rs);
					
				SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
				java.util.Date sdateCvt = format.parse(sdate);
				java.util.Date edateCvt = format.parse(edate);
				long diff = edateCvt.getTime() - sdateCvt.getTime();
				long diffDays = diff/(24*60*60*1000);
				
				sql = "insert into t_order_cart_rent (oc_idx, mi_id, pi_id, ocr_sdate, ocr_edate, ocr_period) values ('" + ocidx + "', '" + miid + "', '" + piid + "', '" + sdate + "', '" + edate + "', '" + diffDays + "')";				
				result = stmt.executeUpdate(sql);	
			}
		} catch(Exception e) {
			System.out.println("CartDao클래스의 cartInsert(6) 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs); close(stmt);
		}	
		return result;
	}
	
	public int cartInsert(String miid, String piid, int psidx, int count) {
		int result = 0;
		Statement stmt = null;
		try {
			
			stmt = conn.createStatement();
			String sql = "update t_order_cart set oc_cnt = oc_cnt + '" + count + "' where mi_id = '" + miid + "' and pi_id = '" + piid + "' and ps_idx = '" + psidx + "' ";
			result = stmt.executeUpdate(sql);
			if(result == 0) {
				sql = "insert into t_order_cart (mi_id, pi_id, ps_idx, oc_cnt) values ('" + miid + "', '" + piid + "', '" + psidx + "', '" + count + "')";
				result = stmt.executeUpdate(sql);
				
			}
		} catch(Exception e) {
			System.out.println("CartDao클래스의 cartInsert(4) 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);
		}	
		return result;
	}
	public ArrayList<OrderCart> getCartList(String miid){
		ArrayList<OrderCart> cartList = new ArrayList<OrderCart>();
		OrderCart oc = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			ProductDao pvd = ProductDao.getInstance();
			pvd.setConnection(conn);
			stmt = conn.createStatement();
			String sql = "select a.*, b.pi_name, b.pi_dfee, b.pi_price, b.pi_dc, b.pi_img1, b.pi_img2, b.pi_img3, " + 
			" b.pi_price*(100-b.pi_dc)/100 realPrice, ps_opt, left(d.ocr_sdate, 10) sdate, " 
				+ " left(d.ocr_edate, 10) edate, d.ocr_period  from t_order_cart a " + 
				" left join t_product_info b on b.pi_id = a.pi_id " + 
				" left join t_product_stock c on a.ps_idx = c.ps_idx and a.pi_id = c.pi_id " + 
				" left join t_order_cart_rent d on d.oc_idx = a.oc_idx " + 
				"where b.pi_isview = 'y' and c.ps_isview = 'y' and a.mi_id = '" + miid + "'";
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				oc = new OrderCart();
				oc.setOc_idx(rs.getInt("oc_idx"));
				oc.setMi_id(miid);
				oc.setPi_id(rs.getString("pi_id"));
				oc.setPs_idx(rs.getInt("ps_idx"));
				oc.setOc_cnt(rs.getInt("oc_cnt"));
				oc.setOc_date(rs.getString("oc_date"));
				oc.setPi_name(rs.getString("pi_name"));
				oc.setPi_price(rs.getInt("pi_price"));
				oc.setPi_dc(rs.getInt("pi_dc"));
				oc.setRealPrice(rs.getInt("realPrice"));
				oc.setPi_dfee(rs.getInt("pi_dfee"));
				oc.setPs_opt(rs.getString("ps_opt"));
				oc.setOcr_sdate(rs.getString("sdate"));
				oc.setOcr_edate(rs.getString("edate"));
				oc.setOcr_period(rs.getInt("ocr_period"));
				oc.setPi_img1(rs.getString("pi_img1"));
				oc.setPi_img2(rs.getString("pi_img2"));
				oc.setPi_img3(rs.getString("pi_img3"));
				oc.setStockList(pvd.getStockList(rs.getString("pi_id")));
				cartList.add(oc);
			}
		} catch(Exception e) {
			System.out.println("CartDao클래스의 getCartList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs); close(stmt);
		}	
		return cartList;
	}
	
	public int cartDel(String where) {
		int result = 0;
		Statement stmt = null;
		try {
			stmt = conn.createStatement();
			String sql = "delete from t_order_cart_rent " + where;
			result = stmt.executeUpdate(sql);
			
			sql = "delete from t_order_cart " + where;
			result = stmt.executeUpdate(sql);
			
		} catch (Exception e) {
			System.out.println("CartDao 클래스의 cartDel() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);
		}
		return result;
	}
	
	public int cartUpdate(String kind, OrderCart oc) {
		Statement stmt = null;
		ResultSet rs = null;
		ResultSet rs2 = null;
		int result = 0;
		try {
			stmt = conn.createStatement();
			String sql = "update t_order_cart set ";
			String where = " where mi_id = '" + oc.getMi_id() + "' ";
			if(oc.getOc_cnt() == 0) {	// 옵션 변경
				String sql1 = "select oc_idx, oc_cnt, pi_id from t_order_cart " + where + 
						" and ps_idx = " + oc.getPs_idx();
				rs = stmt.executeQuery(sql1);
				if(rs.next()) {	// 동일한 옵션의 상품이 있으면
					int sCnt = rs.getInt("oc_cnt");
					int sOcidx = rs.getInt("oc_idx");
					String sPiid = rs.getString("pi_id");
					if (rs.getString("pi_id").substring(0,1).contentEquals("S")) { // 구매상품이면
						sql += " ps_idx = " + oc.getPs_idx() + ", oc_cnt = oc_cnt + " 
								+ sCnt + where + " and oc_idx = " + oc.getOc_idx();
						result = stmt.executeUpdate(sql);
						
						sql = "delete from t_order_cart " + where + " and oc_idx = " + sOcidx;	
						result = stmt.executeUpdate(sql);
					} else { 	// 대여상품이면 
						SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
						java.util.Date sdateCvt = format.parse(oc.getOcr_sdate());
						java.util.Date edateCvt = format.parse(oc.getOcr_edate());
						long diff = edateCvt.getTime() - sdateCvt.getTime();
						long diffDays = diff/(24*60*60*1000);
						
						String sql2 = "select pi_id from t_order_cart_rent " + where + 
								" and pi_id = '" + sPiid + "' and ocr_sdate = '" 
										+ oc.getOcr_sdate() + "' and  ocr_edate = '" 
										+ oc.getOcr_edate() + "' ";
						System.out.println(sql2);
						rs2 = stmt.executeQuery(sql2);
						if (diffDays < 2) {
							diffDays = 2;
							oc.setOcr_edate(format.format(sdateCvt.getTime() + 2*24*60*60*1000));		
						}
						
						if(rs2.next()) {
							sql += " ps_idx = " + oc.getPs_idx() + ", oc_cnt = oc_cnt + " 
									+ sCnt + where + " and oc_idx = " + oc.getOc_idx();
							System.out.println(sql);
							result = stmt.executeUpdate(sql);
							sql = "update t_order_cart_rent set ocr_sdate = '" 
									+ oc.getOcr_sdate() + "', ocr_edate = '" 
									+ oc.getOcr_edate() + "', ocr_period = '" + diffDays + "' " + where 
									+ " and oc_idx = " + oc.getOc_idx();
							result = stmt.executeUpdate(sql);
							
							sql = "delete from t_order_cart_rent " + where + " and oc_idx = " + sOcidx;
							result = stmt.executeUpdate(sql);
							
							sql = "delete from t_order_cart " + where + " and oc_idx = " + sOcidx;
							result = stmt.executeUpdate(sql);
								
						} else {
						sql = "update t_order_cart_rent set ocr_sdate = '" 
								+ oc.getOcr_sdate() + "', ocr_edate = '" 
								+ oc.getOcr_edate() + "', ocr_period = '" + diffDays + "' " + where 
								+ " and oc_idx = " + oc.getOc_idx();
								result = stmt.executeUpdate(sql);
						}
						close(rs2);
					}
					close(rs); 
				} else {		// 동일한 옵션의 상품이 없으면 
					sql += " ps_idx = " + oc.getPs_idx() + where + " and oc_idx = '"
							+ oc.getOc_idx() + "' ";
					result = stmt.executeUpdate(sql);
				}
				
			} else {	// 수량 변경이면
				sql += " oc_cnt = " + oc.getOc_cnt() + where +  " and oc_idx = '" + oc.getOc_idx() + "' ";
				result = stmt.executeUpdate(sql);
			}
			
			
		} catch (Exception e) {
			System.out.println("CartDao클래스의 cartUpdate() 메소드 오류");
			e.printStackTrace();
		} finally {
			  close(stmt);
		}
		return result;
	}
}

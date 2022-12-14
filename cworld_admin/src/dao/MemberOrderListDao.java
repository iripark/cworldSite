package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class MemberOrderListDao {
	private static MemberOrderListDao memberOrderListDao;	
	private Connection conn;			
	private MemberOrderListDao() {}
	public static MemberOrderListDao getInstance() {
		if (memberOrderListDao == null) {
			memberOrderListDao = new MemberOrderListDao();
		}		
		return memberOrderListDao;
	}
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	public int getOrderCount(String where) {
		int rcnt = 0;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "select count(mi_id) from v_order_list where 1 = 1 " + where + " group by oi_id, mi_id ";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				rcnt++;
			}
			System.out.println("rcnt : " + rcnt);
		} catch(Exception e) {
			System.out.println("MemberOrderListDao 클래스의 getOrderCount() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		
		return rcnt;
	}
	public ArrayList<MemberOrderInfo> getOrderList(int cpage, int psize, String where) {
		ArrayList<MemberOrderInfo> memberOrderList = new ArrayList<MemberOrderInfo>();
		MemberOrderInfo moi = null;
		Statement stmt = null;
		ResultSet rs = null;
		int start = psize * (cpage - 1);
		try {
			String sql = "select oi_id, mi_id, oi_rname, oi_rphone, oi_rzip, oi_raddr1, oi_raddr2, oi_memo, oi_payment, sum(oi_pay) oi_pay, sum(oi_upoint) oi_upoint, sum(oi_spoint) oi_spoint, oi_invoice, oi_status, oi_date, pi_id, od_pname, sum(sale) sale, sum(price) price, sum(cost) cost, y, m, d from v_order_list where 1 = 1 " + where + " group by oi_id, mi_id order by oi_date desc limit " + start + ", " + psize;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				moi = new MemberOrderInfo();
				moi.setOi_id(rs.getString("oi_id"));
				moi.setMi_id(rs.getString("mi_id"));
				moi.setOi_rname(rs.getString("oi_rname"));
				moi.setOi_rphone(rs.getString("oi_rphone"));
				moi.setOi_rzip(rs.getString("oi_rzip"));
				moi.setOi_raddr1(rs.getString("oi_raddr1"));
				moi.setOi_raddr2(rs.getString("oi_raddr2"));
				moi.setOi_memo(rs.getString("oi_memo"));
				moi.setOi_payment(rs.getString("oi_payment"));
				moi.setOi_pay(rs.getInt("oi_pay"));
				moi.setOi_upoint(rs.getInt("oi_upoint"));
				moi.setOi_spoint(rs.getInt("oi_spoint"));
				moi.setOi_invoice(rs.getString("oi_invoice"));
				moi.setOi_status(rs.getString("oi_status"));
				moi.setOi_date(rs.getString("oi_date"));
				moi.setPi_id(rs.getString("pi_id"));
				moi.setOd_pname(rs.getString("od_pname"));
				moi.setSale(rs.getInt("sale"));
				moi.setPrice(rs.getInt("price"));
				moi.setCost(rs.getInt("cost"));
				moi.setY(rs.getInt("y"));
				moi.setM(rs.getInt("m"));
				moi.setD(rs.getInt("d"));
				memberOrderList.add(moi);
			}
			
		} catch(Exception e) {
			System.out.println("MemberOrderListDao 클래스의 getOrderList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		return memberOrderList;
	}
	
}

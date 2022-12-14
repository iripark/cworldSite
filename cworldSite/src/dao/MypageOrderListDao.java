package dao;

import static db.jdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class MypageOrderListDao {
	private static MypageOrderListDao mypageOrderListDao;	
	private Connection conn;
	private MypageOrderListDao() {}
	public static MypageOrderListDao getInstance() {
		if (mypageOrderListDao == null) {
			mypageOrderListDao = new MypageOrderListDao();
		}
		return mypageOrderListDao;
	}
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	public int getOrderListCount(String miid) {
		int rcnt = 0;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "select count(*) from v_order_info where mi_id = '" + miid + "'";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			rs.next();
			rcnt = rs.getInt(1);
		} catch(Exception e) {
			System.out.println("MypageOrderListDao 클래스의 getOrderListCount() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		
		return rcnt;
	}
	public ArrayList<MypageOrderInfo> getOrderList(String miid, int cpage, int psize) {
		ArrayList<MypageOrderInfo> ol = new ArrayList<MypageOrderInfo>();
		MypageOrderInfo moi = null;
		Statement stmt = null;
		ResultSet rs = null;
		int start = psize * (cpage - 1);
		try {
			String sql = "select * from v_order_info where mi_id = '" + miid + "' order by oi_date desc limit " + start + ", " + psize;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				moi = new MypageOrderInfo();
				moi.setMi_id(rs.getString("mi_id"));
				moi.setOi_id(rs.getString("oi_id"));
				moi.setPi_id(rs.getString("pi_id"));
				moi.setPs_idx(rs.getInt("ps_idx"));
				moi.setVimg(rs.getString("vimg"));
				moi.setVname(rs.getString("vname"));
				moi.setPs_opt(rs.getString("ps_opt"));
				moi.setVcnt(rs.getInt("vcnt"));
				moi.setVprice(rs.getInt("vprice"));
				moi.setOi_date(rs.getString("oi_date"));
				moi.setIsReview(rs.getInt("rl_idx"));
				ol.add(moi);
			}
		
		} catch(Exception e) {
			System.out.println("MypageOrderListDao 클래스의 getOrderList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		
		return ol;
	}
}

package dao;

import static db.jdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class MypageRentListDao {
	private static MypageRentListDao mypageRentListDao;	
	private Connection conn;
	private MypageRentListDao() {}
	public static MypageRentListDao getInstance() {
		if (mypageRentListDao == null) {
			mypageRentListDao = new MypageRentListDao();
		}
		return mypageRentListDao;
	}
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	public int getRentListCount(String miid) {
		int rcnt = 0;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "select count(*) from t_order_info a, t_order_rent_detail b where a.oi_id = b.oi_id and a.mi_id = '" + miid + "'";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			rs.next();
			rcnt = rs.getInt(1);
		} catch(Exception e) {
			System.out.println("MypageRentListDao 클래스의 getRentListCount() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		
		return rcnt;
	}
	public ArrayList<MypageRentInfo> getRentList(String miid, int cpage, int psize) {
		ArrayList<MypageRentInfo> mrl = new ArrayList<MypageRentInfo>();
		MypageRentInfo mri = null;
		Statement stmt = null;
		ResultSet rs = null;
		int start = psize * (cpage - 1);
		try {
			String sql = "select * from t_order_info a, t_order_rent_detail b where a.oi_id = b.oi_id and a.mi_id = '" + miid + "' order by oi_date desc limit " + start + ", " + psize;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				mri = new MypageRentInfo();
				mri.setOrd_idx(rs.getInt("ord_idx"));
				mri.setOi_id(rs.getString("oi_id"));
				mri.setPi_id(rs.getString("pi_id"));
				mri.setPs_idx(rs.getInt("ps_idx"));
				mri.setOrd_cnt(rs.getInt("ord_cnt"));
				mri.setOrd_price(rs.getInt("ord_price"));
				mri.setOrd_pname(rs.getString("ord_pname"));
				mri.setOrd_pimg(rs.getString("ord_pimg"));
				mri.setOrd_sdate(rs.getString("ord_sdate"));
				mri.setOrd_edate(rs.getString("ord_edate"));
				mri.setOrd_redate(rs.getString("ord_redate"));
				mri.setOrd_isreturn(rs.getString("ord_isreturn"));
				mrl.add(mri);
			}
		
		} catch(Exception e) {
			System.out.println("MypageRentListDao 클래스의 getRentList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		
		return mrl;
	}
}

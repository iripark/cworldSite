package dao;

import static db.jdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class GReviewListDao {
	private static GReviewListDao gReviewListDao;	
	private Connection conn;			
	private GReviewListDao() {}
	public static GReviewListDao getInstance() {
		if (gReviewListDao == null) {
			gReviewListDao = new GReviewListDao();
		}		
		return gReviewListDao;
	}
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	public int getGreviewCount() {
		int rcnt = 0;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "select count(*) from t_group_review where gr_isview = 'y' ";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			rs.next();
			rcnt = rs.getInt(1);
		} catch(Exception e) {
			System.out.println("GReviewListDao 클래스의 getGreviewCount() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		return rcnt;
	}
	
	public ArrayList<GReviewInfo> getReviewList(int cpage, int psize) {
		ArrayList<GReviewInfo> GReviewInfo = new ArrayList<GReviewInfo>();
		GReviewInfo gri = null;
		Statement stmt =null;
		ResultSet rs = null;
		int start = psize * (cpage - 1);
		try {
			String sql = "select *, if(date(gr_date) = curdate(), right(gr_date, 8), date(gr_date)) wdate from t_group_review where gr_isview = 'y' order by gr_date desc limit "  + start + ", " + psize;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				gri = new GReviewInfo();
				gri.setGr_idx(rs.getInt("gr_idx"));
				gri.setMi_id(rs.getString("mi_id"));
				gri.setGq_idx(rs.getInt("gq_idx"));
				gri.setGq_gname(rs.getString("gq_gname"));
				gri.setGr_title(rs.getString("gr_title"));
				gri.setGr_img(rs.getString("gr_img"));
				gri.setGr_content(rs.getString("gr_content"));
				gri.setGr_date(rs.getString("wdate"));
				gri.setGr_isview(rs.getString("gr_isview"));
				GReviewInfo.add(gri);
			}
			
		} catch(Exception e) {
			System.out.println("GReviewListDao 클래스의 getReviewList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		
		return GReviewInfo;
	}
	public int GReviewListInsert(GReviewInfo greviewInfo) {
		int result = 0, idx = 1;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.createStatement();
			String sql = "select max(gr_idx) from t_group_review";
			rs = stmt.executeQuery(sql);
			if(rs.next()) {
				idx = rs.getInt(1) + 1;
			}
			sql = "insert into t_group_review(gr_idx, gr_title, gr_gname, gr_date) values (" + idx + ", '" + greviewInfo.getGr_title() + ", '" + greviewInfo.getGq_gname() + ", '" + greviewInfo.getGr_date() + "')"; 
			result = stmt.executeUpdate(sql);
			if (result == 0) {
				return result;
			} else {
				result = idx;
			}
		} catch(Exception e) {
			System.out.println("GReviewListDao 클래스의 GReviewListInsert() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		
		return result;
	}
		
	public GReviewInfo getGReviewInfo(int idx) {
		Statement stmt = null;
		ResultSet rs = null;
		GReviewInfo gri = null;
		
		try {
			stmt = conn.createStatement();
			String sql = "select * from t_group_review limit ";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				gri = new GReviewInfo();
				gri.setGr_idx(rs.getInt("gr_idx"));
				gri.setMi_id(rs.getString("mi_id"));
				gri.setGq_idx(rs.getInt("gq_idx"));
				gri.setGq_gname(rs.getString("gq_gname"));
				gri.setGr_title(rs.getString("gr_title"));
				gri.setGr_img(rs.getString("gr_img"));
				gri.setGr_content(rs.getString("gr_content"));
				gri.setGr_date(rs.getString("gr_date"));
				gri.setGr_isview(rs.getString("gr_isview"));
			}
		} catch(Exception e) {
			System.out.println("GReviewListDao 클래스의 getGReviewInfo() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		
		return gri;
	}
}

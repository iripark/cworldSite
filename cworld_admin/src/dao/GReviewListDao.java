package dao;

import static db.JdbcUtil.*;
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
	public int getGReviewCount(String where) {
		int rcnt = 0;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "select count(*) from t_group_review where 1=1 " + where;
			
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			rs.next();
			rcnt = rs.getInt(1);
		} catch(Exception e) {
			System.out.println("GReviewListDao 클래스의 getGReviewCount() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		
		return rcnt;
	}
	public ArrayList<GReviewInfo> getGReviewList(int cpage, int psize, String where) {
		ArrayList<GReviewInfo> grl = new ArrayList<GReviewInfo>();
		GReviewInfo gri = null;
		Statement stmt = null;
		ResultSet rs = null;
		int start = psize * (cpage - 1);
		try {
			String sql = "select * from t_group_review where 1=1 " + where + " order by gr_date desc limit " + start + ", " + psize;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				gri = new GReviewInfo();
				gri.setGr_idx(rs.getInt("gr_idx"));
				gri.setMi_id(rs.getString("mi_id"));
				gri.setGq_idx(rs.getInt("gq_idx"));
				gri.setGq_gname(rs.getString("gq_gname"));
				gri.setGr_title(rs.getString("gr_title"));
				gri.setGr_img(rs.getString("gr_img"));
				gri.setGr_content(rs.getString("gr_content"));
				gri.setGr_date(rs.getString("gr_date"));
				gri.setGr_ip(rs.getString("gr_ip"));
				gri.setGr_isview(rs.getString("gr_isview"));

				grl.add(gri);
			}
		}  catch(Exception e) {
			System.out.println("GQnaListDao 클래스의 getGQnaList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		return grl;
	}
	
}

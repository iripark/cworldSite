package dao;

import static db.jdbcUtil.*;
import java.sql.*;
import java.util.*;
import vo.*;

public class GReviewViewDao {
	private static GReviewViewDao gReviewViewDao;	
	private Connection conn;
	private GReviewViewDao() {}
	public static GReviewViewDao getInstance() {
		if (gReviewViewDao == null) {
			gReviewViewDao = new GReviewViewDao();
		}
		return gReviewViewDao;
	}
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	public GReviewInfo getGReviewInfo(int idx) {
		GReviewInfo gri = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "select * from t_group_review where gr_isview = 'y' and gr_idx = " + idx;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next()) {
				gri = new GReviewInfo();
				gri.setGq_gname(rs.getString("gq_gname"));
				gri.setGq_idx(rs.getInt("gq_idx"));
				gri.setGr_content(rs.getString("gr_content"));
				gri.setGr_date(rs.getString("gr_date"));
				gri.setGr_idx(rs.getInt("gr_idx"));
				gri.setGr_img(rs.getString("gr_img"));
				gri.setGr_ip(rs.getString("gr_ip"));
				gri.setGr_isview(rs.getString("gr_isview"));
				gri.setGr_title(rs.getString("gr_title"));
				gri.setMi_id(rs.getString("mi_id"));
			}
		} catch(Exception e) {
			System.out.println("GReviewViewDao클래스의 getGReviewInfo() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs); 
			close(stmt);
		}
		
		return gri;
	}
	
}

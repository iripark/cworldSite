package dao;

import static db.jdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class GReviewProcInDao {
	private static GReviewProcInDao gReviewProcInDao;
	private Connection conn;
	private GReviewProcInDao() {}
	
	public static GReviewProcInDao getInstance() {
		if (gReviewProcInDao == null) {
			gReviewProcInDao = new GReviewProcInDao();
		}
		return gReviewProcInDao;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}

	public int gReviewInsert(GReviewInfo gri) {
		Statement stmt = null;
		ResultSet rs = null;
		int result = 0, idx = 1;
		
		try {
			stmt = conn.createStatement();
			String sql = "select max(gr_idx) from t_group_review";
			rs = stmt.executeQuery(sql);
			if(rs.next())	idx = rs.getInt(1) + 1;
			
			sql = "insert into t_group_review (gr_idx, mi_id, gq_idx, gq_gname, gr_title, gr_img, gr_content, gr_ip) values(" + idx + ", '" + gri.getMi_id() + "', '" + gri.getGq_idx() + "', '" + gri.getGq_gname() + "', '" + gri.getGr_title() + "', '" + gri.getGr_img() + "', '" + gri.getGr_content() + "', '" + gri.getGr_ip() + "');";
			result = stmt.executeUpdate(sql);
			if (result == 0) {
				return result;
			} else {
				result = idx;
			}
			
		} catch(Exception e) {
			System.out.println("GReviewProcInDao 클래스의 gReviewInsert() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}
		return result;
	}
}

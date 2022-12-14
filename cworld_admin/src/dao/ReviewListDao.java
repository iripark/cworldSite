package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class ReviewListDao {
	private static ReviewListDao reviewListDao;	
	private Connection conn;			
	private ReviewListDao() {}
	public static ReviewListDao getInstance() {
		if (reviewListDao == null) {
			reviewListDao = new ReviewListDao();
		}		
		return reviewListDao;
	}
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	public int getReviewCount(String where) {
		int rcnt = 0;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "select count(rl_idx) from t_review_list where 1=1 " + where;
			
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			rs.next();
			rcnt = rs.getInt(1);
		} catch(Exception e) {
			System.out.println("ReviewListDao 클래스의 getReviewCount() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		
		return rcnt;
	}
	public ArrayList<ReviewInfo> getReviewList(int cpage, int psize, String where) {
		ArrayList<ReviewInfo> rl = new ArrayList<ReviewInfo>();
		ReviewInfo ri = null;
		Statement stmt = null;
		ResultSet rs = null;
		int start = psize * (cpage - 1);
		try {
			String sql = "select * from t_review_list where 1=1 " + where + " order by rl_date desc limit " + start + ", " + psize;
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
				ri.setRl_date(rs.getString("rl_date"));
				ri.setRl_isview(rs.getString("rl_isview"));
				rl.add(ri);
			}
		} catch(Exception e) {
			System.out.println("ReviewListDao 클래스의 getReviewList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		return rl;
	}
	
}

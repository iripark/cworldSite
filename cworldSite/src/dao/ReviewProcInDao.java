package dao;

import static db.jdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class ReviewProcInDao {
	private static ReviewProcInDao reviewProcInDao;	
	private Connection conn;
	private ReviewProcInDao() {}
	public static ReviewProcInDao getInstance() {
		if (reviewProcInDao == null) {
			reviewProcInDao = new ReviewProcInDao();
		}
		return reviewProcInDao;
	}
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	public int reviewInsert(ReviewInfo ri) {
		int result = 0, idx = 1, upSet = 0;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "select max(rl_idx) from t_review_list";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if(rs.next()) {
				idx = rs.getInt(1) + 1;
				rs.close();
			}
			sql = "insert into t_review_list (rl_idx, mi_id, oi_id, pi_id, ps_idx, rl_pname, rl_title, rl_content, rl_img, rl_score, rl_ip) "
					+ "values (" + idx + ", '" + ri.getMi_id() + "', '" + ri.getOi_id() + "', '" + ri.getPi_id() + "', " + ri.getPs_idx() + ", '" + ri.getRl_pname() + "', '" + ri.getRl_title() + "', '" + ri.getRl_content() + "', '" + ri.getRl_img() + "', " + ri.getRl_score() + ", '" + ri.getRl_ip() + "')";
			result = stmt.executeUpdate(sql);
			if (result == 0) {
				return result;
			} else {
				result = idx;
			}
			sql = "select format(avg(rl_score), 1) avg, count(*) from t_review_list where pi_id = '" + ri.getPi_id() + "'";
			rs = stmt.executeQuery(sql);
			double avg = 0;
			int cnt = 0;
			if(rs.next()) {
				avg = rs.getDouble(1);
				cnt = rs.getInt(2);
			}
			sql = "update t_product_info set pi_score = " + avg + ", pi_review = " + cnt + " where pi_id = '" + ri.getPi_id() + "'";
			upSet = stmt.executeUpdate(sql);
			if (upSet > 0) {
				upSet = 0;
				if (!ri.getRl_img().equals("")) {
					sql = "update t_member_info set mi_point = mi_point + 200 where mi_id = '" + ri.getMi_id() + "'";
				} else {
					sql = "update t_member_info set mi_point = mi_point + 100 where mi_id = '" + ri.getMi_id() + "'";
				}
				upSet = stmt.executeUpdate(sql);
				if (upSet > 0) {
					if (!ri.getRl_img().equals("")) {
						sql = "insert into t_member_point (mi_id, mp_issu, mp_point, mp_desc, mp_num) values ('" + ri.getMi_id() + "', 's', " + 200 + ", '사진리뷰작성', '" + idx + "')";
					} else {
						sql = "insert into t_member_point (mi_id, mp_issu, mp_point, mp_desc, mp_num) values ('" + ri.getMi_id() + "', 's', " + 100 + ", '리뷰작성', '" + idx + "')";
					}
					upSet = stmt.executeUpdate(sql);
				}
			}

			
		} catch(Exception e) {
			System.out.println("ReviewProcInDao클래스의 reviewInsert() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);	
			close(stmt);
		}
		
		return idx;
	}
}

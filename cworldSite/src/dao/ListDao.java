package dao;

import static db.jdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class ListDao {
	private static ListDao listDao;	
	private Connection conn;			
	private ListDao() {}
	public static ListDao getInstance() {
		if (listDao == null) {
			listDao = new ListDao();
		}		
		return listDao;
	}
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	public int getNoticeCount() {
		int rcnt = 0;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "select count(*) from t_notice_list where nl_isview = 'y'";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			rs.next();
			rcnt = rs.getInt(1);
		} catch(Exception e) {
			System.out.println("ListDao 클래스의 getNoticeCount() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		return rcnt;
	}
	public ArrayList<NoticeInfo> getNoticeList(int cpage, int psize) {
		ArrayList<NoticeInfo> noticeList = new ArrayList<NoticeInfo>();
		NoticeInfo ni = null;
		Statement stmt =null;
		ResultSet rs = null;
		int start = psize * (cpage - 1);
		try {
			String sql = "select a.nl_idx, a.nl_ctgr, a.ai_idx, a.nl_title, a.nl_content, a.nl_read, if(date(a.nl_date) = curdate(), right(a.nl_date, 8), date(a.nl_date)) wdate, a.nl_isview, b.ai_name from t_notice_list a, t_admin_info b where a.ai_idx = b.ai_idx and a.nl_isview = 'y' order by nl_date desc limit " + start + ", " + psize;
			stmt = conn.createStatement();															// if(date(a.nl_date) = curdate(), right(a.nl_date, 8), date(a.nl_date)) wdate
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				ni = new NoticeInfo();
				ni.setNl_idx(rs.getInt("nl_idx"));
				ni.setNl_ctgr(rs.getString("nl_ctgr"));
				ni.setAi_idx(rs.getInt("ai_idx"));
				ni.setNl_title(rs.getString("nl_title"));
				ni.setNl_content(rs.getString("nl_content"));
				ni.setNl_read(rs.getInt("nl_read"));
				ni.setNl_date(rs.getString("wdate"));
				ni.setNl_isview(rs.getString("nl_isview"));
				ni.setAi_name(rs.getString("ai_name"));
				noticeList.add(ni);
			}
			
		} catch(Exception e) {
			System.out.println("ListDao 클래스의 getNoticeList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		
		return noticeList;
	}
	public int readUpdate(int idx) {
		int result = 0;
		Statement stmt = null;
		try {
			stmt = conn.createStatement();
			String sql = "update t_notice_list set nl_read = nl_read + 1 where nl_idx = " + idx;
			result = stmt.executeUpdate(sql);
		} catch(Exception e) {
			System.out.println("ListDao 클래스의 readUpdate() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);
		}
		
		return result;
	}
	public NoticeInfo getNoticeInfo(int idx) {
		Statement stmt = null;
		ResultSet rs = null;
		NoticeInfo ni = null;
		
		try {
			stmt = conn.createStatement();
			String sql = "select a.*, b.ai_name from t_notice_list a, t_admin_info b where a.ai_idx = b.ai_idx and nl_idx = " + idx;
			rs = stmt.executeQuery(sql);
			if (rs.next()) {	// 게시글이 있으면
				ni = new NoticeInfo();
				ni.setNl_idx(idx);
				ni.setAi_name(rs.getString("ai_name"));
				ni.setNl_ctgr(rs.getString("nl_ctgr"));
				ni.setAi_idx(rs.getInt("ai_idx"));
				ni.setAi_name(rs.getString("ai_name"));
				ni.setNl_title(rs.getString("nl_title"));
				ni.setNl_content(rs.getString("nl_content"));
				ni.setNl_read(rs.getInt("nl_read"));
				ni.setNl_date(rs.getString("nl_date"));
				ni.setNl_isview(rs.getString("nl_isview"));				
			} 
		} catch(Exception e) {
			System.out.println("ListDao 클래스의 getNoticeInfo() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		
		return ni;
	}
	public int getReviewCount(String where) {
		int rcnt = 0;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "select count(*) from t_review_list " + where;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			rs.next();
			rcnt = rs.getInt(1);
		} catch(Exception e) {
			System.out.println("ListDao 클래스의 getReviewCount() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		
		return rcnt;
	}
	public ArrayList<ReviewInfo> getReviewList(String where, int cpage, int psize) {
		ArrayList<ReviewInfo> reviewList = new ArrayList<ReviewInfo>();
		ReviewInfo ri = null;
		Statement stmt = null;
		ResultSet rs = null;
		int start = psize * (cpage - 1);
		
		try {
			String sql = "select rl_idx, mi_id, rl_pname, rl_score, rl_title, rl_read, if(date(rl_date) = curdate(), right(rl_date, 8), date(rl_date)) wdate from t_review_list " + where + " order by rl_idx desc limit " + start + ", " + psize;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				ri = new ReviewInfo();
				ri.setRl_idx(rs.getInt("rl_idx"));
				ri.setMi_id(rs.getString("mi_id"));
				ri.setRl_pname(rs.getString("rl_pname"));
				ri.setRl_score(rs.getDouble("rl_score"));
				ri.setRl_title(rs.getString("rl_title"));
				ri.setRl_read(rs.getInt("rl_read"));
				ri.setRl_date(rs.getString("wdate"));
				reviewList.add(ri);
			} 
			
		} catch(Exception e) {
			System.out.println("ListDao 클래스의 getReviewList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		return reviewList;
	}
	public int readUpdateReview(int idx) {
		int result = 0;
		Statement stmt = null;
		try {
			stmt = conn.createStatement();
			String sql = "update t_review_list set rl_read = rl_read + 1 where rl_idx = " + idx;
			result = stmt.executeUpdate(sql);
		} catch(Exception e) {
			System.out.println("ListDao 클래스의 readUpdateReview() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);
		}
		
		return result;
	}
	public ReviewInfo getReviewInfo(int idx) {
		ReviewInfo ri = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.createStatement();
			String sql = "select * from t_review_list where rl_isview = 'y' and rl_idx = " + idx;
			rs = stmt.executeQuery(sql);
			if (rs.next()) {	// 게시글이 있으면
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

			} 
		} catch(Exception e) {
			System.out.println("ListDao 클래스의 getReviewInfo() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		
		return ri;
	}
	public ArrayList<PdtInfo> getJjimList(String miid) {
		ArrayList<PdtInfo> jl = new  ArrayList<PdtInfo>();
		PdtInfo pi = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "select a.pi_id, a.pi_img1, a.pi_name, a.pi_dcprice, b.mj_date from t_product_info a, t_member_jjim b where a.pi_id = b.pi_id and b.mi_id = '" + miid + "'";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				pi = new PdtInfo();
				pi.setPi_id(rs.getString("pi_id"));
				pi.setPi_img1(rs.getString("pi_img1"));
				pi.setPi_name(rs.getString("pi_name"));
				pi.setRealPrice(rs.getInt("pi_dcprice"));
				pi.setMj_date(rs.getString("mj_date"));
				jl.add(pi);
			}
		} catch(Exception e) {
			System.out.println("ListDao 클래스의 getJjimList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		
		return jl;
	}
	public int getMyReviewCount(String miid) {
		int rcnt = 0;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "select count(*) from t_review_list where mi_id = '" + miid + "'";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			rs.next();
			rcnt = rs.getInt(1);
		} catch(Exception e) {
			System.out.println("ListDao 클래스의 getMyReviewCount() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		
		return rcnt;
	}
	public ArrayList<ReviewInfo> getMyReviewList(String miid, int cpage, int psize) {
		ArrayList<ReviewInfo> reviewList = new ArrayList<ReviewInfo>();
		ReviewInfo ri = null;
		Statement stmt = null;
		ResultSet rs = null;
		int start = psize * (cpage - 1);
		
		try {
			String sql = "select rl_idx, mi_id, rl_pname, rl_score, rl_title, rl_read, if(date(rl_date) = curdate(), right(rl_date, 8), date(rl_date)) wdate from t_review_list where mi_id = '" + miid + "' order by rl_idx desc limit " + start + ", " + psize;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				ri = new ReviewInfo();
				ri.setRl_idx(rs.getInt("rl_idx"));
				ri.setMi_id(rs.getString("mi_id"));
				ri.setRl_title(rs.getString("rl_title"));
				ri.setRl_pname(rs.getString("rl_pname"));
				ri.setRl_score(rs.getDouble("rl_score"));
				ri.setRl_read(rs.getInt("rl_read"));
				ri.setRl_date(rs.getString("wdate"));
				reviewList.add(ri);
			} 
			
		} catch(Exception e) {
			System.out.println("ListDao 클래스의 getReviewList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		return reviewList;
	}
	
}

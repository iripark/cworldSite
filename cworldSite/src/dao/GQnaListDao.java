package dao;

import static db.jdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class GQnaListDao {
	private static GQnaListDao gqnaListDao;	
	private Connection conn;			
	private GQnaListDao() {}
	public static GQnaListDao getInstance() {
		if (gqnaListDao == null) {
			gqnaListDao = new GQnaListDao();
		}		
		return gqnaListDao;
	}
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	public int getGqnaCount() {
		int rcnt = 0;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "select count(*) from t_group_qna where gq_isview = 'y'";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			rs.next();
			rcnt = rs.getInt(1);
		} catch(Exception e) {
			System.out.println("GQnaListDao 클래스의 getGqnaCount() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		return rcnt;
	}
	
	public ArrayList<GqnaInfo> getGqnaList(int cpage, int psize) {
		ArrayList<GqnaInfo> GqnaInfo = new ArrayList<GqnaInfo>();
		GqnaInfo gi = null;
		Statement stmt =null;
		ResultSet rs = null;
		int start = psize * (cpage - 1);
		try {
			String sql = "select gq_idx, mi_id, gq_title, gq_gname, if(date(gq_date) = curdate(), right(gq_date, 8), date(gq_date)) wdate, gq_phone, gq_ef, gq_content, gq_ip, gq_isview, gq_isreply from t_group_qna where gq_isview = 'y' order by gq_date desc limit "  + start + ", " + psize;
			stmt = conn.createStatement();							// if(date(gq_date) = curdate(), right(gq_date, 8), date(gq_date)) wdate
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				gi = new GqnaInfo();
				gi.setGq_idx(rs.getInt("gq_idx"));
				gi.setGq_title(rs.getString("gq_title"));
				gi.setMi_id(rs.getString("mi_id"));
				gi.setGq_gname(rs.getString("gq_gname"));
				gi.setGq_date(rs.getString("wdate"));
				gi.setGq_phone(rs.getString("gq_phone"));
				gi.setGq_ef(rs.getString("gq_ef"));
				gi.setGq_content(rs.getString("gq_content"));
				gi.setGq_ip(rs.getString("gq_ip"));
				gi.setGq_isview(rs.getString("gq_isview"));
				gi.setGq_isreply(rs.getString("gq_isreply"));
				GqnaInfo.add(gi);
			}
			
		} catch(Exception e) {
			System.out.println("GQnaListDao 클래스의 getGqnaList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		
		return GqnaInfo;
	}
	public int GqnaListInsert(GqnaInfo gqnaInfo) {
		int result = 0, idx = 1;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.createStatement();
			String sql = "select max(nl_idx) from t_group_qna";
			rs = stmt.executeQuery(sql);
			if(rs.next()) {
				idx = rs.getInt(1) + 1;
			}
			sql = "insert into t_group_qna(gq_idx, gq_title, gq_gname, gq_date) values (" + idx + ", '" + gqnaInfo.getGq_title() + ", '" + gqnaInfo.getGq_gname() + ", '" + gqnaInfo.getGq_date() + "')";
			result = stmt.executeUpdate(sql);
			if (result == 0) {
				return result;
			} else {
				result = idx;
			}
		} catch(Exception e) {
			System.out.println("GQnaListDao 클래스의 gqnaInsert() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		
		return result;
	}
		
	public GqnaInfo getGqnaInfo(int idx) {
		Statement stmt = null;
		ResultSet rs = null;
		GqnaInfo gi = null;
		
		try {
			stmt = conn.createStatement();
			String sql = "select gq_idx, mi_id, gq_title, gq_gname, if(date(gq_date) = curdate(), right(gq_date, 8), date(gq_date)) wdate, gq_phone, gq_ef, gq_content, gq_ip, gq_isview, gq_isreply, gq_pay from t_group_qna where gq_isview = 'y' and gq_idx = " + idx;
			rs = stmt.executeQuery(sql);							// if(date(gq_date) = curdate(), right(gq_date, 8), date(gq_date)) wdate
			if (rs.next()) {	// 게시글이 있으면
				gi = new GqnaInfo();
				gi.setGq_idx(idx);
				gi.setGq_title(rs.getString("gq_title"));
				gi.setMi_id(rs.getString("mi_id"));
				gi.setGq_gname(rs.getString("gq_gname"));
				gi.setGq_date(rs.getString("wdate"));
				gi.setGq_phone(rs.getString("gq_phone"));
				gi.setGq_ef(rs.getString("gq_ef"));
				gi.setGq_content(rs.getString("gq_content"));
				gi.setGq_ip(rs.getString("gq_ip"));
				gi.setGq_isview(rs.getString("gq_isview"));
				gi.setGq_isreply(rs.getString("gq_isreply"));	
				gi.setGq_pay(rs.getString("gq_pay"));
			} 
		} catch(Exception e) {
			System.out.println("GQnaListDao 클래스의 getGqnaInfo() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		
		return gi;
	}
	public int getMyGqnaCount(String miid) {
		int rcnt = 0;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "select count(*) from t_group_qna where gq_isview = 'y' and mi_id = '" + miid + "'";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			rs.next();
			rcnt = rs.getInt(1);
		} catch(Exception e) {
			System.out.println("GQnaListDao 클래스의 getMyGqnaCount() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		return rcnt;
	}
	public ArrayList<GqnaInfo> getMyGqnaList(String miid, int cpage, int psize) {
		ArrayList<GqnaInfo> GqnaInfo = new ArrayList<GqnaInfo>();
		GqnaInfo gi = null;
		Statement stmt = null;
		ResultSet rs = null;
		int start = psize * (cpage - 1);
		try {
			String sql = "select gq_idx, mi_id, gq_title, gq_gname, if(date(gq_date) = curdate(), right(gq_date, 8), date(gq_date)) wdate, gq_phone, gq_ef, gq_content, gq_ip, gq_isview, gq_isreply from t_group_qna where gq_isview = 'y' and mi_id = '" + miid + "' order by gq_date desc limit "  + start + ", " + psize;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				gi = new GqnaInfo();
				gi.setGq_idx(rs.getInt("gq_idx"));
				gi.setGq_title(rs.getString("gq_title"));
				gi.setMi_id(rs.getString("mi_id"));
				gi.setGq_gname(rs.getString("gq_gname"));
				gi.setGq_date(rs.getString("wdate"));
				gi.setGq_phone(rs.getString("gq_phone"));
				gi.setGq_ef(rs.getString("gq_ef"));
				gi.setGq_content(rs.getString("gq_content"));
				gi.setGq_ip(rs.getString("gq_ip"));
				gi.setGq_isview(rs.getString("gq_isview"));
				gi.setGq_isreply(rs.getString("gq_isreply"));
				GqnaInfo.add(gi);
			}
			
		} catch(Exception e) {
			System.out.println("GQnaListDao 클래스의 getMyGqnaList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		
		return GqnaInfo;
	}
	public String getWriter(int idx) {
		String writer = "";
		Statement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "select mi_id from t_group_qna where gq_idx = " + idx;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next()) {
				writer = rs.getString("mi_id");
			}
		} catch(Exception e) {
			System.out.println("GQnaListDao 클래스의 getWriter() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		
		return writer;
	}
}
package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class GQnaListDao {
	private static GQnaListDao gQnaListDao;	
	private Connection conn;			
	private GQnaListDao() {}
	public static GQnaListDao getInstance() {
		if (gQnaListDao == null) {
			gQnaListDao = new GQnaListDao();
		}		
		return gQnaListDao;
	}
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	public int getGQnaCount(String where) {
		int rcnt = 0;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "select count(*) from t_group_qna where 1=1 " + where;
			
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			rs.next();
			rcnt = rs.getInt(1);
		} catch(Exception e) {
			System.out.println("GQnaListDao 클래스의 getGQnaCount() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		
		return rcnt;
	}
	public ArrayList<GQnaInfo> getGQnaList(int cpage, int psize, String where) {
		ArrayList<GQnaInfo> gql = new ArrayList<GQnaInfo>();
		GQnaInfo gqi = null;
		Statement stmt = null;
		ResultSet rs = null;
		int start = psize * (cpage - 1);
		try {
			String sql = "select * from t_group_qna where 1=1 " + where + " order by gq_date desc limit " + start + ", " + psize;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				gqi = new GQnaInfo();
				gqi.setGq_idx(rs.getInt("gq_idx"));
				gqi.setMi_id(rs.getString("mi_id"));
				gqi.setGq_title(rs.getString("gq_title"));
				gqi.setGq_gname(rs.getString("gq_gname"));
				gqi.setGq_phone(rs.getString("gq_phone"));
				gqi.setGq_ef(rs.getString("gq_ef"));
				gqi.setGq_content(rs.getString("gq_content"));
				gqi.setGq_date(rs.getString("gq_date"));
				gqi.setGq_ip(rs.getString("gq_ip"));
				gqi.setGq_isview(rs.getString("gq_isview"));
				gqi.setGq_isreply(rs.getString("gq_isreply"));
				gqi.setGq_pay(rs.getString("gq_pay"));
				gql.add(gqi);
			}
		}  catch(Exception e) {
			System.out.println("GQnaListDao 클래스의 getGQnaList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		return gql;
	}
	
}

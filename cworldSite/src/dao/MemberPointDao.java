package dao;

import static db.jdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class MemberPointDao {
	private static MemberPointDao memberPointDao;	
	private Connection conn;
	private MemberPointDao() {}
	public static MemberPointDao getInstance() {
		if (memberPointDao == null) {
			memberPointDao = new MemberPointDao();
		}
		return memberPointDao;
	}
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	public ArrayList<MemberPoint> getPointList(String miid, int cpage, int psize) {
		ArrayList<MemberPoint> pointList = new ArrayList<MemberPoint>();
		MemberPoint mp = null;
		Statement stmt = null;
		ResultSet rs = null;
		int start = psize * (cpage - 1);
		try {
			String sql = "select * from t_member_point where mi_id = '" + miid + "' order by mp_date desc limit " + start + ", " + psize;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				mp = new MemberPoint();
				mp.setMp_idx(rs.getInt("mp_idx"));
				mp.setMi_id(rs.getString("mi_id"));
				mp.setMp_issu(rs.getString("mp_issu"));
				mp.setMp_point(rs.getInt("mp_point"));
				mp.setMp_desc(rs.getString("mp_desc"));
				mp.setMp_num(rs.getString("mp_num"));
				mp.setMp_date(rs.getString("mp_date"));
				
				pointList.add(mp);
			}
		} catch(Exception e) {
			System.out.println("MemberPointDao클래스의 getPointList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);	
			close(stmt);
		}
		
		return pointList;
	}
	public int getPointCount(String miid) {
		int rcnt = 0;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "select count(*) from t_member_point where mi_id = '" + miid + "' ";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			rs.next();
			rcnt = rs.getInt(1);
		} catch(Exception e) {
			System.out.println("MemberPointDao클래스의 getPointCount() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);	
			close(stmt);
		}
		
		
		return rcnt;
	}
	public int getTotalPoint(String miid) {
		int total = 0;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "select mi_point from t_member_info where mi_id = '" + miid + "' ";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			rs.next();
			total = rs.getInt(1);
		} catch(Exception e) {
			System.out.println("MemberPointDao클래스의 getTotalPoint() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);	
			close(stmt);
		}
		
		
		return total;
	}	
	
}	

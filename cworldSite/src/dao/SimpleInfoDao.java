package dao;

import static db.jdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class SimpleInfoDao {
	private static SimpleInfoDao simpleInfoDao;	
	private Connection conn;
	private SimpleInfoDao() {}
	public static SimpleInfoDao getInstance() {
		if (simpleInfoDao == null) {
			simpleInfoDao = new SimpleInfoDao();
		}
		return simpleInfoDao;
	}
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	public String getSimple(String miid) {
		String simpleOrder = "";
		Statement stmt = null;
		ResultSet rs = null;
		int a = 0, b = 0, c = 0, d = 0;
		try {
			stmt = conn.createStatement();
			String sql = "select oi_status from t_order_info where mi_id = '" + miid + "' ";
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				if (rs.getString("oi_status").equals("a")) {
					a += 1;
				} else if (rs.getString("oi_status").equals("c")) {
					b += 1;
				} else if (rs.getString("oi_status").equals("d")) {
					c += 1;
				} else if (rs.getString("oi_status").equals("e")) {
					d += 1;
				} 
			}
			simpleOrder = a + "," + b + "," + c + "," + d;
			
		} catch(Exception e) {
			System.out.println("SimpleInfoDao클래스의 getSimple() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}	
		
		return simpleOrder;
	}
	public int getPoint(String miid) {
		int mipoint = 0;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement();
			String sql = "select mi_point from t_member_info where mi_id = '" + miid + "' ";
			rs = stmt.executeQuery(sql);
			if (rs.next()) {
				mipoint = rs.getInt(1);
			}
			
		} catch(Exception e) {
			System.out.println("SimpleInfoDao클래스의 getSimple() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}	
		return mipoint;
	}	
	
}

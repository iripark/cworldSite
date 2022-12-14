package dao;

import static db.jdbcUtil.*;
import java.sql.*;

public class FindDao {
	private static FindDao findDao;	
	private Connection conn;
	private FindDao() {}

	public static FindDao getInstance() {
		if (findDao == null) findDao = new FindDao();
		return findDao;
	}
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	public String getFindId(String where) {
		String miid = "";
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement();
			String sql = "select mi_id from t_member_info " + where;
			rs = stmt.executeQuery(sql);
			if(rs.next()) {
				miid = rs.getString("mi_id");
			}
		} catch(Exception e) {
			System.out.println("FindDao클래스의 getFindId() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs); close(stmt);
		}
		return miid;
	}
	public String getFindPw(String where) {
		String pw = "";
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement();
			String sql = "select mi_id from t_member_info " + where;
			rs = stmt.executeQuery(sql);
			if(rs.next()) {
				pw = rs.getString("mi_pw");
			}
		} catch(Exception e) {
			System.out.println("FindDao클래스의 getFindPw() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs); close(stmt);
		}
		return pw;
	}
}

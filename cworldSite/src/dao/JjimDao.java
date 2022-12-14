package dao;

import static db.jdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class JjimDao {
	private static JjimDao jjimDao;	
	private Connection conn;
	private JjimDao() {}
	public static JjimDao getInstance() {
		if (jjimDao == null) {
			jjimDao = new JjimDao();
		}
		return jjimDao;
	}
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	public int jjimClick(String miid, String piid) {
		int result = 0;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement();
			String sql = "select * from t_member_jjim where pi_id = '" + piid + "' and mi_id= '" + miid + "' ";
			rs = stmt.executeQuery(sql);
			if (rs.next()) {
				sql = "delete from t_member_jjim where pi_id = '" + piid + "' and mi_id= '" + miid + "' ";
				result = stmt.executeUpdate(sql);
			} else {
				sql = "insert into t_member_jjim (pi_id, mi_id) values ('" + piid + "', '" + miid + "')";
				result = stmt.executeUpdate(sql);
			}
		} catch(Exception e) {
			System.out.println("JjimDao클래스의 jjimInsert() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs); close(stmt);
		}
		return result;
	}
	public String amIJjim(String miid, String piid) {
		String result = "";
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement();
			String sql = "select * from t_member_jjim where pi_id = '" + piid + "' and mi_id= '" + miid + "' ";
			rs = stmt.executeQuery(sql);
			if (rs.next()) {
				result = "O";
			} else {
				result = "X";
			}
		} catch(Exception e) {
			System.out.println("JjimDao클래스의 amIJjim() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs); close(stmt);
		}
		return result;
	}
}

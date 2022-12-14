package dao;

import static db.jdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class BasicDelDao {
	private static BasicDelDao basicDelDao;	
	private Connection conn;
	private BasicDelDao() {}
	public static BasicDelDao getInstance() {
		if (basicDelDao == null) {
			basicDelDao = new BasicDelDao();
		}
		return basicDelDao;
	}
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public int basicDel(String miid, String where) {
		int result = 0;
		Statement stmt = null;
		
		try {
			String sql = "delete from t_member_addr where mi_id = '" + miid + "' and ma_basic = 'n' " + where;
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
		} catch(Exception e) {
			System.out.println("BasicDelDao클래스의 basicDel() 메소드 오류");
			e.printStackTrace();
		} finally {	
			close(stmt);
		}
		
		return result;
	}
	
}

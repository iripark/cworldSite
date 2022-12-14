package dao;

import static db.jdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class BasicUpDao {
	private static BasicUpDao basicUpDao;	
	private Connection conn;
	private BasicUpDao() {}
	public static BasicUpDao getInstance() {
		if (basicUpDao == null) {
			basicUpDao = new BasicUpDao();
		}
		return basicUpDao;
	}
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	public int basicUp(String miid, int idx) {
		int result = 0;
		Statement stmt = null;
		
		try {
			String sql = "update t_member_addr set ma_basic = 'n' where mi_id = '" + miid + "' and ma_basic = 'y'";
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
			if (result > 0) {
				result = 0;
				sql = "update t_member_addr set ma_basic = 'y' where ma_idx = " + idx + " and mi_id = '" + miid + "'";
				result = stmt.executeUpdate(sql);
			}
		} catch(Exception e) {
			System.out.println("BasicUpDao클래스의 basicUp() 메소드 오류");
			e.printStackTrace();
		} finally {	
			close(stmt);
		}
		
		return result;
	}
	
}

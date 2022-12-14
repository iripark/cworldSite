package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;

public class GQnaUpdateDao {
	private static GQnaUpdateDao gQnaUpdateDao;	
	private Connection conn;			
	private GQnaUpdateDao() {}
	public static GQnaUpdateDao getInstance() {
		if (gQnaUpdateDao == null) {
			gQnaUpdateDao = new GQnaUpdateDao();
		}		
		return gQnaUpdateDao;
	}
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	public int gqnaUpdate(String kind, String value, int idx) {
		int result = 0;
		Statement stmt = null;
		
		try {
			String sql = "";
			if (kind.equals("a")) {
				sql = "update t_group_qna set gq_isreply = '" + value + "' where gq_idx = " + idx;
			} else if (kind.equals("i")) {
				sql = "update t_group_qna set gq_isview = '" + value + "' where gq_idx = " + idx;
			} else {
				sql = "update t_group_qna set gq_pay = '" + value + "' where gq_idx = " + idx;
			}
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
		} catch(Exception e) {
			System.out.println("GQnaUpdateDao 클래스의 gqnaUpdate() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);
		}
		
		
		return result;
	}
	
}

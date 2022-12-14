package dao;

import static db.jdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class QnaSatisDao {
	private static QnaSatisDao qnaSatisDao;	
	private Connection conn;
	private QnaSatisDao() {}
	public static QnaSatisDao getInstance() {
		if (qnaSatisDao == null) {
			qnaSatisDao = new QnaSatisDao();
		}
		return qnaSatisDao;
	}
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	public int satisUp(int idx, String satis) {
		int result = 0;
		Statement stmt = null;
		try {
			String sql = "update t_qna_list set ql_satis = '" + satis + "' where ql_idx = " + idx;
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
		} catch(Exception e) {
			System.out.println("QnaSatisDao클래스의 satisUp() 메소드 오류");
			e.printStackTrace();
		} finally {	
			close(stmt);
		}
		
		
		return result;
	}
	
}

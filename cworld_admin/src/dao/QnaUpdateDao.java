package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class QnaUpdateDao {
	private static QnaUpdateDao qnaUpdateDao;	
	private Connection conn;			
	private QnaUpdateDao() {}
	public static QnaUpdateDao getInstance() {
		if (qnaUpdateDao == null) {
			qnaUpdateDao = new QnaUpdateDao();
		}		
		return qnaUpdateDao;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	public int qnaUpdate(int idx, String isview) {
		int result = 0;
		Statement stmt = null;
		try {
			String sql = "update t_qna_list set ql_isview = '" + isview + "' where ql_idx = " + idx;
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
		} catch(Exception e) {
			System.out.println("QnaUpdateDao 클래스의 qnaUpdate() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);
		}
				
		return result;
	}
	
}

package dao;

import static db.jdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class QnaDeleteDao {
	private static QnaDeleteDao qnaDeleteDao;	
	private Connection conn;
	private QnaDeleteDao() {}
	public static QnaDeleteDao getInstance() {
		if (qnaDeleteDao == null) {
			qnaDeleteDao = new QnaDeleteDao();
		}
		return qnaDeleteDao;
	}
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	public int qnaDelete(int idx) {
		int result = 0;
		Statement stmt = null;
		
		try {
			String sql = "update t_qna_list set ql_isview = 'n' where ql_idx = " + idx;
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
		} catch(Exception e) {
			System.out.println("QnaDeleteDao클래스의 qnaDelete() 메소드 오류");
			e.printStackTrace();
		} finally {	
			close(stmt);
		}
		
		return result;
	}
	
}

package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class AnswerQnaDao {
	private static AnswerQnaDao answerQnaDao;	
	private Connection conn;			
	private AnswerQnaDao() {}
	public static AnswerQnaDao getInstance() {
		if (answerQnaDao == null) {
			answerQnaDao = new AnswerQnaDao();
		}		
		return answerQnaDao;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	public int answerQna(int idx, String name, String answer) {
		int result = 0;
		Statement stmt = null;
		
		try {
			String sql = "update t_qna_list set ql_answer = '" + answer + "', ql_isanswer = 'y', ql_ai_name = '" + name + "', ql_adate = now() where ql_idx = " + idx;
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
			
		} catch(Exception e) {
			System.out.println("AnswerQnaDao 클래스의 answerQna() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);
		}
		return result;
	}
	
}

package dao;

import static db.jdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class QnaProcInDao {
	private static QnaProcInDao qnaProcInDao;	
	private Connection conn;
	private QnaProcInDao() {}
	public static QnaProcInDao getInstance() {
		if (qnaProcInDao == null) {
			qnaProcInDao = new QnaProcInDao();
		}
		return qnaProcInDao;
	}
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	public int qnaInsert(QnaInfo qi) {
		int result = 0, idx = 1;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "select max(ql_idx) from t_qna_list";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if(rs.next()) {
				idx = rs.getInt(1) + 1;
			}
			sql = "insert into t_qna_list (ql_idx, mi_id, ql_ctgr, ql_title, ql_content, ql_img, ql_ip) values ('" + idx + "', '" + qi.getMi_id() + "', '" + qi.getQl_ctgr() + "', '" + qi.getQl_title() + "', '" + qi.getQl_content() + "', '" + qi.getQl_img1() + "', '" + qi.getQl_ip() + "')";
			result = stmt.executeUpdate(sql);
			if (result == 0) {
				return result;
			} else {
				result = idx;
			}
			
		} catch(Exception e) {
			System.out.println("QnaProcInDao클래스의 qnaInsert() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);	
			close(stmt);
		}
		
		return idx;
	}
	
}

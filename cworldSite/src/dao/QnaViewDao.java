package dao;

import static db.jdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class QnaViewDao {
	private static QnaViewDao qnaViewDao;	
	private Connection conn;
	private QnaViewDao() {}
	public static QnaViewDao getInstance() {
		if (qnaViewDao == null) {
			qnaViewDao = new QnaViewDao();
		}
		return qnaViewDao;
	}
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public QnaInfo getQnaInfo(int idx) {
		QnaInfo qi = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "select * from t_qna_list where ql_idx = " + idx;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next()) {	// 게시글이 있으면
				qi = new QnaInfo();
				qi.setQl_idx(rs.getInt("ql_idx"));
				qi.setMi_id(rs.getString("mi_id"));
				qi.setQl_ctgr(rs.getString("ql_ctgr"));
				qi.setQl_title(rs.getString("ql_title"));
				qi.setQl_content(rs.getString("ql_content"));
				qi.setQl_img1(rs.getString("ql_img"));
				qi.setQl_qdate(rs.getString("ql_qdate"));
				qi.setQl_isanswer(rs.getString("ql_isanswer"));
				qi.setQl_ai_name(rs.getString("ql_ai_name"));
				qi.setQl_answer(rs.getString("ql_answer"));
				qi.setQl_satis(rs.getString("ql_satis"));
				qi.setQl_adate(rs.getString("ql_adate"));
			} 
					
		} catch(Exception e) {
			System.out.println("QnaViewDao클래스의 getQnaInfo() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);	
			close(stmt);
		}
		
		return qi;
	}	
}

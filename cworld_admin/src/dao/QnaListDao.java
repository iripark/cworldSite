package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class QnaListDao {
	private static QnaListDao qnaListDao;	
	private Connection conn;			
	private QnaListDao() {}
	public static QnaListDao getInstance() {
		if (qnaListDao == null) {
			qnaListDao = new QnaListDao();
		}		
		return qnaListDao;
	}
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	public int getQnaCount(String where) {
		int rcnt = 0;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "select count(ql_idx) from t_qna_list where 1=1 " + where;
			
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			rs.next();
			rcnt = rs.getInt(1);
		} catch(Exception e) {
			System.out.println("QnaListDao 클래스의 getQnaCount() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		
		return rcnt;
	}
	public ArrayList<QnaInfo> getQnaList(int cpage, int psize, String where) {
		ArrayList<QnaInfo> qnaList = new ArrayList<QnaInfo>();
		QnaInfo qi = null;
		Statement stmt = null;
		ResultSet rs = null;
		int start = psize * (cpage - 1);
		try {
			String sql = "select * from t_qna_list where 1=1 " + where + " order by ql_qdate desc limit " + start + ", " + psize;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				qi = new QnaInfo();
				qi.setQl_idx(rs.getInt("ql_idx"));
				qi.setMi_id(rs.getString("mi_id"));
				qi.setQl_ctgr(rs.getString("ql_ctgr"));
				qi.setQl_title(rs.getString("ql_title"));
				qi.setQl_content(rs.getString("ql_content"));
				qi.setQl_img(rs.getString("ql_img"));
				qi.setQl_ip(rs.getString("ql_ip"));
				qi.setQl_qdate(rs.getString("ql_qdate"));
				qi.setQl_isanswer(rs.getString("ql_isanswer"));
				qi.setQl_ai_name(rs.getString("ql_ai_name"));
				qi.setQl_answer(rs.getString("ql_answer"));
				qi.setQl_satis(rs.getString("ql_satis"));
				qi.setQl_adate(rs.getString("ql_adate"));
				qi.setQl_isview(rs.getString("ql_isview"));
				
				qnaList.add(qi);
			}
		} catch(Exception e) {
			System.out.println("QnaListDao 클래스의 getQnaCount() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		return qnaList;
	}
}

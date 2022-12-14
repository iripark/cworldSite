package dao;

import static db.jdbcUtil.*;
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
	
	public int getQnaListCount(String miid) {
		int rcnt = 0;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "select count(*) from t_qna_list where ql_isview = 'y' and mi_id = '" + miid + "'";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			rs.next();
			rcnt = rs.getInt(1);
		} catch(Exception e) {
			System.out.println("QnaListDao 클래스의 getQnaListCount() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		
		return rcnt;
	}
	public ArrayList<QnaInfo> getQnaList(String miid, int cpage, int psize) {
		ArrayList<QnaInfo> qnaList = new ArrayList<QnaInfo>();
		QnaInfo qi = null;
		Statement stmt = null;
		ResultSet rs = null;
		int start = psize * (cpage - 1);
		try {
			String sql = "select * from t_qna_list where ql_isview = 'y' and mi_id = '" + miid + "' order by ql_idx desc limit " + start + ", " + psize;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				qi = new QnaInfo();
				qi.setQl_idx(rs.getInt("ql_idx"));
				qi.setMi_id(rs.getString("mi_id"));
				qi.setQl_ctgr(rs.getString("ql_ctgr"));
				qi.setQl_title(rs.getString("ql_title"));
				qi.setQl_qdate(rs.getString("ql_qdate"));
				qi.setQl_isanswer(rs.getString("ql_isanswer"));
				qnaList.add(qi);
			}
		
		} catch(Exception e) {
			System.out.println("QnaListDao 클래스의 getQnaList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		
		return qnaList;
	}
	
}

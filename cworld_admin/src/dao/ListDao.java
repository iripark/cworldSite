package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class ListDao {
	private static ListDao listDao;	
	private Connection conn;			
	private ListDao() {}
	public static ListDao getInstance() {
		if (listDao == null) {
			listDao = new ListDao();
		}		
		return listDao;
	}
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	public int getNoticeCount() {
		int rcnt = 0;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "select count(*) from t_notice_list";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			rs.next();
			rcnt = rs.getInt(1);
		} catch(Exception e) {
			System.out.println("ListDao 클래스의 getNoticeCount() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		return rcnt;
	}
	public ArrayList<NoticeInfo> getNoticeList(int cpage, int psize) {
		ArrayList<NoticeInfo> noticeList = new ArrayList<NoticeInfo>();
		NoticeInfo ni = null;
		Statement stmt =null;
		ResultSet rs = null;
		int start = psize * (cpage - 1);
		try {
			String sql = "select a.nl_idx, a.nl_ctgr, a.ai_idx, a.nl_title, a.nl_content, a.nl_read, left(a.nl_date, 10) date, a.nl_isview, b.ai_name from t_notice_list a, t_admin_info b where a.ai_idx = b.ai_idx order by nl_date desc limit " + start + ", " + psize;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				ni = new NoticeInfo();
				ni.setNl_idx(rs.getInt("nl_idx"));
				ni.setNl_ctgr(rs.getString("nl_ctgr"));
				ni.setAi_idx(rs.getInt("ai_idx"));
				ni.setNl_title(rs.getString("nl_title"));
				ni.setNl_content(rs.getString("nl_content"));
				ni.setNl_read(rs.getInt("nl_read"));
				ni.setNl_date(rs.getString("date"));
				ni.setNl_isview(rs.getString("nl_isview"));
				ni.setAi_name(rs.getString("ai_name"));
				noticeList.add(ni);
			}
			
		} catch(Exception e) {
			System.out.println("ListDao 클래스의 getNoticeList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		
		return noticeList;
	}
	public int noticeInsert(NoticeInfo noticeInfo) {
		int result = 0, idx = 1;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			stmt = conn.createStatement();
			String sql = "select max(nl_idx) from t_notice_list";
			rs = stmt.executeQuery(sql);
			if(rs.next()) {
				idx = rs.getInt(1) + 1;
			}
			sql = "insert into t_notice_list (nl_idx, nl_ctgr, ai_idx, nl_title, nl_content, nl_isview) value (" + idx + ", '" + noticeInfo.getNl_ctgr() + "', " + noticeInfo.getAi_idx() + ", '" + noticeInfo.getNl_title() + "', '" + noticeInfo.getNl_content() + "', '" + noticeInfo.getNl_isview() + "')";
			result = stmt.executeUpdate(sql);
			if (result == 0) {
				return result;
			} else {
				result = idx;
			}
		} catch(Exception e) {
			System.out.println("ListDao 클래스의 noticeInsert() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		
		return result;
	}
	public int readUpdate(int idx) {
		int result = 0;
		Statement stmt = null;
		try {
			stmt = conn.createStatement();
			String sql = "update t_notice_list set nl_read = nl_read + 1 where nl_idx = " + idx;
			result = stmt.executeUpdate(sql);
		} catch(Exception e) {
			System.out.println("ListDao 클래스의 readUpdate() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);
		}
		
		return result;
	}
	public NoticeInfo getNoticeInfo(int idx) {
		Statement stmt = null;
		ResultSet rs = null;
		NoticeInfo ni = null;
		
		try {
			stmt = conn.createStatement();
			String sql = "select a.*, b.ai_name from t_notice_list a, t_admin_info b where nl_idx = " + idx;
			rs = stmt.executeQuery(sql);
			if (rs.next()) {	// 게시글이 있으면
				ni = new NoticeInfo();
				ni.setNl_idx(idx);
				ni.setAi_name(rs.getString("ai_name"));
				ni.setNl_ctgr(rs.getString("nl_ctgr"));
				ni.setAi_idx(rs.getInt("ai_idx"));
				ni.setAi_name(rs.getString("ai_name"));
				ni.setNl_title(rs.getString("nl_title"));
				ni.setNl_content(rs.getString("nl_content"));
				ni.setNl_read(rs.getInt("nl_read"));
				ni.setNl_date(rs.getString("nl_date"));
				ni.setNl_isview(rs.getString("nl_isview"));				
			} 
		} catch(Exception e) {
			System.out.println("ListDao 클래스의 getNoticeInfo() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		
		return ni;
	}
	public int isviewUpdate(int idx, String isview) {
		int result = 0;
		
		Statement stmt = null;
		try {
			String sql = "update t_notice_list set nl_isview = '" + isview + "' where nl_idx = " + idx;
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
		}  catch(Exception e) {
			System.out.println("ListDao 클래스의 isviewUpdate() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);
		}
		
		return result;
	}
	public int NoticeDelete(int idx) {
		int result = 0;
		Statement stmt = null;
		
		try {
			String sql = "delete from t_notice_list where nl_idx = " + idx;
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
		} catch(Exception e) {
			System.out.println("ListDao 클래스의 NoticeDelete() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);
		}
		return result;
	}
	
	public int noticeUpdate(NoticeInfo ni) {
		int result = 0;
		Statement stmt = null;
		
		try {
			String sql = "update t_notice_list set nl_ctgr = '" + ni.getNl_ctgr() + "', ai_idx = " + ni.getAi_idx() + ", nl_title = '" + ni.getNl_title() + "', nl_content = '" + ni.getNl_content() + "', nl_isview = '" + ni.getNl_isview() + "' where nl_idx = " + ni.getNl_idx();
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
		} catch(Exception e) {
			System.out.println("ListDao 클래스의 noticeUpdate() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);
		}
		
		return result;
	}
	
}

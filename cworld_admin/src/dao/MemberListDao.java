package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class MemberListDao {
	private static MemberListDao memberListDao;	
	private Connection conn;			
	private MemberListDao() {}
	public static MemberListDao getInstance() {
		if (memberListDao == null) {
			memberListDao = new MemberListDao();
		}		
		return memberListDao;
	}
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	public ArrayList<MemberInfo> getMemberList(int cpage, int psize, String where) {
		ArrayList<MemberInfo> memberList = new ArrayList<MemberInfo>();
		Statement stmt = null;
		ResultSet rs = null;
		MemberInfo mi = null;
		int start = psize * (cpage - 1);
		try {
			String sql = "select * from t_member_info " + where + " order by mi_join desc limit " + start + ", " + psize;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				mi = new MemberInfo();
				mi.setMi_id(rs.getString("mi_id"));
				mi.setMi_pw(rs.getString("mi_pw"));
				mi.setMi_name(rs.getString("mi_name"));
				mi.setMi_gender(rs.getString("mi_gender"));
				mi.setMi_birth(rs.getString("mi_birth"));
				mi.setMi_mail(rs.getString("mi_mail"));
				mi.setMi_phone(rs.getString("mi_phone"));
				mi.setMi_point(rs.getInt("mi_point"));
				mi.setMi_join(rs.getString("mi_join"));
				mi.setMi_last(rs.getString("mi_last"));
				mi.setMi_status(rs.getString("mi_status"));
				mi.setMi_visited(rs.getInt("mi_visited"));
				mi.setMi_adv(rs.getString("mi_adv"));
				mi.setAddrList(getAddrList(rs.getString("mi_id")));
				memberList.add(mi);
				
			}
		} catch(Exception e) {
			System.out.println("MemberListDao 클래스의 getMemberList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		
		return memberList;
	}
	public ArrayList<AddrInfo> getAddrList(String mi_id) {
		ArrayList<AddrInfo> al = new ArrayList<AddrInfo>();
		AddrInfo ai = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "select * from t_member_addr where mi_id = '" + mi_id + "' ";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				ai = new AddrInfo();
				ai.setMa_idx(rs.getInt("ma_idx"));
				ai.setMi_id(rs.getString("mi_id"));
				ai.setMa_phone(rs.getString("ma_phone"));
				ai.setMa_name(rs.getString("ma_name"));
				ai.setMa_receiver(rs.getString("ma_receiver"));
				ai.setMa_zip(rs.getString("ma_zip"));
				ai.setMa_addr1(rs.getString("ma_addr1"));
				ai.setMa_addr2(rs.getString("ma_addr2"));
				ai.setMa_basic(rs.getString("ma_basic"));
				ai.setMa_date(rs.getString("ma_date"));
				al.add(ai);
			}
		} catch(Exception e) {
			System.out.println("MemberListDao 클래스의 getAddrList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		
		return al;
	}
	public int getMemberCount(String where) {
		int rcnt = 0;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "select count(mi_id) from t_member_info " + where;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			rs.next();
			rcnt = rs.getInt(1);
		} catch(Exception e) {
			System.out.println("MemberListDao 클래스의 getMemberCount() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		
		return rcnt;
	}
	public int getLastCount() {
		int rcnt = 0;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			String sql = "select count(*) from t_member_info where datediff(mi_last, now()) < -180";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			rs.next();
			rcnt = rs.getInt(1);
			
		} catch(Exception e) {
			System.out.println("MemberListDao 클래스의 getLastCount() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		
		return rcnt;
	}
	public ArrayList<MemberInfo> getLastList(int cpage, int psize) {
		ArrayList<MemberInfo> mi = new ArrayList<MemberInfo>();
		MemberInfo mem = null;
		Statement stmt = null;
		ResultSet rs = null;
		int start = psize * (cpage - 1);
		try {
			String sql = "select * from t_member_info where datediff(mi_last, now()) < -180  order by mi_join desc limit " + start + ", " + psize;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				mem = new MemberInfo();
				mem.setMi_id(rs.getString("mi_id"));
				mem.setMi_name(rs.getString("mi_name"));
				mem.setMi_mail(rs.getString("mi_mail"));
				mem.setMi_last(rs.getString("mi_last"));
				mem.setMi_status(rs.getString("mi_status"));
				mi.add(mem);
			}
			
		} catch(Exception e) {
			System.out.println("MemberListDao 클래스의 getLastList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		
		return mi;
	}
	public int getExitCount() {
		int rcnt = 0;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "select count(*) from t_member_info where mi_status = 'c'";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			rs.next();
			rcnt = rs.getInt(1);
		} catch(Exception e) {
			System.out.println("MemberListDao 클래스의 getExitCount() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		return rcnt;
	}
	public ArrayList<MemberInfo> getExitList(int cpage, int psize) {
		ArrayList<MemberInfo> exitList = new ArrayList<MemberInfo>();
		MemberInfo mi = null;
		Statement stmt = null;
		ResultSet rs = null;
		int start = psize * (cpage - 1);
		try {
			String sql = "select * from t_member_info where mi_status = 'c' order by mi_last desc limit " + start + ", " + psize;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				mi = new MemberInfo();
				mi.setMi_id(rs.getString("mi_id"));
				mi.setMi_pw(rs.getString("mi_pw"));
				mi.setMi_name(rs.getString("mi_name"));
				mi.setMi_gender(rs.getString("mi_gender"));
				mi.setMi_birth(rs.getString("mi_birth"));
				mi.setMi_mail(rs.getString("mi_mail"));
				mi.setMi_phone(rs.getString("mi_phone"));
				mi.setMi_point(rs.getInt("mi_point"));
				mi.setMi_join(rs.getString("mi_join"));
				mi.setMi_last(rs.getString("mi_last"));
				mi.setMi_status(rs.getString("mi_status"));
				mi.setMi_visited(rs.getInt("mi_visited"));
				mi.setMi_adv(rs.getString("mi_adv"));
				exitList.add(mi);
			}
			
		} catch(Exception e) {
			System.out.println("MemberListDao 클래스의 getExitCount() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		
		return exitList;
	}
	public String getMemberLast() {
		String memLast = "";
		Statement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "select * from t_member_info where datediff(mi_last, now()) < -180";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				memLast += "," + rs.getString("mi_id");
			}
			memLast = memLast.substring(1);
		} catch(Exception e) {
			System.out.println("MemberListDao 클래스의 getMemberLast() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		return memLast;
	}
}

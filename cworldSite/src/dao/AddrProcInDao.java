package dao;

import static db.jdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class AddrProcInDao {
	private static AddrProcInDao addrProcInDao;	
	private Connection conn;
	private AddrProcInDao() {}
	public static AddrProcInDao getInstance() {
		if (addrProcInDao == null) {
			addrProcInDao = new AddrProcInDao();
		}
		return addrProcInDao;
	}
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	public int addrInsert(MemberAddr ma) {
		int result = 0;
		CallableStatement cstmt = null;
		
		try {
			String sql = "{call sp_member_addr_insert(?, ?, ?, ?, ?, ?, ?, ?)}";
			cstmt = conn.prepareCall(sql);
			cstmt.setString(1, ma.getMi_id());
			cstmt.setString(2, ma.getMa_phone());
			cstmt.setString(3, ma.getMa_receiver());
			cstmt.setString(4, ma.getMa_name());
			cstmt.setString(5, ma.getMa_zip());
			cstmt.setString(6, ma.getMa_addr1());
			cstmt.setString(7, ma.getMa_addr2());
			cstmt.setString(8, ma.getMa_basic());
			result = cstmt.executeUpdate();
		} catch(Exception e) {
			System.out.println("AddrProcInDao클래스의 addrInsert() 메소드 오류");
			e.printStackTrace();
		} finally {	
			close(cstmt);
		}
		
		return result;
	}
	
}

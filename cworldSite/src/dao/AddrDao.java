package dao;

import static db.jdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class AddrDao {
	private static AddrDao addrDao;	
	private Connection conn;
	private AddrDao() {}
	public static AddrDao getInstance() {
		if (addrDao == null) {
			addrDao = new AddrDao();
		}
		return addrDao;
	}
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	public ArrayList<MemberAddr> getAddr(String miid) {
		ArrayList<MemberAddr> addrList = new ArrayList<MemberAddr>();
		MemberAddr ma = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			String sql = "select * from t_member_addr where mi_id = '" + miid + "' ";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				ma = new MemberAddr();
				ma.setMa_idx(rs.getInt("ma_idx"));
				ma.setMi_id(rs.getString("mi_id"));
				ma.setMa_phone(rs.getString("ma_phone"));
				ma.setMa_receiver(rs.getString("ma_receiver"));
				ma.setMa_name(rs.getString("ma_name"));
				ma.setMa_zip(rs.getString("ma_zip"));
				ma.setMa_addr1(rs.getString("ma_addr1"));
				ma.setMa_addr2(rs.getString("ma_addr2"));
				ma.setMa_basic(rs.getString("ma_basic"));
				ma.setMa_date(rs.getString("ma_date"));
				addrList.add(ma);
			}
		} catch(Exception e) {
			System.out.println("AddrDao클래스의 getAddr() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);	
			close(stmt);
		}
		
		return addrList;
	}
}

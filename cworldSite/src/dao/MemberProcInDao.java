package dao;

import static db.jdbcUtil.*;
import java.sql.*;
import vo.*;


public class MemberProcInDao {
	private static MemberProcInDao memberProcInDao;	
	private Connection conn;
	private MemberProcInDao() {}

	public static MemberProcInDao getInstance() {
		if (memberProcInDao == null) memberProcInDao = new MemberProcInDao();
		return memberProcInDao;
	}
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	public int memberInsert(MemberInfo memberInfo, MemberAddr memberAddr) {
		PreparedStatement pstmt = null;
		int result = 0;	
		try {
			String sql = "insert into t_member_info (mi_id, mi_pw, mi_name, mi_gender, mi_birth, mi_mail, mi_phone, mi_point, mi_adv) values(?, ?, ?, ?, ?, ?, ?, 2000, ?)";
			System.out.println(sql);
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberInfo.getMi_id());
			pstmt.setString(2, memberInfo.getMi_pw());
			pstmt.setString(3, memberInfo.getMi_name());
			pstmt.setString(4, memberInfo.getMi_gender());
			pstmt.setString(5, memberInfo.getMi_birth());
			pstmt.setString(6, memberInfo.getMi_mail());
			pstmt.setString(7, memberInfo.getMi_phone());
			pstmt.setString(8, memberInfo.getMi_adv());
			result = pstmt.executeUpdate();
			if(result > 0) {
				result = 0;	
				sql = "insert into t_member_addr (mi_id, ma_phone, ma_receiver, ma_name, ma_zip, ma_addr1, ma_addr2) values (?, ?, ?, ?, ?, ?, ?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, memberInfo.getMi_id());
				pstmt.setString(2, memberInfo.getMi_phone());
				pstmt.setString(3, memberInfo.getMi_name());
				pstmt.setString(4, "기본주소");
				pstmt.setString(5, memberAddr.getMa_zip());
				pstmt.setString(6, memberAddr.getMa_addr1());
				pstmt.setString(7, memberAddr.getMa_addr2());
				result = pstmt.executeUpdate();
				
				if(result > 0) {
					result = 0;
					sql = "insert into t_member_point (mi_id, mp_point, mp_desc) values (?, ?, ?)";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, memberInfo.getMi_id());
					pstmt.setInt(2, 2000);
					pstmt.setString(3, "가입축하금");
					result = pstmt.executeUpdate();
				}
			}
		} catch(Exception e) {
			System.out.println("MemberProcInDao클래스의 memberInsert() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(pstmt);
		}	
		return result;
	}
}

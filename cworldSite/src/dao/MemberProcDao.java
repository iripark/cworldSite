package dao;

import static db.jdbcUtil.*;
import java.sql.*;

import vo.*;

public class MemberProcDao {
	private static MemberProcDao memberProcDao;	
	private Connection conn;
	private MemberProcDao() {}

	public static MemberProcDao getInstance() {
		if (memberProcDao == null) memberProcDao = new MemberProcDao();
		return memberProcDao;
	}
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	public int memberUpdate(MemberInfo memberInfo) { 
	// 사용자가 입력한 데이터들로 회원정보를 수정하는 메소드
		Statement stmt = null;
		int result = 0;	
		try {
			String sql = "update t_member_info set mi_mail = '" + memberInfo.getMi_mail() + "', mi_phone = '" + memberInfo.getMi_phone() + "' where mi_id= '" + memberInfo.getMi_id() + "' ";
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
		} catch(Exception e) {
			System.out.println("MemberProcDao클래스의 memberUpdate() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(stmt);
		}	
		return result;
	}

	public int memberDelete(MemberInfo memberInfo) { return 0;}
}


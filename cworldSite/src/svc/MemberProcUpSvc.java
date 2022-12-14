package svc;

import static db.jdbcUtil.*;
import java.sql.*;
import dao.*;
import vo.*;

public class MemberProcUpSvc {
	public int getMemberUpdate(String sql) {
		int result = 0;
		Connection conn = getConnection();
		MemberProcUpDao memberProcUpDao = MemberProcUpDao.getInstance();
		memberProcUpDao.setConnection(conn);
			result = memberProcUpDao.getMemberUpdate(sql);
		if (result == 1) commit(conn);
		else			 rollback(conn);
		
		return result;
	}
}

package svc;

import static db.jdbcUtil.*;
import java.sql.*;
import dao.*;
import vo.*;

public class MemberProcDelSvc {
	public int memberLeave(String sql) {
		int result = 0;
		Connection conn = getConnection();
		MemberProcDelDao memberProcDelDao = MemberProcDelDao.getInstance();
		memberProcDelDao.setConnection(conn);
			result = memberProcDelDao.memberLeave(sql);
		if (result == 1) commit(conn);
		else			 rollback(conn);
		
		return result;
	}
}

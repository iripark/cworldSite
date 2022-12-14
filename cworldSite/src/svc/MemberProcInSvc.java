package svc;

import static db.jdbcUtil.*;
import java.sql.*;
import dao.*;
import vo.*;

public class MemberProcInSvc {
	public int memberInsert(MemberInfo memberInfo, MemberAddr memberAddr) {
		Connection conn = getConnection();
		MemberProcInDao memberProcInDao = MemberProcInDao.getInstance();
		memberProcInDao.setConnection(conn);
		int result = 0;
			result = memberProcInDao.memberInsert(memberInfo, memberAddr);
		if (result == 1) commit(conn);
		else			 rollback(conn);
		
		return result;
	}
}
	
	
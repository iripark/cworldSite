package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class MemberExitUpdateSvc {
	public int memberExit(String miid) {
		int result = 0;
		
		Connection conn = getConnection();
		MemberExitUpdateDao memberExitUpdateDao = MemberExitUpdateDao.getInstance();
		memberExitUpdateDao.setConnection(conn);
		result = memberExitUpdateDao.memberExit(miid);
		if (result == 1) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);
		
		return result;
	}
}

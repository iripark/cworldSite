package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;

public class MemberStatusUpdateSvc {
	public int memStatusUpdate(String where) {
		int result = 0;
		
		Connection conn = getConnection();
		MemberStatusUpdateDao memberStatusUpdateDao = MemberStatusUpdateDao.getInstance();
		memberStatusUpdateDao.setConnection(conn);
		
		result = memberStatusUpdateDao.memStatusUpdate(where);
		if (result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);
		
		return result;
	}	
}	

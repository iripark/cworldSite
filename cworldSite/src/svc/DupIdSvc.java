package svc;

import static db.jdbcUtil.*;
import java.sql.*;
import dao.*;

public class DupIdSvc {
	public int chkDupId(String uid) {
		int result = 0;
		Connection conn = getConnection();
		DupIdDao dupIdDao = DupIdDao.getInstance();
		dupIdDao.setConnection(conn);
		result = dupIdDao.chkDupId(uid);
		close(conn);
		return result;
	}
}

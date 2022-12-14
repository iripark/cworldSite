package svc;

import static db.jdbcUtil.*;
import java.sql.*;
import dao.*;

public class DupPwSvc {
	public int chkDupPw(String uid, String pwd){
		int result = 0;
		Connection conn = getConnection();
		DupPwDao dupPwDao = DupPwDao.getInstance();
		dupPwDao.setConnection(conn);
		result = dupPwDao.chkDupPw(uid, pwd);
		close(conn);
		return result;
	}
}

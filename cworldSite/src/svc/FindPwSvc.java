package svc;

import static db.jdbcUtil.*;
import java.sql.*;
import dao.*;

public class FindPwSvc {
	public String getFindPw(String where) {
		String pw = "";
		Connection conn = getConnection();
		FindDao findDao = FindDao.getInstance();
		findDao.setConnection(conn);
		pw = findDao.getFindPw(where);
		close(conn);
		
		return pw;	
	}
}

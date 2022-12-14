package svc;

import static db.jdbcUtil.*;
import java.sql.*;
import dao.*;

public class JjimProcSvc {
	public int jjimClick(String miid, String piid) {
		int result = 0;
		Connection conn = getConnection();
		JjimDao jjimDao = JjimDao.getInstance();
		jjimDao.setConnection(conn);
		
		result = jjimDao.jjimClick(miid, piid);
		if (result == 1) {		commit(conn); }
		else {					rollback(conn);	}
		close(conn);
		return result;
	}
	public String amIJjim(String miid, String piid) {
		String result = "X";
		Connection conn = getConnection();
		JjimDao jjimDao = JjimDao.getInstance();
		jjimDao.setConnection(conn);
		
		result = jjimDao.amIJjim(miid, piid);
		close(conn);
		return result;
	}
}

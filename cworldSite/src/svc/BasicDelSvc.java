package svc;

import static db.jdbcUtil.*;
import java.sql.*;
import dao.*;
import vo.*;
import java.util.*;

public class BasicDelSvc {
	public int basicDel(String miid, String where) {
		int result = 0;
		
		Connection conn = getConnection();
		BasicDelDao basicDelDao = BasicDelDao.getInstance();
		basicDelDao.setConnection(conn);
		
		result = basicDelDao.basicDel(miid, where);
		if (result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);
		
		return result;
	}

}

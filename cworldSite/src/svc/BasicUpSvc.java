package svc;

import static db.jdbcUtil.*;
import java.sql.*;
import dao.*;
import vo.*;
import java.util.*;

public class BasicUpSvc {
	public int basicUp(String miid, int idx) {
		int result = 0;
		
		Connection conn = getConnection();
		BasicUpDao basicUpDao = BasicUpDao.getInstance();
		basicUpDao.setConnection(conn);
		
		result = basicUpDao.basicUp(miid, idx);
		if (result == 1) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);
		
		return result;
	}

}

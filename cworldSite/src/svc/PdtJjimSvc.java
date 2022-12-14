package svc;

import static db.jdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class PdtJjimSvc {
	public int jjimInsert(String miid, String piid) {
		int result = 0;
		
		Connection conn = getConnection();
		PdtJjimDao pdtJjimDao = PdtJjimDao.getInstance();
		pdtJjimDao.setConnection(conn);
		
		result = pdtJjimDao.jjimInsert(miid, piid);
		if (result == 1) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);
		
		return result;
	}

}

package svc;

import static db.jdbcUtil.*;
import java.sql.*;
import dao.*;
import vo.*;
import java.util.*;

public class AddrProcInSvc {
	public int addrInsert(MemberAddr ma) {
		int result = 0;
		
		Connection conn = getConnection();
		AddrProcInDao addrProcInDao = AddrProcInDao.getInstance();
		addrProcInDao.setConnection(conn);
		
		result = addrProcInDao.addrInsert(ma);
		if (result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		
		close(conn);
		
		return result;
	}

}

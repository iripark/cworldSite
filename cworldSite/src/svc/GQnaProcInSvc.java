package svc;

import static db.jdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class GQnaProcInSvc {
	public int GqnaListInsert(GqnaInfo gqnaInfo) {
		int idx = 0;
		Connection conn= getConnection();
		GQnaProcInDao gQnaProcInDao = GQnaProcInDao.getInstance();
		gQnaProcInDao.setConnection(conn);
		
		idx = gQnaProcInDao.GqnaListInsert(gqnaInfo);
		if (idx > 0 )		commit(conn);
		else 				rollback(conn);
		close(conn);
		
		return idx;
	}
}

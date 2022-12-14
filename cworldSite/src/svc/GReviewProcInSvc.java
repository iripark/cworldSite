package svc;

import static db.jdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class GReviewProcInSvc {
	public int gReviewInsert(GReviewInfo gri) {
		int idx = 0;
		
		Connection conn= getConnection();
		GReviewProcInDao gReviewProcInDao = GReviewProcInDao.getInstance();
		gReviewProcInDao.setConnection(conn);
		
		idx = gReviewProcInDao.gReviewInsert(gri);
		
		if (idx > 0 ) {
			commit(conn);
		} else {
			rollback(conn);
		} 				
		close(conn);
		
		return idx;
	}
}	

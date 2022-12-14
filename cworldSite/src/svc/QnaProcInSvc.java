package svc;

import static db.jdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class QnaProcInSvc {
	public int qnaInsert(QnaInfo qi) {
		int idx = 0;
		
		Connection conn = getConnection();
		QnaProcInDao qnaProcInDao = QnaProcInDao.getInstance();
		qnaProcInDao.setConnection(conn);
		
		idx = qnaProcInDao.qnaInsert(qi);
		if(idx > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);
		
		return idx;
	}

}

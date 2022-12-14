package svc;

import static db.JdbcUtil.*;
import java.sql.*;
import dao.*;

public class QnaUpdateSvc {
	public int qnaUpdate(int idx, String isview) {
		int result = 0;
		
		Connection conn = getConnection();
		QnaUpdateDao qnaUpdateDao = QnaUpdateDao.getInstance();
		qnaUpdateDao.setConnection(conn);
		result = qnaUpdateDao.qnaUpdate(idx, isview);
		if (result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);
		
		return result;
	}
}

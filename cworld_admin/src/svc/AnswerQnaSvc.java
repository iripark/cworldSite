package svc;

import static db.JdbcUtil.*;
import java.sql.*;
import dao.*;
import vo.*;

public class AnswerQnaSvc {

	public int answerQna(int idx, String name, String answer) {
		int result = 0;
		
		Connection conn = getConnection();
		AnswerQnaDao answerQnaDao = AnswerQnaDao.getInstance();
		answerQnaDao.setConnection(conn);
		
		result = answerQnaDao.answerQna(idx, name, answer);
		if (result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);	
		return result;
	}

}

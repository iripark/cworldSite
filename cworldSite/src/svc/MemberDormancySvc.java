package svc;

import static db.jdbcUtil.*;
import java.sql.*;

import dao.*;
import vo.*;

public class MemberDormancySvc {
	public int updateMemberStatus(String sql){
		int result = 0;
		Connection conn = getConnection();
		MemberDormancyDao memberDormancyDao = MemberDormancyDao.getInstance();
		memberDormancyDao.setConnection(conn);
		
		result = memberDormancyDao.updateMemberStatus(sql);
		if (result == 1 ) 	commit(conn);
		else				rollback(conn);
		close(conn);
		return result;
	}
}

package svc;

import static db.jdbcUtil.*;
import java.sql.*;
import dao.*;

public class FindIdSvc {
	public String getFindId(String where) {
		String miid = "";
		Connection conn = getConnection();
		FindDao findDao = FindDao.getInstance();
		findDao.setConnection(conn);
		miid = findDao.getFindId(where);
		close(conn);
		
		return miid;	
	}
}

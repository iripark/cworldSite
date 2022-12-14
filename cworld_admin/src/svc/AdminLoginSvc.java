package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class AdminLoginSvc {
	public AdminInfo getLoginAdmin(String uid, String pwd) {
		Connection conn = getConnection();
		AdminLoginDao adminLoginDao = AdminLoginDao.getInstance();
		adminLoginDao.setConnection(conn);
		
		AdminInfo loginInfo = adminLoginDao.getLoginAdmin(uid, pwd);
		
		close(conn);
		
		return loginInfo;
	}
}

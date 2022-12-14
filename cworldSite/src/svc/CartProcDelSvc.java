package svc;

import static db.jdbcUtil.*;
import java.sql.*;
import dao.*;

public class CartProcDelSvc {
	public int cartDel(String where) {
		int result = 0;
		Connection conn = getConnection();
		CartDao cartDao = CartDao.getInstance();
		cartDao.setConnection(conn);
		
		result = cartDao.cartDel(where);
		if(result > 0) 		commit(conn);
		else				rollback(conn);
		close(conn);
		return result;
	}
}
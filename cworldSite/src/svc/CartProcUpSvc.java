package svc;

import static db.jdbcUtil.*;
import java.sql.*;
import dao.*;
import vo.*;

public class CartProcUpSvc {
	public int cartUpdate(String kind, OrderCart oc) {
		int result = 0;
		Connection conn = getConnection();
		CartDao cartDao = CartDao.getInstance();
		cartDao.setConnection(conn);
		result = cartDao.cartUpdate(kind, oc);
		if (result > 0)  commit(conn);
		else 			 rollback(conn);
		close(conn);
		return result;
	}
}

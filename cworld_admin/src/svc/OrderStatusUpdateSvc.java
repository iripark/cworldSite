package svc;

import static db.JdbcUtil.*;
import java.sql.*;
import dao.*;

public class OrderStatusUpdateSvc {
	public int statusUpdate(String oiid, String status) {
		int result = 0;
		
		Connection conn = getConnection();
		OrderStatusUpdateDao orderStatusUpdateDao = OrderStatusUpdateDao.getInstance();
		orderStatusUpdateDao.setConnection(conn);
		
		result = orderStatusUpdateDao.statusUpdate(oiid, status);
		if (result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
		close(conn);	
		return result;
	}

	public void invoiceUpdate(String oiid, String invoice) {
		int result = 0;
		Connection conn = getConnection();
		OrderStatusUpdateDao orderStatusUpdateDao = OrderStatusUpdateDao.getInstance();
		orderStatusUpdateDao.setConnection(conn);
		
		result = orderStatusUpdateDao.invoiceUpdate(oiid, invoice);
		if (result > 0) {
			commit(conn);
		} else {
			rollback(conn);
		}
	}

}

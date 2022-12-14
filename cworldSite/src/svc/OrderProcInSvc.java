package svc;

import static db.jdbcUtil.*;
import java.util.*;
import java.sql.*;
import dao.*;
import vo.*;

public class OrderProcInSvc {
	public String orderInsert(OrderInfo oi, String where) {
		String result = null;
		Connection conn = getConnection();
		OrderDao orderDao = OrderDao.getInstance();
		orderDao.setConnection(conn);

		result = orderDao.orderInsert(oi, where);
		String[] arr = result.split(":");
		int rcount = Integer.parseInt(arr[1]);	// 실제 적용된 레코드 개수
		int target = Integer.parseInt(arr[2]);	// 적용되었어야 할 레코드 개수
		if (rcount == target)	commit(conn);
		else					rollback(conn);
		close(conn);

		return result;
	}
	public String orderInsert(OrderInfo oi) {
		String result = null;
		Connection conn = getConnection();
		OrderDao orderDao = OrderDao.getInstance();
		orderDao.setConnection(conn);

		result = orderDao.orderInsert(oi);
		String[] arr = result.split(":");
		int rcount = Integer.parseInt(arr[1]);	// 실제 적용된 레코드 개수
		int target = Integer.parseInt(arr[2]);	// 적용되었어야 할 레코드 개수
		if (rcount == target)	commit(conn);
		else					rollback(conn);
		close(conn);

		return result;
	}
}

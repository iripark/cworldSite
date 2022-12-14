package svc;

import static db.jdbcUtil.*;
import java.sql.*;
import java.util.*;
import vo.*;
import dao.*;

public class CartViewSvc {
	public ArrayList<OrderCart> getCartList(String miid){
	Connection conn = getConnection();
	CartDao cartDao = CartDao.getInstance();
	cartDao.setConnection(conn);
	
	ArrayList<OrderCart> cartList = cartDao.getCartList(miid);
	close(conn);
	return cartList;
	}
}

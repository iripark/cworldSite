package svc;

import static db.jdbcUtil.*;
import java.sql.*;
import java.util.*;

import dao.*;
import vo.*;


public class OrderFormSvc {
	public ArrayList<OrderCart> getBuyList(String kind, String sql){
		ArrayList<OrderCart> buyList = new ArrayList<OrderCart>();
		Connection conn = getConnection();
		OrderDao orderDao = OrderDao.getInstance();
		orderDao.setConnection(conn);
		
		buyList = orderDao.getBuyList(kind, sql);
		close(conn);
		
		return buyList;
	}
	public ArrayList<MemberAddr> getAddrList(String miid){
		ArrayList<MemberAddr> addrList = new ArrayList<MemberAddr>();
		Connection conn = getConnection();
		OrderDao orderDao = OrderDao.getInstance();
		orderDao.setConnection(conn);
		
		addrList = orderDao.getAddrList(miid);
		close(conn);
		
		return addrList;
	}
}
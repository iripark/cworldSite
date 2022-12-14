package svc;

import static db.jdbcUtil.*;
import java.sql.*;
import java.util.*;

import dao.*;
import vo.*;

public class ProductListSvc {
	public int getProductCount(String where) {
		int rcnt = 0;
		Connection conn = getConnection();
		ProductDao productDao = ProductDao.getInstance();
		productDao.setConnection(conn);
		rcnt = productDao.getProductCount(where);
		close(conn);
		return rcnt;
	}
	
	public ArrayList<PdtInfo> getProductList(int cpage, int psize, String where, String orderBy){
		ArrayList<PdtInfo> productList = new ArrayList<PdtInfo>();
		Connection conn = getConnection();
		ProductDao productDao = ProductDao.getInstance();
		productDao.setConnection(conn);
		
		productList = productDao.getProductList(cpage, psize, where, orderBy);
		close(conn);
		
		
		return productList;
	}
	
	public ArrayList<PdtCtgrSmall> getSmallList(String pcb){
		ArrayList<PdtCtgrSmall> smallList = new ArrayList<PdtCtgrSmall>();
		Connection conn = getConnection();
		ProductDao productDao = ProductDao.getInstance();
		productDao.setConnection(conn);	
		
		smallList = productDao.getSmallList(pcb);
		close(conn);
		
		return smallList;
	}
	

}


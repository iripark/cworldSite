package svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
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
	public ArrayList<ProductInfo> getProductList(int cpage, int psize, String where) {
		ArrayList<ProductInfo> productList = new ArrayList<ProductInfo>();
		
		Connection conn = getConnection();
		ProductDao productDao = ProductDao.getInstance();
		productDao.setConnection(conn);
		
		productList = productDao.getProductList(cpage, psize, where);
		close(conn);
		
		return productList;
	}
	public ArrayList<PdtCtgrSmall> getSmallList(String pcb) {
		ArrayList<PdtCtgrSmall> smallList = new ArrayList<PdtCtgrSmall>();
		
		Connection conn = getConnection();
		ProductDao productDao = ProductDao.getInstance();
		productDao.setConnection(conn);
		
		smallList = productDao.getSmallList(pcb);
		close(conn);
		
		return smallList;
	}
	public int getRentCount(String where) {
		int rcnt = 0;
		
		Connection conn = getConnection();
		ProductDao productDao = ProductDao.getInstance();
		productDao.setConnection(conn);
		
		rcnt = productDao.getRentCount(where);
		close(conn);
		
		return rcnt;
	}
	public ArrayList<RentInfo> getRentList(int cpage, int psize, String where) {
		ArrayList<RentInfo> rentList = new ArrayList<RentInfo>();
		
		Connection conn = getConnection();
		ProductDao productDao = ProductDao.getInstance();
		productDao.setConnection(conn);
		
		rentList = productDao.getRentList(cpage, psize, where);
		close(conn);
		
		return rentList;
	}
}

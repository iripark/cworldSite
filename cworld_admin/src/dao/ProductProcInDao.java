package dao;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import vo.*;

public class ProductProcInDao {
	private static ProductProcInDao productProcInDao;	
	private Connection conn;			
	private ProductProcInDao() {}
	public static ProductProcInDao getInstance() {
		if (productProcInDao == null) {
			productProcInDao = new ProductProcInDao();
		}		
		return productProcInDao;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public int productInsert(ProductInfo productInfo, int ps_stock, String ps_opt) {
		int result = 0;
		CallableStatement cstmt = null;
		
		try {
			String sql = "call sp_product_info_insert (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			cstmt = conn.prepareCall(sql);
			cstmt.setString(1, productInfo.getPi_id());
			cstmt.setString(2, productInfo.getPcb_id());
			cstmt.setString(3, productInfo.getPcs_id());
			cstmt.setString(4, productInfo.getPi_name());
			cstmt.setInt(5, productInfo.getPi_price());
			cstmt.setInt(6, productInfo.getPi_cost());
			cstmt.setInt(7, productInfo.getPi_dc());
			cstmt.setInt(8, productInfo.getPi_dcprice());
			cstmt.setInt(9, productInfo.getPi_dfee());
			cstmt.setString(10, productInfo.getPi_img1());
			cstmt.setString(11, productInfo.getPi_img2());
			cstmt.setString(12, productInfo.getPi_img3());
			cstmt.setString(13, productInfo.getPi_desc());
			cstmt.setString(14, productInfo.getPi_special());
			cstmt.setString(15, productInfo.getPi_isview());
			result = cstmt.executeUpdate();
			if (result == 1) {
				result = 0;
				sql = "call sp_product_stock_insert (?,?,?,?)";
				cstmt = conn.prepareCall(sql);
				cstmt.setString(1, productInfo.getPi_id());
				cstmt.setString(2, ps_opt);
				cstmt.setInt(3, ps_stock);
				cstmt.setString(4, productInfo.getPi_isview());
				result = cstmt.executeUpdate();
			}
			
		} catch(Exception e) {
			System.out.println("ProductProcInDao 클래스의 productInsert() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(cstmt);
		}
		
		
		return result;
	}
	public int productOptInsert(ProductInfo productInfo, int ps_stock, String ps_opt) {
		int result = 0;
		Statement stmt = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		try {
			String sql = "";
			String sql2 = "update t_product_info set pi_img1 = '" + productInfo.getPi_img1() + "', pi_img2 = '" +  productInfo.getPi_img2() + "', pi_img3 = '" +  productInfo.getPi_img3() + "' where pi_id = '" + productInfo.getPi_id() + "'";
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql2);
			if (result == 1) {
				sql2 = "select count(*) from t_product_stock where pi_id = '" + productInfo.getPi_id() + "' and ps_opt = '" + ps_opt + "'";
				rs = stmt.executeQuery(sql2);
				rs.next();
				if (rs.getInt(1) == 1) {
					sql = "update t_product_stock set ps_stock = ps_stock + " + ps_stock + " where pi_id = '" + productInfo.getPi_id() + "' and ps_opt = '" + ps_opt + "'";
					result = stmt.executeUpdate(sql);
				} else {
					sql = "call sp_product_stock_insert(?, ?, ?, ?)";
					cstmt = conn.prepareCall(sql);
					cstmt.setString(1, productInfo.getPi_id());
					cstmt.setString(2, ps_opt);
					cstmt.setInt(3, ps_stock);
					cstmt.setString(4, productInfo.getPi_isview());
					result = cstmt.executeUpdate();
					close(cstmt);
				}
			}
			
			
			
		} catch(Exception e) {
			System.out.println("ProductProcInDao 클래스의 productOptInsert() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);

			close(stmt);
		}
		return result;
	}
}

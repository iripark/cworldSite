package dao;

import static db.jdbcUtil.*;
import java.util.*;
import java.sql.*;
import java.time.LocalDate;

import vo.*;

public class OrderDao {
	private static OrderDao orderDao;	
	private Connection conn;
	private OrderDao() {}
	public static OrderDao getInstance() {
		if (orderDao == null) orderDao = new OrderDao();
		return orderDao;
	}
	public void setConnection(Connection conn) {
		this.conn = conn;
	}	
	
	public ArrayList<OrderCart> getBuyList(String kind, String sql){
		ArrayList<OrderCart> buyList = new ArrayList<OrderCart>();
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement();
			System.out.println(sql);
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				OrderCart oc = new OrderCart();
				oc.setPi_id(rs.getString("pi_id"));
				oc.setPs_idx(rs.getInt("ps_idx"));
				oc.setOc_cnt(rs.getInt("cnt"));
				oc.setPi_name(rs.getString("pi_name"));
				oc.setPi_price(rs.getInt("pi_price"));
				oc.setPi_dc(rs.getInt("pi_dc"));
				oc.setRealPrice(rs.getInt("realPrice"));
				oc.setPi_dfee(rs.getInt("pi_dfee"));
				oc.setPs_opt(rs.getString("ps_opt"));
				oc.setOcr_sdate(rs.getString("sdate"));
				oc.setOcr_edate(rs.getString("edate"));
				oc.setOcr_period(rs.getInt("ocr_period"));
				oc.setPi_img1(rs.getString("pi_img1"));
				if(kind.contentEquals("c")) {
					oc.setOc_date(rs.getString("oc_date"));
					oc.setOc_idx(rs.getInt("oc_idx"));
				}
				buyList.add(oc);
			}
			
		} catch (Exception e) {
			System.out.println("OrderDao클래스의 getBuyList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs); close(stmt);
		}	
		return buyList;
	}
	public ArrayList<MemberAddr> getAddrList(String miid) {
		ArrayList<MemberAddr> addrList = new ArrayList<MemberAddr>();
		MemberAddr ma = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement();
			String sql = "select * from t_member_addr where mi_id = '" + miid + "' order by ma_basic desc;";
			System.out.println(sql);
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				ma = new MemberAddr();
				ma.setMi_id(rs.getString("mi_id"));
				ma.setMa_idx(rs.getInt("ma_idx"));
				ma.setMa_name(rs.getString("ma_name"));
				ma.setMa_phone(rs.getString("ma_phone"));
				ma.setMa_receiver(rs.getString("ma_receiver"));
				ma.setMa_zip(rs.getString("ma_zip"));
				ma.setMa_addr1(rs.getString("ma_addr1"));
				ma.setMa_addr2(rs.getString("ma_addr2"));
				ma.setMa_basic(rs.getString("ma_basic"));
				ma.setMa_date(rs.getString("ma_date"));
				addrList.add(ma);
				
			}
			
		} catch (Exception e) {
			System.out.println("OrderDao클래스의 getAddrList() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs); close(stmt);
		}	
		return addrList;
	}
	public String getOrderId() {
		// 새로운 주문번호(일련번호(yymmdd + 랜덤영문 + 3자리로 101))를 생성하여 리턴하는 메소드
		Statement stmt = null;
		ResultSet rs = null;
		String oi_id = null;

		try {
			stmt = conn.createStatement();
			LocalDate today = LocalDate.now();	// yyyy-mm-dd
			String td = (today + "").substring(2).replace("-", "");	// yymmdd

			String alpha = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
			Random rnd = new Random();
			char rn = alpha.charAt(rnd.nextInt(26));

			String sql = "select right(oi_id, 3) from t_order_info " + 
			" where left(oi_id, 6) = '" + td + "' order by oi_date desc limit 0, 1";
			// 같은 날 입력된 주문번호들 중 가장 최근 것을 가져오는 쿼리
			rs = stmt.executeQuery(sql);
			if (rs.next()) {	// 오늘 구매한 주문번호가 있으면
				int num = Integer.parseInt(rs.getString(1)) + 1;
				oi_id = td + rn + num;
			} else {	// 오늘 첫 구매일 경우
				oi_id = td + rn + "101";
			}

		} catch(Exception e) {
			System.out.println("OrderDao 클래스의 getOrderId() 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}

		return oi_id;
	}

	public String orderInsert(OrderInfo oi, String where) {
	// 장바구니를 통해 상품을 구매할 경우 동작할 메소드로 주문번호와 실행된 레코드 개수, 실행되야 할 레코드 개수등을 문자열로 리턴
		Statement stmt = null;
		ResultSet rs = null;
		String oi_id = getOrderId();
		String result = oi_id + ":";
		int rcount = 0, target = 0;
		// rcount : 실제 쿼리 실행결과로 정상적으로 적용되는 레코드 개수를 저장할 변수
		// target : insert, update, delete 등의 쿼리 실행횟수로 적용되어야 할 레코드의 개수를 저장할 변수

		try {
			stmt = conn.createStatement();

			// t_order_info 테이블에 사용할 insert 문
			String sql = "insert into t_order_info (oi_id, mi_id, oi_rname, oi_rphone, " + 
			"oi_rzip, oi_raddr1, oi_raddr2, oi_payment, oi_pay, oi_status) values ('" + 
			oi_id				+ "', '" + oi.getMi_id()		+ "', '" + 
			oi.getOi_rname() 	+ "', '" + oi.getOi_rphone()	+ "', '" + 
			oi.getOi_rzip()		+ "', '" + oi.getOi_raddr1()	+ "', '" + 
			oi.getOi_raddr2()	+ "', '" + oi.getOi_payment()	+ "', '" + 
			oi.getOi_pay()		+ "', '" + oi.getOi_status()	+ "') ";
			rcount = stmt.executeUpdate(sql);	target++;

			// t_order_detail 테이블에 insert할 상품 정보(들)를 장바구니 테이블에서 추출하는 select 문
			sql = "select a.*, b.pi_name, b.pi_dfee, b.pi_price, b.pi_dc, b.pi_img1, " + 
				" b.pi_price*(100-b.pi_dc)/100 price, c.ps_opt, left(d.ocr_sdate, 10) sdate, " 
				+ " left(d.ocr_edate, 10) edate, d.ocr_period, a.oc_cnt, a.oc_idx " + 
				" from t_order_cart a " + 
				" left join t_product_info b on b.pi_id = a.pi_id " + 
				" left join t_product_stock c on a.ps_idx = c.ps_idx and a.pi_id = c.pi_id " + 
				" left join t_order_cart_rent d on d.oc_idx = a.oc_idx " + 
				"where b.pi_isview = 'y' and c.ps_isview = 'y' " + where;
			System.out.println(sql);
			rs = stmt.executeQuery(sql);
			if (rs.next()) {	// 장바구니에서 구매하기 위해 선택한 상품이 있을 경우
				do {
					Statement stmt2 = conn.createStatement();
					String piid = rs.getString("pi_id");
					if (piid.charAt(0) == 'S') { // 구매 상품의 경우 t_order_sale_detail 테이블에 사용할 insert 문
						sql = "insert into t_order_sale_detail (oi_id, pi_id, ps_idx, " + 
						"osd_cnt, osd_price, osd_pname, osd_pimg, osd_popt) values ('" + 
						oi_id				+ "', '" + rs.getString("pi_id")	+ "', '" + 
						rs.getInt("ps_idx")	+ "', '" + rs.getInt("oc_cnt")		+ "', '" + 
						rs.getInt("price")	+ "', '" + rs.getString("pi_name")	+ "', '" + 
						rs.getString("pi_img1")	+ "', '" + rs.getString("ps_opt") + "') ";
					} else {	// 대여 상품의 경우 t_order_rent_detail 테이블에 사용할 insert 문
						sql = "insert into t_order_rent_detail (oi_id, pi_id, ps_idx, " + 
							"ord_cnt, ord_price, ord_pname, ord_pimg, ord_sdate, "
							+ "ord_edate) values ('" + 
							oi_id				+ "', '" + rs.getString("pi_id")	+ "', '" + 
							rs.getInt("ps_idx")	+ "', '" + rs.getInt("oc_cnt")		+ "', '" + 
							rs.getInt("price")	+ "', '" + rs.getString("pi_name")	+ "', '" + 
							rs.getString("pi_img1")	+ "', '" + rs.getString("sdate") + "', '" + 
							rs.getString("edate")+ "') ";
						
					}
					rcount += stmt2.executeUpdate(sql);	target++;
					
					// t_product_info 테이블의 상품 판매수를 증가시킬 update 문
					sql = "update t_product_info set pi_srcnt = pi_srcnt + " + 
					rs.getInt("oc_cnt") + " where pi_id = '" + rs.getString("pi_id") + "' ";
					rcount += stmt2.executeUpdate(sql);	target++;

					// t_product_stock 테이블의 판매 및 재고량 수를 증감시킬 update 문
					sql = "update t_product_stock set ps_stock = ps_stock - " + 
					rs.getInt("oc_cnt") + ", ps_sale = ps_sale + " + 
					rs.getInt("oc_cnt") + " where ps_idx = " + rs.getInt("ps_idx");
					rcount += stmt2.executeUpdate(sql);	target++;
				} while(rs.next());

			} else {	// 장바구니에서 구매하기 위해 선택한 상품이 없을 경우
				return result + "1:4";
			}

			// 포인트 사용시 실행할 update 및 insert 문
			if (oi.getOi_upoint() > 0) {	// 구매시 포인트를 사용했으면
				sql = "update t_member_info set mi_point = mi_point - " + 
				(oi.getOi_upoint() - oi.getOi_spoint()) + " where mi_id = '" + oi.getMi_id() + "' ";
				rcount += stmt.executeUpdate(sql);	target++;

				sql = "insert into t_member_point (mi_id, mp_issu, mp_point, " + 
				"mp_desc, mp_num) values ('" + oi.getMi_id() + "', 'u', '" + 
				oi.getOi_upoint() + "', '상품 구매', '" + oi_id + "') ";
				rcount += stmt.executeUpdate(sql);	target++;
				
				sql = "insert into t_member_point (mi_id, mp_issu, mp_point, " + 
						"mp_desc, mp_num) values ('" + oi.getMi_id() + "', 's', '" + 
						oi.getOi_spoint() + "', '상품 구매', '" + oi_id + "') ";
				rcount += stmt.executeUpdate(sql);	target++;
			} else {	// 포인트 미사용시 포인트 적립
				int pnt = oi.getOi_spoint();	// 적립할 포인트
				sql = "update t_member_info set mi_point = mi_point + " + 
				pnt + " where mi_id = '" + oi.getMi_id() + "' ";
				rcount += stmt.executeUpdate(sql);	target++;

				sql = "insert into t_member_point (mi_id, mp_issu, mp_point, " + 
				"mp_desc, mp_num) values ('" + oi.getMi_id() + "', 's', '" + 
				pnt + "', '상품 구매', '" + oi_id + "') ";
				rcount += stmt.executeUpdate(sql);	target++;
			}
			// 카트 삭제에 앞서 렌트가 있다면 렌트부터 삭제
			sql = "delete from t_order_cart_rent a where 1=1 " + where;
			stmt.executeUpdate(sql);
			// t_order_cart 테이블에 사용할 delete 문
			sql = "delete from t_order_cart a where 1=1 " + where;
			stmt.executeUpdate(sql);
			// 실행시 문제가 발생해도 구매와는 상관없으므로 rcount에 누적시키지 않음

		} catch(Exception e) {
			System.out.println("OrderDao 클래스의 orderInsert(2) 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}

		return result + rcount + ":" + target;
	}
	
	public String orderInsert(OrderInfo oi) {
		Statement stmt = null;
		ResultSet rs = null;
		String oi_id = getOrderId();
		String result = oi_id + ":";
		int rcount = 0, target = 0;
		// rcount : 실제 쿼리 실행결과로 정상적으로 적용되는 레코드 개수를 저장할 변수
		// target : insert, update, delete 등의 쿼리 실행횟수로 적용되어야 할 레코드의 개수를 저장할 변수

		try {
			stmt = conn.createStatement();
			// t_order_info 테이블에 사용할 insert 문
			String sql = "insert into t_order_info (oi_id, mi_id, oi_rname, oi_rphone, " + 
			"oi_rzip, oi_raddr1, oi_raddr2, oi_payment, oi_pay, oi_status) values ('" + 
			oi_id				+ "', '" + oi.getMi_id()		+ "', '" + 
			oi.getOi_rname() 	+ "', '" + oi.getOi_rphone()	+ "', '" + 
			oi.getOi_rzip()		+ "', '" + oi.getOi_raddr1()	+ "', '" + 
			oi.getOi_raddr2()	+ "', '" + oi.getOi_payment()	+ "', '" + 
			oi.getOi_pay()		+ "', '" + oi.getOi_status()	+ "') ";
			rcount = stmt.executeUpdate(sql);	target++;
			
			String piid = oi.getPi_id();
			sql = "select a.pi_name, a.pi_price*(100 - a.pi_dc)/100 price, a.pi_dfee, b.ps_opt, " +
				" a.pi_img1 "	+ " from t_product_info a, t_product_stock b "
				+ " where a.pi_id = b.pi_id and a.pi_id = '" + piid + "' and ps_idx = " + oi.getPs_idx();
			rs = stmt.executeQuery(sql);
			
			if (rs.next()) {
				String pi_name = rs.getString("pi_name");
				int price = rs.getInt("price");
				int dfee = rs.getInt("pi_dfee");
				String pi_img1 = rs.getString("pi_img1");
				int cnt = 0;
				if (piid.charAt(0) == 'S') {	// t_order_sale_detail 테이블에 insert 문
					sql = "insert into t_order_sale_detail (oi_id, pi_id, ps_idx, osd_cnt, "
							+ "osd_price, osd_pname, osd_pimg, osd_popt) values ('" +
					oi_id				+ "', '" + piid						+ "', '" + 
					oi.getPs_idx()	 	+ "', '" + oi.getOsd_cnt()			+ "', '" + 
					price				+ "', '" + pi_name					+ "', '" + 
					pi_img1				+ "', '" + rs.getString("ps_opt")	+ "') ";
					
					cnt = oi.getOsd_cnt();
				} else {
					sql = "insert into t_order_rent_detail (oi_id, pi_id, ps_idx, ord_cnt, "
							+ "ord_price, ord_pname, ord_pimg, ord_sdate, ord_edate) values ('" +
					oi_id				+ "', '" + piid						+ "', '" + 
					oi.getPs_idx()	 	+ "', '" + oi.getOrd_cnt()			+ "', '" + 
					price				+ "', '" + pi_name					+ "', '" + 
					pi_img1				+ "', '" + oi.getOrd_sdate()		+ "', '" + 
					oi.getOrd_edate() + "') ";
					cnt = oi.getOrd_cnt();
				}
				rcount += stmt.executeUpdate(sql);	target++;
				
				// t_product_info 테이블의 상품 판매수를 증가시킬 update 문
				sql = "update t_product_info set pi_srcnt = pi_srcnt + " + 
						cnt + " where pi_id = '" + piid + "' ";
				rcount += stmt.executeUpdate(sql);	target++;

				// t_product_stock 테이블의 판매 및 재고량 수를 증감시킬 update 문
				sql = "update t_product_stock set ps_stock = ps_stock - " + 
						cnt + ", ps_sale = ps_sale + " + 
						cnt + " where ps_idx = " + oi.getPs_idx();
				rcount += stmt.executeUpdate(sql);	target++;
			} else {
				return result + "1:4";
			}
			

			// 포인트 사용시 실행할 update 및 insert 문
			if (oi.getOi_upoint() > 0) {	// 구매시 포인트를 사용했으면
				sql = "update t_member_info set mi_point = mi_point - " + 
				(oi.getOi_upoint() - oi.getOi_spoint()) + " where mi_id = '" + oi.getMi_id() + "' ";
				rcount += stmt.executeUpdate(sql);	target++;
				
				sql = "insert into t_member_point (mi_id, mp_issu, mp_point, " + 
				"mp_desc, mp_num) values ('" + oi.getMi_id() + "', 'u', '" + 
				oi.getOi_upoint() + "', '상품 구매', '" + oi_id + "') ";;
				rcount += stmt.executeUpdate(sql);	target++;
				
				sql = "insert into t_member_point (mi_id, mp_issu, mp_point, " + 
						"mp_desc, mp_num) values ('" + oi.getMi_id() + "', 's', '" + 
						oi.getOi_spoint() + "', '상품 구매', '" + oi_id + "') ";
				rcount += stmt.executeUpdate(sql);	target++;
			} else {	// 포인트 미사용시 포인트 적립
				int pnt = oi.getOi_spoint();	// 적립할 포인트
				sql = "update t_member_info set mi_point = mi_point + " + 
				pnt + " where mi_id = '" + oi.getMi_id() + "' ";
				rcount += stmt.executeUpdate(sql);	target++;

				sql = "insert into t_member_point (mi_id, mp_issu, mp_point, " + 
				"mp_desc, mp_num) values ('" + oi.getMi_id() + "', 's', '" + 
				pnt + "', '상품 구매', '" + oi_id + "') ";
				rcount += stmt.executeUpdate(sql);	target++;
			}
		} catch(Exception e) {
			System.out.println("OrderDao 클래스의 orderInsert(1) 메소드 오류");
			e.printStackTrace();
		} finally {
			close(rs);	close(stmt);
		}

		return result + rcount + ":" + target;
	}
}

package vo;

import java.util.*;

public class OrderCart {
	private int oc_idx, ps_idx, oc_cnt, pi_price, pi_dc, pi_dfee, realPrice, ocr_period;
	private String mi_id, pi_id, oc_date, ocr_sdate, ocr_edate;
	private String pi_name, pi_img1, pi_img2, pi_img3, ps_opt;
	private ArrayList<PdtStock> stockList;
	
	public String getPi_img2() {
		return pi_img2;
	}
	public void setPi_img2(String pi_img2) {
		this.pi_img2 = pi_img2;
	}
	public String getPi_img3() {
		return pi_img3;
	}
	public void setPi_img3(String pi_img3) {
		this.pi_img3 = pi_img3;
	}
	public int getPi_dfee() {
		return pi_dfee;
	}
	public void setPi_dfee(int pi_dfee) {
		this.pi_dfee = pi_dfee;
	}
	public int getOc_idx() {
		return oc_idx;
	}
	public void setOc_idx(int oc_idx) {
		this.oc_idx = oc_idx;
	}
	public int getPs_idx() {
		return ps_idx;
	}
	public void setPs_idx(int ps_idx) {
		this.ps_idx = ps_idx;
	}
	public int getOc_cnt() {
		return oc_cnt;
	}
	public void setOc_cnt(int oc_cnt) {
		this.oc_cnt = oc_cnt;
	}
	
	public int getPi_price() {
		return pi_price;
	}
	public void setPi_price(int pi_price) {
		this.pi_price = pi_price;
	}
	public int getPi_dc() {
		return pi_dc;
	}
	public void setPi_dc(int pi_dc) {
		this.pi_dc = pi_dc;
	}
		
	public int getRealPrice() {
		return realPrice;
	}
	
	public void setRealPrice(int realPrice) {
		this.realPrice = realPrice;
	}
	
	public String getMi_id() {
		return mi_id;
	}
	public void setMi_id(String mi_id) {
		this.mi_id = mi_id;
	}
	public String getPi_id() {
		return pi_id;
	}
	public void setPi_id(String pi_id) {
		this.pi_id = pi_id;
	}
	public String getOc_date() {
		return oc_date;
	}
	public void setOc_date(String oc_date) {
		this.oc_date = oc_date;
	}
	public String getOcr_sdate() {
		return ocr_sdate;
	}
	public void setOcr_sdate(String ocr_sdate) {
		this.ocr_sdate = ocr_sdate;
	}
	public String getOcr_edate() {
		return ocr_edate;
	}
	public void setOcr_edate(String ocr_edate) {
		this.ocr_edate = ocr_edate;
	}
	public int getOcr_period() {
		return ocr_period;
	}
	public void setOcr_period(int ocr_period) {
		this.ocr_period = ocr_period;
	}
	public String getPi_name() {
		return pi_name;
	}
	public void setPi_name(String pi_name) {
		this.pi_name = pi_name;
	}
	public String getPi_img1() {
		return pi_img1;
	}
	public void setPi_img1(String pi_img1) {
		this.pi_img1 = pi_img1;
	}
	public String getPs_opt() {
		return ps_opt;
	}
	public void setPs_opt(String ps_opt) {
		this.ps_opt = ps_opt;
	}
	public ArrayList<PdtStock> getStockList() {
		return stockList;
	}
	public void setStockList(ArrayList<PdtStock> stockList) {
		this.stockList = stockList;
	}
	
}

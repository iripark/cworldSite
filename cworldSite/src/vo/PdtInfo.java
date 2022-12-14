package vo;
import java.util.*;

public class PdtInfo {
	private String pi_id, 	pcb_id, pcs_id, pi_name,  pi_img1, pi_img2, pi_img3, pi_desc, pi_special, 
	pi_date, pi_isview, mj_date;
	private int pi_price, pi_cost, pi_dc, pi_dfee, pi_read, pi_review, pi_jjim, pi_srcnt, stock;
	private double pi_score;
	
	private String pcsName, pcbName, pbName;
	private ArrayList<PdtStock> stockList;
	
	private int realPrice;
	
	public String getMj_date() {
		return mj_date;
	}
	public void setMj_date(String mj_date) {
		this.mj_date = mj_date;
	}
	public String getPi_id() {
		return pi_id;
	}
	public void setPi_id(String pi_id) {
		this.pi_id = pi_id;
	}
	public String getPcb_id() {
		return pcb_id;
	}
	public void setPcb_id(String pcb_id) {
		this.pcb_id = pcb_id;
	}
	public String getPcs_id() {
		return pcs_id;
	}
	public void setPcs_id(String pcs_id) {
		this.pcs_id = pcs_id;
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
	public String getPi_desc() {
		return pi_desc;
	}
	public void setPi_desc(String pi_desc) {
		this.pi_desc = pi_desc;
	}
	public String getPi_special() {
		return pi_special;
	}
	public void setPi_special(String pi_special) {
		this.pi_special = pi_special;
	}
	public String getPi_date() {
		return pi_date;
	}
	public void setPi_date(String pi_date) {
		this.pi_date = pi_date;
	}
	public String getPi_isview() {
		return pi_isview;
	}
	public void setPi_isview(String pi_isview) {
		this.pi_isview = pi_isview;
	}
	public int getPi_price() {
		return pi_price;
	}
	public void setPi_price(int pi_price) {
		this.pi_price = pi_price;
	}
	public int getPi_cost() {
		return pi_cost;
	}
	public void setPi_cost(int pi_cost) {
		this.pi_cost = pi_cost;
	}
	public int getPi_dc() {
		return pi_dc;
	}
	public void setPi_dc(int pi_dc) {
		this.pi_dc = pi_dc;
	}
	public int getPi_dfee() {
		return pi_dfee;
	}
	public void setPi_dfee(int pi_dfee) {
		this.pi_dfee = pi_dfee;
	}
	public int getPi_read() {
		return pi_read;
	}
	public void setPi_read(int pi_read) {
		this.pi_read = pi_read;
	}
	public int getPi_review() {
		return pi_review;
	}
	public void setPi_review(int pi_review) {
		this.pi_review = pi_review;
	}
	public int getPi_jjim() {
		return pi_jjim;
	}
	public void setPi_jjim(int pi_jjim) {
		this.pi_jjim = pi_jjim;
	}
	public int getPi_srcnt() {
		return pi_srcnt;
	}
	public void setPi_srcnt(int pi_srcnt) {
		this.pi_srcnt = pi_srcnt;
	}
	public int getStock() {
		return stock;
	}
	public void setStock(int stock) {
		this.stock = stock;
	}
	public double getPi_score() {
		return pi_score;
	}
	public void setPi_score(double pi_score) {
		this.pi_score = pi_score;
	}
	public String getPcsName() {
		return pcsName;
	}
	public void setPcsName(String pcsName) {
		this.pcsName = pcsName;
	}
	public String getPcbName() {
		return pcbName;
	}
	public void setPcbName(String pcbName) {
		this.pcbName = pcbName;
	}
	public String getPbName() {
		return pbName;
	}
	public void setPbName(String pbName) {
		this.pbName = pbName;
	}
	public ArrayList<PdtStock> getStockList() {
		return stockList;
	}
	public void setStockList(ArrayList<PdtStock> stockList) {
		this.stockList = stockList;
	}
	public int getRealPrice() {
		return realPrice;
	}
	public void setRealPrice(int realPrice) {
		this.realPrice = realPrice;
	} 
	
	
}

	// 현상 품에 속하는 옵션 및 재고량들을 저장할 리스트
	
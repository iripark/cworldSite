package vo;

public class MemberInfo {
// 한 명의 회원정보를 저장할 클래스
	private String mi_id, mi_pw, mi_name, mi_gender, mi_birth, mi_mail, mi_phone, mi_join, mi_last, mi_status, mi_adv;
	private int mi_point, mi_visited; 
	
	public String getMi_adv() {
		return mi_adv;
	}
	public void setMi_adv(String mi_adv) {
		this.mi_adv = mi_adv;
	}
	public int getMi_visited() {
		return mi_visited;
	}
	public void setMi_visited(int mi_visited) {
		this.mi_visited = mi_visited;
	}
	public String getMi_id() {		return mi_id;	}
	public void setMi_id(String mi_id) {		this.mi_id = mi_id;	}
	
	public String getMi_pw() {		return mi_pw;	}
	public void setMi_pw(String mi_pw) {		this.mi_pw = mi_pw;	}
	
	public String getMi_name() {	return mi_name;	}
	public void setMi_name(String mi_name) {	this.mi_name = mi_name;	}
	
	public String getMi_gender() {	return mi_gender;	}
	public void setMi_gender(String mi_gender) {this.mi_gender = mi_gender;	}
	
	public String getMi_birth() {	return mi_birth;	}
	public void setMi_birth(String mi_birth) {	this.mi_birth = mi_birth;	}
	
	public String getMi_mail() {	return mi_mail;	}
	public void setMi_mail(String mi_mail) {	this.mi_mail = mi_mail;	}
	
	public String getMi_phone() {	return mi_phone;	}
	public void setMi_phone(String mi_phone) {	this.mi_phone = mi_phone;	}
	
	public String getMi_join() {	return mi_join;	}
	public void setMi_join(String mi_join) {	this.mi_join = mi_join;	}
	
	public String getMi_last() {	return mi_last;	}
	public void setMi_last(String mi_last) {	this.mi_last = mi_last;	}
	
	public String getMi_status() {	return mi_status;	}
	public void setMi_status(String mi_status) {this.mi_status = mi_status;	}
	
	public int getMi_point() {		return mi_point;	}
	public void setMi_point(int mi_point) {		this.mi_point = mi_point;	}
	
}

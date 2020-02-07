package web.bmember.model;

import java.sql.Timestamp;

public class HDTO {
	private String id;
	private String pw;
	private String name;
	private String gender;
	private String birth;
	private String addr;
	private String phon;
	private String email;
	private String sns1;
	private String sns2;
	private Timestamp reg;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getPhon() {
		return phon;
	}
	public void setPhon(String phon) {
		this.phon = phon;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getSns1() {
		return sns1;
	}
	public void setSns1(String sns1) {
		this.sns1 = sns1;
	}
	public String getSns2() {
		return sns2;
	}
	public void setSns2(String sns2) {
		this.sns2 = sns2;
	}
	public Timestamp getReg() {
		return reg;
	}
	public void setReg(Timestamp reg) {
		this.reg = reg;
	}
	
	
	
}

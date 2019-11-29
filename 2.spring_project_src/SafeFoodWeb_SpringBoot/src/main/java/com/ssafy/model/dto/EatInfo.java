package com.ssafy.model.dto;

public class EatInfo {
	int no;
	String id;
	String code;
	int cnt;
	String date;
	
	
	@Override
	public String toString() {
		return "EatInfo [no=" + no + ", id=" + id + ", code=" + code + ", cnt=" + cnt + ", date=" + date + "]";
	}




	public EatInfo() {
		super();
	}
	
	
	
	
	public String getDate() {
		return date;
	}




	public void setDate(String date) {
		this.date = date;
	}




	public EatInfo(String id, String code, int cnt, String date) {
		super();
		this.id = id;
		this.code = code;
		this.cnt = cnt;
		this.date = date;
	}
	public EatInfo(int no, String id, String code, int cnt, String date) {
		super();
		this.no = no;
		this.id = id;
		this.code = code;
		this.cnt = cnt;
		this.date = date;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	
	
}

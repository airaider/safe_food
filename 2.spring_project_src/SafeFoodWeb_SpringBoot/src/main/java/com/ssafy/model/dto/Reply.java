package com.ssafy.model.dto;

import java.io.Serializable;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;
public class Reply implements Serializable {
	private int no        	 ;
	private String id        ;
	private String contents  ;
	private String regdate   ;
	private int fno			 ;
	
	public Reply() {};
	
	public Reply(int no, String id, String contents, String regdate) {
		super();
		this.no = no;
		this.id = id;
		this.contents = contents;
		this.regdate = regdate;
	}
	
	public Reply(int no, String id, String contents, String regdate, int fno) {
		super();
		this.no = no;
		this.id = id;
		this.contents = contents;
		this.regdate = regdate;
		this.fno = fno;
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

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public int getFno() {
		return fno;
	}

	public void setFno(int fno) {
		this.fno = fno;
	}

	@Override
	public String toString() {
		return "Reply [no=" + no + ", id=" + id + ", contents=" + contents + ", regdate=" + regdate + ", fno=" + fno
				+ "]";
	}
}

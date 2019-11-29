package com.ssafy.model.dto;

import java.io.Serializable;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;
public class Notice implements Serializable {
	private int no        	 ;
	private String id		 ;
	private String title     ;
	private String contents  ;
	private String regdate   ;
	public Notice() {};
	
	public Notice(int no, String id, String title, String contents, String regdate) {
		super();
		this.no = no;
		this.id = id;
		this.title = title;
		this.regdate = regdate;
		this.contents = contents;
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
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	@Override
	public String toString() {
		return "Notice [no=" + no + ", title=" + title + ", regdate=" + regdate + ", contents=" + contents
				+ "]";
	}
	
	
}

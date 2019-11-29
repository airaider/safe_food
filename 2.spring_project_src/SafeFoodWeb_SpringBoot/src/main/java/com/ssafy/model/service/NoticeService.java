package com.ssafy.model.service;

import java.util.List;

import com.ssafy.model.dto.Notice;

public interface NoticeService {
	public void insert(Notice notice);
	public void update(Notice notice);
	public void reply(Notice notice);
	public void delete(String no);
	public Notice search(String no);
	public List<Notice> searchAll();
}

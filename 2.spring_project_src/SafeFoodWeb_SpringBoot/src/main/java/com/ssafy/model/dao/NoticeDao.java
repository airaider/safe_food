package com.ssafy.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.model.dto.Notice;

@Mapper
public interface NoticeDao {
	public void insert(Notice notice);
	public void update(Notice notice);
	public void reply(Notice notice);
	public void delete(String no);
	public Notice search(String no);
	public List<Notice> searchAll();
}

package com.ssafy.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.model.dto.FAQ;
import com.ssafy.model.dto.Reply;

@Mapper
public interface ReplyDao {
	public void insert(Reply reply);
	public void update(Reply reply);
	public void delete(String no);
	public Reply search(String no);
	public List<Reply> searchAll(String qno);
}

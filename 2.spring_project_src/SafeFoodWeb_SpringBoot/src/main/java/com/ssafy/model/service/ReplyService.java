package com.ssafy.model.service;

import java.util.List;

import com.ssafy.model.dto.FAQ;
import com.ssafy.model.dto.Reply;

public interface ReplyService {
	public void insert(Reply reply);
	public void update(Reply reply);
	public void delete(String no);
	public Reply search(String no);
	public List<Reply> searchAll(String qno);
}

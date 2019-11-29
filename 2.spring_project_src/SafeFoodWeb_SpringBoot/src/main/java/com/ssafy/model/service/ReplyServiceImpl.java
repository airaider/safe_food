package com.ssafy.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.model.dao.FAQDao;
import com.ssafy.model.dao.ReplyDao;
import com.ssafy.model.dto.FAQ;
import com.ssafy.model.dto.FAQException;
import com.ssafy.model.dto.Reply;

@Service
public class ReplyServiceImpl implements ReplyService {
	@Autowired
	private ReplyDao dao;
	public void insert(Reply reply) {
		try {
			dao.insert(reply);
		}catch (Exception e) {
			e.printStackTrace();
			throw new FAQException("## reply 입력 중 오류 발생 ##");
		}
	}

	public void update(Reply reply) {
		try {
			dao.update(reply);
		}catch (Exception e) {
			e.printStackTrace();
			throw new FAQException("## reply 수정 중 오류 발생 ##");
		}
	}

	public void delete(String no) {
		try {
			dao.delete(no);
		}catch (Exception e) {
			e.printStackTrace();
			throw new FAQException("## FAQ 삭제 중 오류 발생 ##");
		}
	}

	public Reply search(String no) {
		try {
			return dao.search(no);
		}catch (Exception e) {
			e.printStackTrace();
			throw new FAQException("## reply 검색 중 오류 발생 ##");
		}
	}

	public List<Reply> searchAll(String qno) {
		try {
			return dao.searchAll(qno);
		}catch (Exception e) {
			e.printStackTrace();
			throw new FAQException("## 해당 글 Reply 전체 검색 중 오류 발생 ##");
		}
	}
}

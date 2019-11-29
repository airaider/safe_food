package com.ssafy.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.model.dao.FAQDao;
import com.ssafy.model.dao.NoticeDao;
import com.ssafy.model.dto.Notice;
import com.ssafy.model.dto.FAQException;

@Service
public class NoticeServiceImpl implements NoticeService {
	@Autowired
	private NoticeDao dao;
	public void insert(Notice notice) {
		try {
			dao.insert(notice);
		}catch (Exception e) {
			e.printStackTrace();
			throw new FAQException("## notice 입력 중 오류 발생 ##");
		}
	}

	public void update(Notice notice) {
		try {
			dao.update(notice);
		}catch (Exception e) {
			e.printStackTrace();
			throw new FAQException("## notice 수정 중 오류 발생 ##");
		}
	}

	public void reply(Notice notice) {
		try {
			dao.insert(notice);
		}catch (Exception e) {
			e.printStackTrace();
			throw new FAQException("## notice 답변 처리 중 오류 발생 ##");
		}
	}

	public void delete(String no) {
		try {
			dao.delete(no);
		}catch (Exception e) {
			e.printStackTrace();
			throw new FAQException("## notice 삭제 중 오류 발생 ##");
		}
	}

	public Notice search(String no) {
		try {
			return dao.search(no);
		}catch (Exception e) {
			e.printStackTrace();
			throw new FAQException("## FAQ 검색 중 오류 발생 ##");
		}
	}

	public List<Notice> searchAll() {
		try {
			return dao.searchAll();
		}catch (Exception e) {
			e.printStackTrace();
			throw new FAQException("## FAQ 전체 검색 중 오류 발생 ##");
		}
	}

}

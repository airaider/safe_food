package com.ssafy.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.model.dto.FAQ;

@Mapper
public interface FAQDao {
	public void insert(FAQ faq);
	public void update(FAQ faq);
	public void reply(FAQ faq);
	public void delete(String no);
	public FAQ search(String no);
	public List<FAQ> searchAll();
}

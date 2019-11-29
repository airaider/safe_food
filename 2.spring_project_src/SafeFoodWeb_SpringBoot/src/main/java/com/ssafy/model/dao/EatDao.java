package com.ssafy.model.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.model.dto.EatInfo;

@Mapper
public interface EatDao {
	public void add(EatInfo eatInfo);
	public void remove(String no); 
	public EatInfo search(int no);
	public void update(EatInfo eatInfo);
	public List<EatInfo> searchEatList(String id);
	public List<EatInfo> searchAll();
}

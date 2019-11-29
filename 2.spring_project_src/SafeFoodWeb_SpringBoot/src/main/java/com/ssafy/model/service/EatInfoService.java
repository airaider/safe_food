package com.ssafy.model.service;

import java.sql.SQLException;
import java.util.List;

import com.ssafy.model.dto.EatInfo;

public interface EatInfoService {
	public void add(EatInfo eatInfo);
	public void remove(String no); 
	public EatInfo search(int no);
	public void update(EatInfo eatInfo);
	public List<EatInfo> searchAll();
	public List<EatInfo> searchEatList(String id);
}

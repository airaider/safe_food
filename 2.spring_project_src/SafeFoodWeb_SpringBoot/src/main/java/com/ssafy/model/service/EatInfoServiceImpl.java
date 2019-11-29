package com.ssafy.model.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.model.dao.EatDao;
import com.ssafy.model.dto.EatInfo;
import com.ssafy.model.dto.MemberException;

@Service
public class EatInfoServiceImpl implements EatInfoService {
	@Autowired
	private EatDao dao;
	@Override
	public void add(EatInfo eatInfo) {		
			dao.add(eatInfo);
	}

	@Override
	public void remove(String no) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public EatInfo search(int no) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void update(EatInfo eatInfo) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<EatInfo> searchAll() {
		try {
			return dao.searchAll();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<EatInfo> searchEatList(String id) {
		try {
			return dao.searchEatList(id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

}

package com.ssafy.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.model.dao.SteamDao;
import com.ssafy.model.dto.Steam;
@Service
public class SteamServiceImpl implements SteamService {
	@Autowired
	private SteamDao dao;
	@Override
	public void add(Steam steam) {
		dao.add(steam);
	}

	@Override
	public void remove(int no) {
		dao.remove(no);
	}

	@Override
	public Steam search(int no) {
		return null;
	}

	@Override
	public void update(Steam steam) {

	}

	@Override
	public List<Steam> searchSteamList(String id) {
		try {
			return dao.searchSteamList(id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<Steam> searchAll() {
		try {
			return dao.searchAll();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

}

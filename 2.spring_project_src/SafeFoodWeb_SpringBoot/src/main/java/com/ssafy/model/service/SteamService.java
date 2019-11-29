package com.ssafy.model.service;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.model.dto.Steam;

public interface SteamService {
	public void add(Steam steam);
	public void remove(int no); 
	public Steam search(int no);
	public void update(Steam steam);
	public List<Steam> searchSteamList(String id);
	public List<Steam> searchAll();
}

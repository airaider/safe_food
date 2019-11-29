package com.ssafy.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.model.dto.Steam;

@Mapper
public interface SteamDao {
	public void add(Steam steam);
	public void remove(int no); 
	public Steam search(int no);
	public void update(Steam steam);
	public List<Steam> searchSteamList(String id);
	public List<Steam> searchAll();
}

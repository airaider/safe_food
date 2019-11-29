package com.ssafy.model.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.model.dto.Member;

@Mapper
public interface MemberDAO {
	public Member search( String id) throws SQLException;
	public void add(Member member)	 throws SQLException;
	public void update(Member member)throws SQLException;
	public void delete(String id)	 throws SQLException;
}













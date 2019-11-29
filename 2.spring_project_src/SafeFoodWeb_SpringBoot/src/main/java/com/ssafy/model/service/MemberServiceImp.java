package com.ssafy.model.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.model.dao.MemberDAO;
import com.ssafy.model.dto.Member;
import com.ssafy.model.dto.MemberException;

@Service
public class MemberServiceImp implements MemberService {
	@Autowired
	private MemberDAO dao;

	public boolean CheckValue(Member m) {
		// 아이디
		for (int i = 0; i < m.getId().length(); i++) {
			char ch = m.getId().charAt(i);
			if (ch >= 0x61 && ch <= 0x7A) {
				// 영문(소문자)
			} else if (ch >= 0x41 && ch <= 0x5A) {
				// 영문(대문자)
			} else if (ch >= 0x30 && ch <= 0x39) {
				// 숫자
			} else if (ch == 0x5F) {// _
			} else if (m.getId().length() > 30) {
				System.out.println("아이디 : 30자 이내의 알파벳,언더스코어(_), 숫자만 입력가능합니다.");
				throw new MemberException("아이디 : 30자 이내의 알파벳,언더스코어(_), 숫자만 입력가능합니다.");
			} else {
				System.out.println("아이디 : 30자 이내의 알파벳,언더스코어(_), 숫자만 입력가능합니다.");
				throw new MemberException("아이디 : 30자 이내의 알파벳,언더스코어(_), 숫자만 입력가능합니다.");
			}
		}
		//이름
		String regExp = "^[가-힣\\s]*$";
		if(m.getName().matches(regExp)==false) {
			throw new MemberException("이름 : 한글만 입력 가능합니다.");
		}
		
		//휴대폰 번호
		for(int i=0; i<m.getPhone().length(); i++) {
			char ch = m.getPhone().charAt(i);
			if(ch >= 0x30 && ch <= 0x39) {
				return true;
			}else {
				throw new MemberException("휴대폰 번호 : -를 제외하고 숫자만 입력하세요");
			}
		}
		
		return true;

	}

	public Member search(String id) {
		try {
			Member member = dao.search(id);
			if (member == null) {
				throw new MemberException("아이디를 입력하세요.");
			} else {
				return member;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw new MemberException();
		}
	}

	public boolean login(String id, String pw) {
		try {
			Member member = dao.search(id);
			if (member == null) {
				throw new MemberException("등록되지 않은 회원 아이디입니다.");
			} else {
				if (pw.equals(member.getPassword())) {
					return true;
				} else {
					throw new MemberException("비밀 번호 오류");
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
			throw new MemberException();
		}
	}

	public boolean checkID(String id) {
		try {
			Member member = dao.search(id);
			if (member == null) {
				return false;
			} else {
				return true;
			}
		} catch (SQLException e) {
			throw new MemberException();
		}
	}

	public void add(Member member) {
		try {
			Member find = dao.search(member.getId());
			if (find != null) {
				throw new MemberException("이미 등록된 아이디입니다.");
			} else {
				dao.add(member);
			}
		} catch (SQLException e) {
			throw new MemberException();
		}
	}

	public void update(Member member) {
		try {
			Member find = dao.search(member.getId());
			if (find == null) {
				throw new MemberException("수정할 회원 정보가 없습니다.");
			} else {
				dao.update(member);
			}
		} catch (SQLException e) {
			throw new MemberException();
		}
	}

	public void delete(String id) {
		try {
			Member find = dao.search(id);
			if (find == null) {
				throw new MemberException("탈퇴할 회원 정보가 없습니다.");
			} else {
				dao.delete(id);
			}
		} catch (SQLException e) {
			throw new MemberException();
		}
	}


}

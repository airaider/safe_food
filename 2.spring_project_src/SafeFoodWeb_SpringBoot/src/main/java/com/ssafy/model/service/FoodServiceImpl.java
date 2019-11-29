package com.ssafy.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.model.dao.FoodDao;
import com.ssafy.model.dto.Food;
import com.ssafy.model.dto.FoodPageBean;
import com.ssafy.model.dto.SafeFoodException;

@Service
public class FoodServiceImpl implements FoodService{
	@Autowired
	private FoodDao dao;
	private String[] allergys={"대두","땅콩","우유","게","새우","참치","연어","쑥","소고기","닭고기","돼지고기","복숭아","민들레","계란흰자"};

	public List<Food> searchAll(FoodPageBean bean) {
		try {
			return dao.searchAll(bean);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	public Food search(String code) {
		Food food = dao.search(code);
//		String mat = food.getMaterial();
//		String aller = "";
//		for (String str : allergys) {
//			if(mat.contains(str)) aller += str+ " "; 
//		}
//		if(aller != null) food.setAllergy(aller);
		if(food == null) {
			throw new SafeFoodException("등록되지 않은 음식입니다.");
		}else {
			return food;
		}
	}
	public List<Food> searchBest() {
		return dao.searchBest();
	}
	public List<Food> searchBestIndex() {
		return dao.searchBestIndex();
	}
}

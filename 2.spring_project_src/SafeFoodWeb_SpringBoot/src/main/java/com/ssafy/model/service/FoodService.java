package com.ssafy.model.service;

import java.util.List;

import com.ssafy.model.dto.Food;
import com.ssafy.model.dto.FoodPageBean;

public interface FoodService {
	
	public List<Food> searchAll(FoodPageBean bean);
	public Food search(String code);
	public List<Food> searchBest();
	public List<Food> searchBestIndex();	
}

package com.ssafy.util;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.ssafy.model.dto.Food;

public class FoodParsing {
	public static void main(String[] args) {
		FoodSaxParser fsp = null;
		Connection con = null;
		PreparedStatement stmt = null;
		System.out.println("parsing 시작");
		try {
			fsp = new FoodSaxParser();
			con = DBUtil.getConnection();
			for (Food f : fsp.getFoods()) {
				String sql = "insert into food(code, name, supportpereat, calory"
						+ ", carbo, protein, fat, sugar, natrium, chole, fattyacid"
						+ ", transfat, maker, material, img, allergy)" + "values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
				stmt = con.prepareStatement(sql);
				int idx = 1;
				stmt.setInt(idx++, f.getCode());
				stmt.setString(idx++, f.getName());
				stmt.setDouble(idx++, f.getSupportpereat());
				stmt.setDouble(idx++, f.getCalory());
				stmt.setDouble(idx++, f.getCarbo());
				stmt.setDouble(idx++, f.getProtein());
				stmt.setDouble(idx++, f.getFat());
				stmt.setDouble(idx++, f.getSugar());
				stmt.setDouble(idx++, f.getNatrium());
				stmt.setDouble(idx++, f.getChole());
				stmt.setDouble(idx++, f.getFattyacid());
				stmt.setDouble(idx++, f.getTransfat());
				stmt.setString(idx++, f.getMaker());
				stmt.setString(idx++, f.getMaterial());
				stmt.setString(idx++, f.getImg());
				stmt.setString(idx++, getAllergy(f.getMaterial()));
				stmt.executeUpdate();
			}
			System.out.println("parsing 완료");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(stmt);
			DBUtil.close(con);
		}
	}

	private static String getAllergy(String mat) {
		String[] allergys={"대두","땅콩","우유","게","새우","참치","연어","쑥","소고기","닭고기","돼지고기","복숭아","민들레","계란흰자"};
		String aller = "";
		for (String str : allergys) {
			if(mat.contains(str)) aller += str+ " "; 
		}
		return aller;
	}
}

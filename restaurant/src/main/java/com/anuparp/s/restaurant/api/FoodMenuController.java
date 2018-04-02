package com.anuparp.s.restaurant.api;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.anuparp.s.restaurant.RestaurantRepository;

@RestController
@RequestMapping("/api")
public class FoodMenuController {

	@Autowired
    private RestaurantRepository repo;
	
	@RequestMapping("/foodmenu")
	public List<Map<String, Object>> foodtype() {
		String sql = "SELECT m.*, t.foodtype_name FROM food_menu m left join food_type t on m.foodtype_code = t.foodtype_code ORDER BY m.food_id";
		List<Map<String, Object>> list = repo.query(sql);
		return list;
	}
	
	@RequestMapping(value="/foodmenu/{food_id}", method = RequestMethod.GET)
	public Map<String, Object> getFoodmenu(@PathVariable("food_id") String foodMenu) {
		Map<String, Object> mapParam = new HashMap();
		mapParam.put("food_id", foodMenu);
		
		String sql = "SELECT * FROM food_menu WHERE food_id = :food_id";
		List<Map<String, Object>> list = repo.query(sql, mapParam);
		return list.get(0);
	}
	
	@RequestMapping(value="/foodmenu", method = RequestMethod.POST)
	public int insertFoodmenu(@RequestBody Map<String, Object> map) {
		
		String sql = "INSERT INTO food_menu (food_id, foodtype_code, food_name, food_price) VALUES "
				+ "(:food_id, :foodtype_code, :food_name, :food_price)";
		int result = repo.execute(sql, map);
		
		return result;
	}
	
	@RequestMapping(value="/foodmenu/{food_id}", method = RequestMethod.PUT)
	public int updateFoodmenu(
			@PathVariable("food_id") int foodId,  
			@RequestBody Map<String, Object> map) {
		
		map.put("food_id", foodId);
		String sql = "UPDATE food_menu SET "
				+ "food_name = :food_name, foodtype_code = :foodtype_code, food_price = :food_price "
				+ "WHERE food_id = :food_id";
		int result = repo.execute(sql, map);
		
		return result;
	}
	
	@RequestMapping(value="/foodmenu/{food_id}", method = RequestMethod.DELETE)
	public int deleteFoodmenu(
			@PathVariable("food_id") String foodId,  
			@RequestBody Map<String, Object> map) {
		
		map.put("food_id", foodId);
		String sql = "DELETE FROM food_menu WHERE food_id = :food_id";
		int result = repo.execute(sql, map);
		
		return result;
	}

}

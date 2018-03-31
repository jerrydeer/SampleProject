package com.anuparp.s.restaurant.api;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
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

}

package com.anuparp.s.restaurant.api;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.anuparp.s.restaurant.RestaurantRepository;

@RestController
@RequestMapping("/api")
public class FoodTypeController {
	
	@Autowired
    private RestaurantRepository repo;
	
	@RequestMapping("/foodtype")
	public List<Map<String, Object>> foodtype() {
		String sql = "SELECT * FROM food_type";
		List<Map<String, Object>> list = repo.query(sql);
		return list;
	}
	
	

}
